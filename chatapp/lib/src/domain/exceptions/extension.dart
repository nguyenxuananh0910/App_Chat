extension Validation on String? {
  String? checkEmpty(String message) {
    if (this?.isEmpty ?? true) {
      return message;
    }
    return null;
  }
}
