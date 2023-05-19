import 'package:flutter/foundation.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';


Future<Uint8List> uploadFile(dynamic event, DropzoneViewController controller) async {

  final name = event.name;
    final String mime = await controller.getFileMIME(event);
    final int size = await controller.getFileSize(event);
    final String url = await controller.createFileUrl(event);
    final Uint8List data = await controller.getFileData(event);

    debugPrint("Name: $name");
    debugPrint("Mime: $mime");
    debugPrint("Size: ${size / (1024 * 1024)}");
    debugPrint("URL: $url");

    return data;
  }
