class BaseResp<T> {
  int code;
  T data;
  String token;
  String message;

  BaseResp(this.code, this.data, this.token, this.message);

  bool get success => code == 200;
}