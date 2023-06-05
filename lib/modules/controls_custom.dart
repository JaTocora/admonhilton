import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom {
  TextFormField getCustomTextFormField(
      {String labelValue = "",
      String hintValue = "",
      bool? validation,
      TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      TextStyle? textStyle,
      String? validationErrorMsg,
      int? maxLines,
      bool? enabled,
      bool readOnly = false,
      Widget? prefixIcon,
      String? initialValue}) {
    TextFormField textFormField = TextFormField(
      keyboardType: keyboardType,
      style: textStyle,
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (validation!) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelValue,
          hintText: hintValue,
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    return textFormField;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  // static Future<dynamic> loadImage(BuildContext context, String image) async {
  static Future<dynamic> loadImage(String image) async {
    try {
      final img = await FirebaseStorage.instance
          .ref('pictures_room')
          .child(image)
          .getDownloadURL();
      return img;
    } catch (e) {
      Text('Error al obtener la URL de descarga de la imagen: $e');
      return null; // O realiza alguna otra acción en caso de error
    }
  }
}
