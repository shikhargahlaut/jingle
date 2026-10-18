import 'package:flutter/material.dart';

class GenreModel {
  final String id;
  final String name;
  final List<Color> colors;
  final String? bgImageUrl;

  const GenreModel({
    required this.id,
    required this.name,
    required this.colors,
    this.bgImageUrl,
  });
}
