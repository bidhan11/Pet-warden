import 'package:get/get.dart';

class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? checkPhoneField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 10)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? checkOptionalPhoneField(String? fieldContent) {
    fieldContent!.trim();
    if ((fieldContent.isNotEmpty) && !(fieldContent.isNumericOnly && fieldContent.length == 10)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? checkFullName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return "This field is required";
    }

    List<String> nameParts = fullName.trim().split(" ");
    if (nameParts.length < 2) {
      return "Invalid full name";
    }

    if (!nameParts.every((part) => RegExp(r'^[a-zA-Z]+$').hasMatch(part))) {
      return "Invalid characters in full name";
    }

    return null;
  }

  static String? checkPasswordField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (fieldContent.length < 8) {
      return 'The password should be at least 8 digits';
    }

    return null;
  }

  static String? checkUsernameField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (fieldContent.length < 3) {
      return 'The Username should be at least 3 digits';
    } else if (fieldContent.contains(' ')) {
      return 'Username cannot contain spaces';
    }

    return null;
  }

  static String? checkConfirmPassword(String? password, String? fieldContent) {
    var checkPassword = checkPasswordField(fieldContent);
    if (checkPassword != null) {
      return checkPassword;
    }

    if (password != fieldContent!) {
      return "Password does not match";
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(fieldContent.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  // static String? checkOptionalEmailField(String? fieldContent) {
  //   fieldContent!.trim();
  //   if ((fieldContent.isNotEmpty) && !GetUtils.isEmail(fieldContent)) {
  //     return 'Invalid email address';
  //   }
  //   return null;
  // }

  static String? checkPinField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 5)) {
      return 'Invalid OTP';
    }
    return null;
  }
}
