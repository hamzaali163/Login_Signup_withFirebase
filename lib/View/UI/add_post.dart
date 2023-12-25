import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final firebaseref = FirebaseDatabase.instance.ref('posts');
  final postController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final postprovider = Provider.of<GeneralUtils>(
      context,
    );
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Add Posts",
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
                  final title =
                      (DateTime.now().millisecondsSinceEpoch.toString());
                  if (_formkey.currentState!.validate()) {
                    postprovider.progressindic(true);
                    firebaseref
                        .child(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      'id': title,
                      'title': postController.text.toString()
                    }).then((value) {
                      postprovider.progressindic(false);
                      GeneralUtils().successfulmessage("Post Created", context);
                    }).onError((error, stackTrace) {
                      debugPrint(error.toString());
                      GeneralUtils()
                          .showerrormessage(error.toString(), context);
                      postprovider.progressindic(false);
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
