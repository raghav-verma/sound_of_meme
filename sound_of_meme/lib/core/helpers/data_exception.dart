sealed class DataException implements Exception {
  const DataException(
    this.message,
  );

  final String message;

  @override
  String toString() => 'App Exception ($runtimeType): \n$message';
}

class RemoteServerException extends DataException {
  const RemoteServerException(super.message);
}

class RemoteParsingException extends DataException {
  const RemoteParsingException(super.message);
}

class LocalParsingException extends DataException {
  const LocalParsingException(super.message);
}
