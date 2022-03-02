import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Images {
  File image = [] as File;
  Images({required this.image});
}

class ListImages {
  List<Images> _list = [];
  List<Images> get list => _list;
}
