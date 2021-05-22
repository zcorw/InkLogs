import 'dart:io';

import 'package:dio/dio.dart';

final Dio appApiDio = Dio(BaseOptions(
    baseUrl: 'https://api.imink.jone.wang',
    responseType: ResponseType.json,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      HttpHeaders.userAgentHeader: 'imink/81 CFNetwork/1220.1 Darwin/20.3.0'
    }));
