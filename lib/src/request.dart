part of httprequest;


abstract class NetBuilder {
  Future<Requester> createRequester();
}

abstract class Requester {
  static final String TYPE_POST = "POST";
  static final String TYPE_GET = "GET";
  static final String TYPE_PUT = "PUT";
  static final String TYPE_DELETE = "DELETE";
  Future<Response> request(String type, String url, {Object data: null, Map<String, String> headers: null});
  Future<Object> srcToMultipartData(String src);
}

class Response {
  int _status;
  int get status => _status;
  ByteBuffer _response;
  ByteBuffer get response => (_response == null ? new Uint8List.fromList([]) : _response);
  Map<String, String> _headers = {};
  Map<String, String> get headers => _headers;
  Response(this._status, Map<String, String> headers, this._response) {
    _headers.addAll(headers);
  }
}
