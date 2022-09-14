 
// import 'package:cloudinary_sdk/cloudinary_sdk.dart';
// import 'package:get_it/get_it.dart';
// import 'package:vsartist/core/env.dart';
// import 'package:vsartist/services/upload/upload_service.dart';

// class CloudinaryUploadService extends UploadService {
//   final cloudinary = Cloudinary(GetIt.I<Env>().uploadApiKey,
//       GetIt.I<Env>().uploadSecret, GetIt.I<Env>().uploadRegion);

//   @override
//   void delete(String url) {
//       cloudinary.deleteFile(
//       url: url,
//       resourceType: CloudinaryResourceType.video, 
//     );
//   }

//   @override
//   Future<String?> upload(String path) async {
//     final response = await cloudinary.uploadFile(
//       filePath: path,
//       resourceType: CloudinaryResourceType.video,
//       folder:GetIt.I<Env>().uploadBucketName // 'backup',
//     );
//     return response.secureUrl;
//   }
// }
