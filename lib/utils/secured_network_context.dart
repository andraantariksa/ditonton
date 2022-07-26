import 'dart:io';

import 'package:flutter/services.dart';

Future<SecurityContext> securedNetworkContext() async {
  var certificate = await rootBundle.load("assets/cert/cert.pem");
  var securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(certificate.buffer.asInt8List());
  return securityContext;
}
