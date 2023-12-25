import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireStoreAddData extends StatefulWidget {
  const FireStoreAddData({super.key});

  @override
  State<FireStoreAddData> createState() => _FireStoreAddDataState();
}

class _FireStoreAddDataState extends State<FireStoreAddData> {
  final postController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance.collection("ref");

  @override
  Widget build(BuildContext context) {
    final postprovider = Provider.of<GeneralUtils>(
      context,
    );
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Text(
            "Add data firestore",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formkey,
                child: TextFormField(
                  maxLines: 4,
                  controller: postController,
                  decoration: const InputDecoration(
                      hintText: "Add post", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter text';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: "Submit",
                  loading: postprovider.load,
                  ontap: () {
                    final id =
                        (DateTime.now().millisecondsSinceEpoch.toString());
                    if (_formkey.currentState!.validate()) {
                      postprovider.progressindic(true);
                      firebase.doc(id).set({
                        'id': id,
                        'title': postController.text,
                      }).then((value) {
                        GeneralUtils()
                            .successfulmessage("Post uploaded", context);
                        postprovider.progressindic(false);
                      }).onError((error, stackTrace) {
                        GeneralUtils()
                            .showerrormessage(error.toString(), context);
                        postprovider.progressindic(false);
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
