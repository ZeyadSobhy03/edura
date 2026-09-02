extension TextEx on String {
  String get initials {
    final parts = trim().split(' ');

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return parts.isNotEmpty && parts[0].isNotEmpty
        ? parts[0][0].toUpperCase()
        : '?';
  }

  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(trim());
  }

  bool get isValidPassword {
    return length >= 8;
  }
  bool get isValidPhoneNumber {
    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    return phoneRegex.hasMatch(trim());
  }
}
