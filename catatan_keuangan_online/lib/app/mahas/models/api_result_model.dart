class ApiResultModel {
  bool success = true;
  dynamic body;
  String? message;

  ApiResultModel(int statusCode, this.body) {
    if (statusCode == 200) {
      success = true;
    } else {
      success = false;
      if (statusCode == 500) {
        message = "Internal Server Error";
      } else if (body is String) {
        message = body;
      }
    }
  }

  ApiResultModel.error(this.message, {this.success = false});
}
