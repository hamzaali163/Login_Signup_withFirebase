import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';

class FireBaseListView extends StatefulWidget {
  const FireBaseListView({super.key});

  @override
  State<FireBaseListView> createState() => _FireBaseListViewState();
}

class _FireBaseListViewState extends State<FireBaseListView> {
  final _auth = FirebaseAuth.instance;
  final seachcontrl = TextEditingController();
  final editcontrl = TextEditingController();
  final firebase = FirebaseFirestore.instance.collection("ref").snapshots();
  final ref1 = FirebaseFirestore.instance.collection("ref");
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Text(
            'FireStore View',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.pushNamed(context, RoutesNames.mainScreen);
                  }).onError((error, stackTrace) {
                    GeneralUtils().snackkbar(error.toString());
                  });
                },
                icon: const Icon(Icons.logout_outlined)),
            const SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.uploadimae);
                },
                child: const Icon(Icons.camera)),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: seachcontrl,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {});
                  },
                )),
            StreamBuilder(
                stream: firebase,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.purple,
                    ));
                  } else if (snapshot.hasError) {
                    const Center(
                      child: Text("Error Occured"),
                    );
                  }

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final title =
                                snapshot.data!.docs[index]['title'].toString();
                            final id =
                                snapshot.data!.docs[index]['id'].toString();

                            return ListTile(
                              title: Text(snapshot.data!.docs[index]['title']
                                  .toString()),
                              subtitle: Text(
                                  snapshot.data!.docs[index]['id'].toString()),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      leading: InkWell(
                                          onTap: () {
                                            debugPrint("tap");
                                            Navigator.pop(context);
                                            showmydialog(title, id);
                                          },
                                          child: const Icon(Icons.edit)),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      leading: InkWell(
                                          onTap: () {
                                            debugPrint("tap");
                                            ref1.doc(id).delete();
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.delete)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }));
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesNames.firestoreladdData);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> showmydialog(String title, String id) async {
    editcontrl.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            // ignore: avoid_unnecessary_containers
            content: Container(
              child: TextField(
                controller: editcontrl,
                decoration: const InputDecoration(
                  hintText: "Enter text",
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref1.doc(id).update({
                      'title': editcontrl.text,
                    });
                  },
                  child: const Text("Submit")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }
}
