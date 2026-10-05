import 'dart:io';

void main() {
  final file = File('patient_app/lib/core/network/dio_client.dart');
  var content = file.readAsStringSync();
  
  content = content.replaceAll(
    "options.headers['Authorization'] = 'Bearer \';",
    "options.headers['Authorization'] = 'Bearer \';\n        } else if (kDevSkipAuth) {\n          if (options.method == 'GET') {\n             if (options.path.endsWith('/prescriptions') || \n                 options.path.contains('/medicines/') || \n                 options.path.endsWith('/appointments')) {\n                 return handler.resolve(Response(requestOptions: options, statusCode: 200, data: []));\n             }\n             return handler.resolve(Response(requestOptions: options, statusCode: 200, data: {}));\n          }\n          return handler.resolve(Response(requestOptions: options, statusCode: 200, data: {}));"
  );

  file.writeAsStringSync(content);
}
