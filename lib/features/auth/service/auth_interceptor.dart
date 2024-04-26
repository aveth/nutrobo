import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';

class AuthInterceptor implements RequestInterceptor {
  final AuthService auth;

  const AuthInterceptor({required this.auth});

  @override
  FutureOr<Request> onRequest(Request request) async {
    final updatedRequest = applyHeader(
      request,
      HttpHeaders.authorizationHeader,
      'Bearer ${await auth.getToken()}',
      // Do not override existing header
      override: false,
    );

    debugPrint(
      '[AuthInterceptor] accessToken: ${updatedRequest.headers[HttpHeaders.authorizationHeader]}',
    );

    return updatedRequest;
  }
}