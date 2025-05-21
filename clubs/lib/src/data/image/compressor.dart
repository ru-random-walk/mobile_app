import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  Future<Uint8List> testComporessList(Uint8List list, int quality) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      quality: quality,
    );
    log('Compressed image size: ${result.length} from ${list.length}');
    return result;
  }
}
