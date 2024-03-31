import 'dart:async';

import 'package:assistant_openai/common/ai/models/agentModel.dart';
import 'package:assistant_openai/common/ai/models/threadsmodel.dart';
import 'package:assistant_openai/openaiassistant.dart';
import 'package:nutrobo/environment.dart';
import 'package:nutrobo/extensions/cubit.dart';

class GptSdk {

  final OpenAIAssistant _client;
  final Environment environment;

  AssistantModel? _assistant;
  ThreadModel? _thread;

  BasicCubit<bool> isInitialized = false.toCubit();
  BasicCubit<String> responseMessage = BasicCubit("How many I help you today?");

  GptSdk({required this.environment}):
    _client = OpenAIAssistant(
        apiKey: environment.gptApiKey,
        organizationID: environment.gptOrgId
    ) {
    _init();
  }

  Future<void> _init() async {
    _assistant = await _client.assistant.retrieve(environment.nutroboAssistantId);
    _thread = await _client.threads.createEmptyThread();
    isInitialized.updateValue(true);
  }

  Future<void> sendMessage(String msg) async {
    var threadId = _thread?.id;
    if (!isInitialized.state || threadId == null) {

    } else {
      _thread = await _client.threads.createWithMessages(NewMessageThreadModel(
          messages: [
            Message(
              role: "user",
              content: msg
            )
          ]
      ));
    }
  }

}