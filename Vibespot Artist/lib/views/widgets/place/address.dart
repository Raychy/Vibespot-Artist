class Address {
  final String country,
      state,
      city,
      zip,
      street,
      streetNumber,
      longitude,
      latitude,
      postalCode,
      lga;

  Address(
      {this.longitude = '',
      this.latitude = '',
      this.country = '',
      this.state = '',
      this.city = '',
      this.zip = '',
      this.street = '',
      this.postalCode = '',
      this.lga = '',
      this.streetNumber = ''});

  String get place =>
      '$streetNumber $street${streetNumber.isNotEmpty && street.isNotEmpty && city.isNotEmpty ? ',' : ''} $city ${city.isNotEmpty && state.isNotEmpty ? ',' : ''} $state ${state.isNotEmpty && country.isNotEmpty ? ',' : ''} $country  ';

  @override
  String toString() => {
        'lga': lga,
        'country': country,
        'state': state,
        'city': city,
        'zip': zip,
        'street': street,
        'streetNumber': streetNumber,
        'postalCode': postalCode,
        'longitude': longitude,
        'latitude': latitude,
      }.toString();
}
