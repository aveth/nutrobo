import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:nutrobo/features/chat/model/send_message.dart';
import 'package:nutrobo/features/chat/model/thread.dart';
import 'package:nutrobo/features/meals/model/food.dart';
import 'package:nutrobo/features/profile/model/nutrobo_user.dart';

part 'nutrobo_api.chopper.dart';

@ChopperApi(baseUrl: 'v1')
abstract class NutroboApi extends ChopperService {

  static NutroboApi create([ChopperClient? client]) => _$NutroboApi(client);

  @Get(path: 'user/get-profile')
  Future<Response<NutroboUser>> getProfile();

  @Post(path: 'assistant/send-message/{threadId}')
  Future<Response<Thread>> sendMessage(@path String threadId, @body SendMessage message);

  @Post(path: 'assistant/send-barcode/{threadId}')
  Future<Response<Thread>> sendBarcode(@path String threadId, @body SendMessage message);

  @Post(path: 'assistant/send-nutrition-info/{threadId}')
  Future<Response<Thread>> sendNutritionInfo(@path String threadId, @body Food food);

  @Post(path: 'assistant/create-thread', optionalBody: true)
  Future<Response<Thread>> createThread();

  @Get(path: 'assistant/get-thread/{threadId}')
  Future<Response<Thread>> getThread(@path String threadId);

  @Get(path: 'food/get-by-barcode/{barcode}')
  Future<Response<Food>> getByBarcode(@path String barcode);

}