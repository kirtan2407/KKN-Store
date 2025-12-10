class AddressModel {
  String id;
  String name;
  String phoneNumber;
  String street;
  String postalCode;
  String city;
  String state;
  String country;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    this.selectedAddress = true,
  });

  static AddressModel empty() => AddressModel(id: '', name: '', phoneNumber: '', street: '', postalCode: '', city: '', state: '', country: '');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'street': street,
      'postal_code': postalCode,
      'city': city,
      'state': state,
      'country': country,
      'is_selected': selectedAddress,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return AddressModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      street: data['street'] ?? '',
      postalCode: data['postal_code'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['is_selected'] ?? false,
    );
  }
}
