// ignore_for_file: prefer_typing_uninitialized_variables

class AppExpection implements Exception {
  final _message;
  final _prefix;
  AppExpection([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message,$_prefix';
  }
}

class FetchDataException extends AppExpection {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppExpection {
  BadRequestException([String? message])
      : super(message, 'Invalid equest'); //if route url not valid
}

class UnauthorizedException extends AppExpection {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized request');
}

class InvalidInputException extends AppExpection {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
