abstract class UploadService {
  Future<String?> upload(String path, [String folderName]);

  void delete(String path);
}
