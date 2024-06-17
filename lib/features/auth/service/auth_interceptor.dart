import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:nutrobo/core/logger.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';

class AuthInterceptor implements Interceptor {
  final AuthService auth;

  const AuthInterceptor({required this.auth});

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = applyHeader(
        chain.request,
        HttpHeaders.authorizationHeader,
        'Bearer ${await auth.getToken()}',
    // Do not override existing header
    override: false,
    );

    log(
    '[AuthInterceptor] accessToken: ${chain.request.headers[HttpHeaders.authorizationHeader]}',
    );

    return chain.proceed(request);
  }
}