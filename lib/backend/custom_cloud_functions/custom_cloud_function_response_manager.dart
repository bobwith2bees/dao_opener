import '/backend/schema/structs/index.dart';

class MicCheckCloudFunctionCallResponse {
  MicCheckCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
