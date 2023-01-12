import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/kf_movie_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class KFWatchList extends StatefulWidget {
  const KFWatchList({Key? key}) : super(key: key);

  @override
  State<KFWatchList> createState() => _KFWatchListState();
}

class _KFWatchListState extends State<KFWatchList> {
  String? get uid => FirebaseAuth.instance.currentUser?.uid;
  DatabaseReference get db => FirebaseDatabase.instance.ref('users/$uid');

  List<DataSnapshot> data = [];

  @override
  void initState() {
    if (uid != null) {
      db.onValue.listen((DatabaseEvent event) {
        data = event.snapshot.children.toList();
        log("$data");
        setState(() {});
      });
    }
    super.initState();
  }

  String query(index) => data[index].child('query').value.toString();
  String year(index) => data[index].child('year').value.toString();
  String homeUrl(index) => data[index].child('homeUrl').value.toString();
  String type(index) => data[index].child('type').value.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watch list'),
      ),
      body: data.isEmpty
          ? Center(
              child: Text(
                  style: boldTextStyle(color: white),
                  'You watch list is empty.'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) => GestureDetector(
                    onTap: () => KFMovieDetailScreen(
                            homeUrl: homeUrl(index),
                            type: type(index),
                            query: query(index))
                        .launch(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${index + 1}'),
                              6.width,
                              Text(
                                query(index),
                                style: boldTextStyle(color: white),
                              )
                            ],
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (_, index) => 20.height,
              itemCount: data.length),
    );
  }
}
