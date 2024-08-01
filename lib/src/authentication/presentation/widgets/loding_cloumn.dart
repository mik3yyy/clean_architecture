import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingColumn extends StatefulWidget {
  const LoadingColumn({super.key, required this.message});
  final String message;
  @override
  State<LoadingColumn> createState() => _LoadingColumnState();
}

class _LoadingColumnState extends State<LoadingColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.message),
        const CircularProgressIndicator(),
      ],
    );
  }
}
