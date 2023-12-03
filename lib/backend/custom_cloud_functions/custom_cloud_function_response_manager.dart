import '/backend/schema/structs/index.dart';

class VerifyProofCloudFunctionCallResponse {
  VerifyProofCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
    this.resultAsString,
    this.data,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
  String? resultAsString;
  String? data;
}

class GenerateProofRequestCloudFunctionCallResponse {
  GenerateProofRequestCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
    this.resultAsString,
    this.data,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
  String? resultAsString;
  String? data;
}
