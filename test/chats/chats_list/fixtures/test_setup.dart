// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

Future<void> commonSetUpAll() async {
  HttpOverrides.global = null;
  registerFallbackValue(GetChatsEvent(resetPagination: true));
  registerFallbackValue(ChatsListLoading());
}

Future<void> commonsetUp() async {
  await loadAppFonts(); 
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  binding.window.physicalSizeTestValue = const Size(413, 732);
  binding.window.devicePixelRatioTestValue = 1.0;   
}

Future<void> commontearDown() async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  binding.window.clearPhysicalSizeTestValue();
  binding.window.clearDevicePixelRatioTestValue();
}
  
