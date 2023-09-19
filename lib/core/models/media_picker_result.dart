import 'dart:io';

abstract class MediaPickerResult {}

class MediaPickedSuccessfully extends MediaPickerResult {
  final String fileType;

  final File mediaFile;

  MediaPickedSuccessfully({
    required this.fileType,
    required this.mediaFile,
  });
}

class MediaPickerCanceled extends MediaPickerResult {}

class ErrorWhilePickingMedia extends MediaPickerResult {}
