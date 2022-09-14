// import 'dart:io';

// import 'package:simple_s3/simple_s3.dart';

// import 'upload_service.dart';

// class AwsUploadService extends UploadService {
//   SimpleS3 _simpleS3 = SimpleS3();

//   Future<String?> upload(String path) async {
//     var file = File(path);
//     if (!(await file.exists())) return null;
//     return await _simpleS3.uploadFile(
//         file, //Selected File
//         'backuptest010/dev', // Your Bucket Name
//         "us-east-1:2fd74656-b3de-4159-887f-aa62153eb834", // Your POOL ID
//         AWSRegions.usEast1 // S3 server region
//         );
//   }

//   void delete(String path) async {
//     var file = File(path);
//     if (!(await file.exists())) return;
//     await SimpleS3.delete(
//         file.path, //Selected File
//         'backuptest010/dev', // Your Bucket Name
//         "us-east-1:2fd74656-b3de-4159-887f-aa62153eb834", // Your POOL ID
//         AWSRegions.usEast1 // S3 server region
//         );
//   }
// }
