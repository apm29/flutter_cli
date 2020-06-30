class Config {
  static const BaseUrl = 'https://jiayupearl.shop/';
  static const ConnectTimeout = 10000;
  static const ReceiveTimeout = 20000;

  static const AuthorizationHeader = "Authorization";
  static const ContentTypeHeader = "content-type";
  static const ContentTypeFormUrl =
      "application/x-www-form-urlencoded";
  static const ContentTypeFormData = "multipart/form-data";
  static const ContentTypeText = "text/plain";

  static const SuccessCode = 200;
  static const StatusKey = 'Code';
  static const TokenKey = 'Token';
  static const MessageKey = 'Msg';
  static const DataKey = 'Data';
}