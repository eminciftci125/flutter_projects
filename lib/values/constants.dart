class Constants {
  static const String NAME = "Name";
  static const String EMAIL = "Email";
  static const String PASSWORD = "Password";
  static const String PASSWORD_CONFIRMATION = "Password Confirmation";
  static const String LOGIN = "Login";
  static const String REGISTER = "Register";
  static const String SUBMIT = "Submit";
  static const String BACK_TO_LOGIN = "Back to Login";

  static const String INVALID_EMAIL = "ERROR_INVALID_EMAIL";
  static const String USER_NOT_FOUND = "ERROR_USER_NOT_FOUND";
  static const String WRONG_PASSWORD = "ERROR_WRONG_PASSWORD";

  static const String MSG_INVALID_EMAIL = "Invalid email";
  static const String MSG_USER_NOT_FOUND = "Incorrect email/password";
  static const String MSG_EMPTY_FIELDS = "Email or password can not be empty";
  static const String MSG_WRONG_PASSWORD = "Password is incorrect";
  static const String MSG_ERROR_OCCURED = "Error occurred";
  static const String INVALID_PASSWORD = "Password must be 6-16 characters";
  static const String EMPTY_NAME = "Name can not be empty";
  static const String NAME_BOUNDARY = "Name can not be more than 20 characters";
  static const String PASSWORD_MATCH_ERROR = "Passwords do not match";

  static const Pattern VALID_MAIL_PATTERN =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
