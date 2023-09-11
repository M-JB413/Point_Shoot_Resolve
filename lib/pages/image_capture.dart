import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:point_shoot_resolve/pages/submit_form.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({super.key});

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File? _selectedImage;
  File? _compressedImage;

  Future<void> _takePicture() async {
    try {
      final imagePicker = ImagePicker();
      final takenImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (takenImage != null) {
        setState(() {
          _selectedImage = File(takenImage.path);
        });
        var result = await FlutterImageCompress.compressAndGetFile(
          _selectedImage!.absolute.path,
          _selectedImage!.path + "compressed.jpg",
          quality: 50,
        );
        setState(() {
          _compressedImage = File(result!.path);
        });

        // String imageURL = await uploadToFirebaseStorage();
        // Navigator.of(context).push(MaterialPageRoute(
        // builder: (context) => FillDetails(imageFile: _selectedImage, imageURL: imageURL)));

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FillDetails(imageFile: _compressedImage)));

        // Navigate to Postform screen
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => Postform(imageFile: _selectedImage),
        //   ),
        // );
      }
      // ... (existing code)
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  // Future<String> uploadToFirebaseStorage() async {
  //   var storage = FirebaseStorage.instance;
  //   final File imageLocal = _selectedImage!;
  //   String fileName = basename(imageLocal.path);
  //   TaskSnapshot taskSnapshot =
  //       await storage.ref("Uploads/$fileName").putFile(imageLocal);
  //   final String imageURL = await taskSnapshot.ref.getDownloadURL();
  //   return imageURL;
  // }

  Future<void> compress(File? image) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      image!.absolute.path,
      image.absolute.path,
      quality: 50,
    );
    setState(() {
      _selectedImage = File(result!.path);
    });
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      var result = await FlutterImageCompress.compressAndGetFile(
        _selectedImage!.absolute.path,
        _selectedImage!.absolute.path,
        quality: 50,
      );
      setState(() {
        _selectedImage = File(result!.path);
      });
      // String imageURL = await uploadToFirebaseStorage();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => FillDetails(imageFile: _selectedImage, imageURL: imageURL)));

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FillDetails(imageFile: _selectedImage)));

      // Navigate to Postform screen
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => Postform(imageFile: _selectedImage),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Capture Image"),
          backgroundColor: Colors.black),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                "assets/images/pick_image.svg",
                height: 155,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
                onPressed: () async {
                  _pickImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Pick Image",
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  _takePicture();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Capture Image",
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
}
