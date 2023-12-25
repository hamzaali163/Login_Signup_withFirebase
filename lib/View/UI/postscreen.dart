import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final firebaseref = FirebaseDatabase.instance.ref('posts');
  final seachcontrl = TextEditingController();
  final editcontrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Text(
            'Post',
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
                    Navigator.pushNamed(context, RoutesNames.loginscreen);
                  }).onError((error, stackTrace) {
                    GeneralUtils().snackkbar(error.toString());
                  });
                },
                icon: const Icon(Icons.logout_outlined))
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
            Expanded(
                child: FirebaseAnimatedList(
                    query: firebaseref,
                    itemBuilder: (context, snapshot, animation, index) {
                      final title = snapshot.child('title').value.toString();
                      final id = title;

                      if (seachcontrl.text.isEmpty) {
                        return ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.purple,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showmydialog(
                                          title,
                                          snapshot
                                              .child('id')
                                              .value
                                              .toString());
                                    },
                                    leading: const Icon(
                                      Icons.edit,
                                      color: Colors.purple,
                                    ),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      firebaseref.child(id).remove();
                                    },
                                    leading: const Icon(
                                      Icons.delete,
                                      color: Colors.purple,
                                    ),
                                  )),
                            ],
                          ),
                        );
                      } else if (title
                          .toLowerCase()
                          .contains(seachcontrl.text.toLowerCase())) {
                        return ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                        );
                      } else {
                        return Container();
                      }
                    })),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesNames.addpostScreen);
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
                    firebaseref
                        .child(id)
                        .update({'title': editcontrl.text.toLowerCase()});
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

// Expanded(
//     child: StreamBuilder(
//         stream: firebaseref.onValue,
//         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           } else {
//             Map<dynamic, dynamic> map =
//                 snapshot.data!.snapshot.value as dynamic;
//             List<dynamic> list = [];
//             list.clear();
//             list = map.values.toList();

//             return ListView.builder(
//                 itemCount: snapshot.data!.snapshot.children.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(list[index]['title']),
//                   );
//                 });
//           }
//         })),
