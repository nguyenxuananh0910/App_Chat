extension StringX on String {
  String get initialWords {
    try {
      List<String> words = split(' '); // Use 'words' for clarity
      // Handle single-word case:
      if (words.length == 1) {
        return words.first.isNotEmpty ? words.first[0] : '';
      }
      // Handle multi-word cases:
      int lastIndex = words.length - 1;
      // Get the first and second (if available) initials:
      String firstInitial =
          words[lastIndex].isNotEmpty ? words[lastIndex][0] : '';
      String secondInitial = (lastIndex >= 1 && words[lastIndex - 1].isNotEmpty)
          ? words[lastIndex - 1][0]
          : '';

      return secondInitial + firstInitial;
    } catch (e) {
      return ''; // Return an empty string on errors
    }
  }
}
