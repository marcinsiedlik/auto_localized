class FileFormatException extends FormatException {
  FileFormatException(String filePath, [dynamic source, int offset])
      : super('Unable to decode file: $filePath', source, offset);
}
