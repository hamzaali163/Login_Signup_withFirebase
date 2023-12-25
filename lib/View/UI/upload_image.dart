import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Widgets/roundbutton.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();

  final source = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('posts');
  Future getgalleryimage() async {
    final pickedfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        debugPrint("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeneralUtils>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(
          "Upload Image",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              getgalleryimage();
            },
            child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : const Center(child: Icon(Icons.image))),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RoundButton(
                loading: provider.load,
                title: "Upload",
                ontap: () async {
                  provider.progressindic(true);
                  final id = DateTime.now().millisecondsSinceEpoch.toString();

                  firebase_storage.Reference ref =
                      firebase_storage.FirebaseStorage.instance.ref("/hamza/" +
                          DateTime.now().millisecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);

                  await Future.value(uploadTask).then((value) async {
                    var newurl = await ref.getDownloadURL();

                    databaseref.set(
                        {'id': id, 'title': newurl.toString()}).then((value) {
                      provider.progressindic(false);

                      GeneralUtils()
                          .successfulmessage("Image Uploaded", context);
                    }).onError((error, stackTrace) {
                      provider.progressindic(false);

                      GeneralUtils()
                          .showerrormessage(error.toString(), context);
                      provider.progressindic(false);
                    });
                  }).onError((error, stackTrace) {
                    provider.progressindic(false);

                    GeneralUtils().showerrormessage(error.toString(), context);
                  });
                }),
          )
        ],
      ),
    );
  }
}
