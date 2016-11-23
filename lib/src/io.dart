part of iover;

class IONetBuilder extends NetBuilder {
  Future<Requester> createRequester() async {
    return new IORequester();
  }
}

class IORequester extends Requester {
  Future<Response> request(String type, String url, {Object data: null, Map<String, String> headers: null}) async {
    if (headers == null) {
      headers = {};
    }
    io.HttpClient client = new io.HttpClient(context: io.SecurityContext.defaultContext);
    io.HttpClientRequest req = await client.openUrl(type, Uri.parse(url));
    for (String k in headers.keys) {
      req.headers.add(k, headers[k]);
    }
    req.followRedirects = true;
    if (data != null) {
      req.write(data);
    }
    io.HttpClientResponse res = await req.close();
    Map<String, List<String>> headerss = {};
    res.headers.forEach((String name, List<String> values) {
      headerss[name] = new List.from(values);
    });
    return new Response(res.statusCode, headerss, new typed.Uint8List.fromList(await res.single).buffer);
  }
}
