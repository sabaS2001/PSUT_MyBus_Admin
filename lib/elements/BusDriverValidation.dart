mixin InputValidationBusDriversMixin {
  //regression expression for first name and last name
  bool isNameValid(String name){
    const pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }
  //regression expression for id
  bool isIDValid(String bdId) {
    const pattern = r'^\d+$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(bdId) && bdId.length == 8;
  }
  //regression expression for employee email
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
  //regression expression for employee password
  bool isPasswordValid(String password) {
    return password.length == 8;
  }
  //regression expression for employee phone number
  bool isPhoneNumberValid(String password) {
    const pattern = r'^\+962\d{9}$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(password);
  }
  //regression expression for bus number
  bool isBusNumberValid(String busNumber) {
    return busNumber.length == 2 || busNumber.length == 1;
  }
  //regression expression for bus line
  bool isBusLineValid(String busLine) {
    if(busLine == 'Tabarbour' || busLine == 'Marj Al Hammam' || busLine == 'Madinah '){
      return true;
    }
    else {
      return false;
    }
  }

}