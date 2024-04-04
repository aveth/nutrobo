import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:nutrobo/features/chat/model/send_message.dart';
import 'package:nutrobo/features/chat/model/thread.dart';

part 'nutrobo_api.chopper.dart';

@ChopperApi(baseUrl: 'v1')
abstract class NutroboApi extends ChopperService {

  static NutroboApi create([ChopperClient? client]) => _$NutroboApi(client);

  @Post(path: 'send-message')
  Future<Response<Thread>> sendMessage(@body SendMessage message);

  @Post(path: 'create-thread', optionalBody: true)
  Future<Response<Thread>> createThread();

  @Get(path: 'get-thread/{threadId}')
  Future<Response<Thread>> getThread(@path String threadId);

}