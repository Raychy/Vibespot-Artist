import 'package:google_place/google_place.dart';

import 'address.dart';

mixin PlaceMixin {
  Address placeToAddress(DetailsResult place) {
    String country = '';
    String state = '';
    String city = '';
    String zip = '';
    String street = '';
    String streetNumber = ''; 
    // String localGovt = '';
    // print(place.formattedAddress);
    // print(place.adrAddress);
    // print(place.businessStatus);

    place.addressComponents?.forEach((c) {
      print('${c.longName}, ${c.types}');
      switch (c.types![0]) {
        case 'street_number':
          streetNumber = c.longName ?? '';
          break;
        case 'route':
          street = c.longName ?? '';
          break;
        case 'neighborhood': 
        case 'locality':
          city = c.longName ?? '';
          break;
        case 'administrative_area_level_1':
          state = c.longName ?? '';
          break;
        // case 'administrative_area_level_2':
        //   localGovt = c.longName ?? '';
        //   break;
        case 'postal_code':
          zip = c.longName ?? '';
          break;
        case 'country':
          country = c.longName ?? '';
          break;
      }
    });

    return Address(
        city: city,
        // lga:localGovt,
        country: country,
        state: state,
        street: street,
        streetNumber: streetNumber,
        zip: zip,
        
        latitude: '${place.geometry?.location?.lat ?? ''}',
        longitude: '${place.geometry?.location?.lng ?? ''}');
  }
}
