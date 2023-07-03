import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'base_conditional.dart';

/// Create a [IOConditional].
///
/// Used from conditional imports, matches the definition in `conditional_stub.dart`.
BaseConditional createConditional() => IOConditional();

/// A conditional for anything but browser.
class IOConditional extends BaseConditional {
  /// Returns [NetworkImage] if URI starts with http
  /// otherwise uses IO to create File
  @override
  ImageProvider getProvider(String uri, {Map<String, String>? headers}) {
    if (uri.startsWith('http')) {
      return NetworkImage(uri, headers: headers);
    } else if (uri.startsWith('data')) {
      final base64 = uri.split('base64,').last;
      return MemoryImage(base64Decode(base64));
    } else {
      return FileImage(File(uri));
    }
  }
}
