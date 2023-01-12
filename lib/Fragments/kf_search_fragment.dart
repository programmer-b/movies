import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:movies/Components/kf_search_text_field_component.dart';
import 'package:movies/Screens/kf_movie_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:http/http.dart' as http;

import '../Commons/kf_strings.dart';

class KFSearchFragment extends StatefulWidget {
  const KFSearchFragment({super.key});

  @override
  State<KFSearchFragment> createState() => _KFSearchFragmentState();
}

class _KFSearchFragmentState extends State<KFSearchFragment> {
  List<Map<String, String>> _sData = [];
  List<Map<String, String>> get sData => _sData;

  bool _loading = false;
  bool get loading => _loading;

  String? _mData;
  String? get mData => _mData;

  bool _conError = false;
  bool get conError => _conError;

  Future _searchMData(String q) async {
    _sData = [];
    _conError = false;
    await 0.seconds.delay;
    setState(() => _loading = true);
    final Map<dynamic, dynamic> body = {"q": q};
    Response response;
    try {
      response = await http.post(Uri.parse(kfMoviesSearchUrl),
          headers: searchMoviesHeader, body: body);
      _mData = response.body;

      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

      final doc = parse(_mData);
      final ul = doc.getElementsByClassName("mfeed")[0];
      final li = ul.getElementsByTagName("li");

      url(index) => li[index].getElementsByTagName('a')[0].attributes['href'];
      year(title) => title.substring(title.length - 6, title.length - 2);
      title(sdata, cName) =>
          sdata.getElementsByClassName(cName)[0].innerHtml.replaceAll(exp, "");

      int index = 0;

      if (li.isNotEmpty) {
        for (var sdata in li) {
          final bool isMovie = sdata.getElementsByClassName('it').isEmpty;
          if (isMovie) {
            final stitle = title(sdata, 'im');
            Map<String, String> sline = {
              "title": stitle,
              "year": year(stitle),
              "homeUrl": url(index)!,
              "type": "movie"
            };

            _sData.add(sline);
          } else {
            final String stitle = title(sdata, 'it');
            Map<String, String> sline = {
              "title": stitle,
              "year": year(stitle),
              "homeUrl": url(index)!,
              "type": "tv"
            };

            _sData.add(sline);
          }
        }
        index += 1;
      }

      return response.body;
    } on SocketException {
      _conError = true;
      return "";
    } catch (e) {
      log("ERROR", error: e);
      return "";
    } finally {
      await 0.seconds.delay;
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loading = false;
    _mData = null;
    _sData = [];
    _conError = false;
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          KFsearchTextFieldComponent(
            controller: controller,
            onSearch: () => _searchMData(controller.text),
            onChanged: (q) => _searchMData(q),
          ),
          loading
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView(
                  children: sData
                      .map((e) => ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -2),
                            leading: Icon(
                              e.type == 'movie' ? Icons.movie : Icons.tv,
                              color: Colors.white70,
                            ),
                            title: Text(e.title),
                            onTap: () => KFMovieDetailScreen(
                              homeUrl: e.homeUrl,
                              type: e.type,
                              year: e.year,
                              query: e.title
                                  .substring(0, e.title.length - 7)
                                  .trim(),
                            ).launch(context),
                          ))
                      .toList(),
                ).expand(),
        ],
      ),
    );
  }
}

extension _SDataExt on Map<String, String> {
  String get title => this['title']!;
  String get homeUrl => this['homeUrl']!;
  String get year => this['year']!;
  String get type => this['type']!;
}
