part of httprequest;

class MultipartItem {
  String name;
  String fileName;
  String contentType;
  String base64src;

  MultipartItem.fromBase64(this.name, this.fileName, this.contentType, this.base64src) {
  }

  String toString() {
    StringBuffer buffer = new StringBuffer();
    buffer.write("""Content-Disposition: form-data; name="${name}"; filename="${fileName}"\r\n""");
    buffer.write("""Content-Type: "${contentType}"\r\n""");
    buffer.write("""\r\n""");
    buffer.write(base64src);
    buffer.write("""\r\n""");
    return buffer.toString();
  }
}

class Multipart {
  List<int> bakeMultiPartFromBinary(List<MultipartItem> items) {
      StringBuffer buffer = new StringBuffer();
      String boundary = "--"+Uuid.createUUID().replaceAll("-","");
      buffer.write("""Content-Type: multipart/form-data; boundary=${boundary}\r\n""");
      buffer.write("""\r\n""");
      buffer.write("""${boundary}\r\n""");
      for(var item in items) {
        buffer.write(item.toString());
        buffer.write("""${boundary}\r\n""");
      }
      buffer.write("""\r\n""");
      return UTF8.encode(buffer.toString());
  }
}
