import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:nutrobo/features/chat/model/message.dart';
import 'package:nutrobo/features/chat/model/send_message.dart';
import 'package:nutrobo/features/chat/model/thread.dart';

part 'nutrobo_api.chopper.dart';

@ChopperApi(baseUrl: 'v1')
abstract class NutroboApi extends ChopperService {

  static NutroboApi create([ChopperClient? client]) => _$NutroboApi(client);

  @Post(path: 'assistant/send-message/{threadId}')
  Future<Response<Thread>> sendMessage(@path String threadId, @body SendMessage message);

  @Post(path: 'assistant/send-barcode/{threadId}')
  Future<Response<Thread>> sendBarcode(@path String threadId, @body SendMessage message);

  @Post(path: 'assistant/send-nutrition-info/{threadId}')
  Future<Response<Thread>> sendNutritionInfo(@path String threadId, @body SendMessage message);

  @Post(path: 'assistant/create-thread', optionalBody: true)
  Future<Response<Thread>> createThread();

  @Get(path: 'assistant/get-thread/{threadId}')
  Future<Response<Thread>> getThread(@path String threadId);

  @Get(path: 'assistant/get-barcode-message/{barcode}')
  Future<Response<Message>> getBarcodeMessage(@path String barcode);
}