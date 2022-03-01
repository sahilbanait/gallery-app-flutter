import 'dart:io';
import 'package:flutter/foundation.dart';

class Images {
  final File image;
  Images({required this.image});
}

class ListImages with ChangeNotifier {
  List<Images> _list = [];
  List<Images> get list => _list;
}
