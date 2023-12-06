class Address{
  int? id;
  String fullName;
  String mobileNumber;
  String buildingName;
  String street;
  String state;
  int pinCode;
  String city;
  String addressType;

  Address({
    this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.buildingName,
    required this.street,
    required this.state,
    required this.pinCode,
    required this.city,
    required this.addressType
  });

  factory Address.fromMap(Map<String,dynamic> e) => Address(
      id: e["id"],
      fullName: e["fullName"],
      mobileNumber: e["mobileNumber"],
      buildingName: e["buildingName"],
      street: e["street"],
      state: e["state"],
      pinCode: e["pinCode"],
      city: e["city"],
      addressType: e["addressType"]);

  Map<String,dynamic> toMap() {
    return {
      "id" : id,
      "fullName" : fullName,
      "mobileNumber" : mobileNumber,
      "buildingName" : buildingName,
      "street" : street,
      "state" : state,
      "pinCode" : pinCode,
      "city" : city,
      "addressType" : addressType
    };
  }

}