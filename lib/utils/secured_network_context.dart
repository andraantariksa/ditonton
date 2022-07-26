import 'dart:io';

import 'package:flutter/services.dart';

Future<SecurityContext> securedNetworkContext() async {
  var certificate1 = await rootBundle.load("assets/cert/cert1.pem");
  var certificate2 = await rootBundle.load("assets/cert/cert2.pem");
  var securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(certificate1.buffer.asInt8List());
  securityContext.setTrustedCertificatesBytes(certificate2.buffer.asInt8List());
  return securityContext;
}
