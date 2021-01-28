import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  @override
  UploadState createState() => UploadState();
}

class UploadState extends State<Upload> {
  List<Widget> fileListThumb;
  List<File> fileList = List<File>();

  // Future<bool> httpSend(Map params) async {
  //   String endpoint = 'yourphpscript.php';
  //   return await http.post(endpoint, body: params).then((response) {
  //     print(response.body);
  //     if (response.statusCode == 201) {
  //       Map<String, dynamic> body = jsonDecode(response.body);
  //       if (body['status'] == 'OK') return true;
  //     } else
  //       return false;
  //   });
  // }

  List<Map> toBase64(List<File> fileList) {
    List<Map> s = List<Map>();
    if (fileList.length > 0)
      fileList.forEach((element) async {
        String _encodedImage = base64Encode(element.readAsBytesSync());
        Map a = {
          'fileName': basename(element.path),
          'encoded': base64Encode(element.readAsBytesSync())
        };
        print('encoded');
        await http.get('https://radreviews.online/app/REST/EasyRails/CreateTest?First_Name=Suman&Surname=chandan&EmailAddress=test@test.com&DocFile=$_encodedImage');
        print('API sent');
        s.add(a);
      });
    return s;
  }

  Future pickFiles() async {
    List<Widget> thumbs = List<Widget>();
    fileListThumb.forEach((element) {
      thumbs.add(element);
    });

    await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'bmp', 'pdf', 'doc', 'docx'],
    ).then(
      (files) {
        if (files != null && files.length > 0) {
          files.forEach((element) {
            List<String> picExt = ['.jpg', '.jpeg', '.bmp'];

            if (picExt.contains(extension(element.path))) {
              thumbs.add(
                Padding(
                  padding: EdgeInsets.all(1),
                  child: new Image.file(element),
                ),
              );
            } else
              thumbs.add(
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.insert_drive_file),
                        Text(extension(element.path))
                      ]),
                ),
              );
            fileList.add(element);
          });
          setState(() {
            fileListThumb = thumbs;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fileListThumb == null)
      fileListThumb = [
        InkWell(
          onTap: pickFiles,
          child: Container(child: Icon(Icons.add)),
        )
      ];
    final Map params = Map();
    //old final Map params = final Map params = new Map();
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploader"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: GridView.count(
            crossAxisCount: 4,
            children: fileListThumb,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('test');
          toBase64(fileList);
          // fileList.forEach((element) async {
          //   print(element.path);
          //   print('https://radreviews.online/app/REST/EasyRails/CreateTest?First_Name=Suman&Surname=chandan&EmailAddress=test@test.com&DocFile=');
          //   // await http.get('https://radreviews.online/app/REST/EasyRails/CreateTest?First_Name=Suman&Surname=chandan&EmailAddress=test@test.com&DocFile=$element');
          // });
          // List<Map> attch = toBase64(fileList);
          // params["attachment"] = jsonEncode(attch);
          // print(params["attachment"]);
          // httpSend(params).then((sukses) {
          //   if (sukses == true) {
          //     Flushbar(
          //       message: "success :)",
          //       icon: Icon(
          //         Icons.check,
          //         size: 28.0,
          //         color: Colors.blue[300],
          //       ),
          //       duration: Duration(seconds: 3),
          //       leftBarIndicatorColor: Colors.blue[300],
          //     ).show(context);
          //   } else
          //     Flushbar(
          //       message: "fail :(",
          //       icon: Icon(
          //         Icons.error_outline,
          //         size: 28.0,
          //         color: Colors.blue[300],
          //       ),
          //       duration: Duration(seconds: 3),
          //       leftBarIndicatorColor: Colors.red[300],
          //     ).show(context);
          // });
        },
        tooltip: 'Upload File',
        child: const Icon(Icons.cloud_upload),
      ),
    );
  }
}
