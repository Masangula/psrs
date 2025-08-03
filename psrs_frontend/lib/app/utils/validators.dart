class Validators {
  static String? validatePhoneNumber(String? phoneNumber) {
    final RegExp regex = RegExp(r'^0\d{9}$');
    if (phoneNumber!.isEmpty) {
      return 'Phone number cannot be empty.';
    }
    if (!regex.hasMatch(phoneNumber)) {
      return 'Invalid phone number format. Please use the format: 0xxxxxxxxxx';
    }

    return null;
  }

  static  String? validateInput(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Please enter a valid input (at least 3 characters)';
    }
    return null;
  }

  static  String? validateNIDA(String? value) {
    if (value == null || value.isEmpty || value.length < 20) {
      return 'Please enter a valid input (at least 20 characters)';
    }
    return null;
  }

 static String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  if (!emailRegex.hasMatch(email)) {
    return 'Invalid email format';
  }

  return null; // Email is valid
}

static String? validateContactPersonName(String? value) {
  final nameParts = value?.trim().split(' ');
  if (nameParts?.length != 2) {
    return 'Name should be in the format "First Name Last Name"';
  }

  final firstName = nameParts?[0].trim();
  final lastName = nameParts?[1].trim();

  if (firstName!.isEmpty || lastName!.isEmpty) {
    return 'Both first name and last name are required';
  }

  if (firstName.length <= 3 || lastName.length <= 3) {
    return 'Both first name and last name should have more than 3 characters';
  }

  return null; // Return null if the format and length requirements are met
}


}
