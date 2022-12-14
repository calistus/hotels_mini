class HotelModel {
  int? id;
  String? name;
  Location? location;
  int? stars;
  CheckIn? checkIn;
  CheckIn? checkOut;
  Contact? contact;
  List<String>? gallery;
  double? userRating;
  int? price;
  String? currency;

  HotelModel(
      {this.id,
      this.name,
      this.location,
      this.stars,
      this.checkIn,
      this.checkOut,
      this.contact,
      this.gallery,
      this.userRating,
      this.price,
      this.currency});

  HotelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    stars = json['stars'];
    checkIn =
        json['checkIn'] != null ? new CheckIn.fromJson(json['checkIn']) : null;
    checkOut = json['checkOut'] != null
        ? new CheckIn.fromJson(json['checkOut'])
        : null;
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    gallery = json['gallery'].cast<String>();
    userRating = json['userRating'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['stars'] = this.stars;
    if (this.checkIn != null) {
      data['checkIn'] = this.checkIn!.toJson();
    }
    if (this.checkOut != null) {
      data['checkOut'] = this.checkOut!.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['gallery'] = this.gallery;
    data['userRating'] = this.userRating;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}

class Location {
  String? address;
  String? city;
  double? latitude;
  double? longitude;

  Location({this.address, this.city, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class CheckIn {
  String? from;
  String? to;

  CheckIn({this.from, this.to});

  CheckIn.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class Contact {
  String? phoneNumber;
  String? email;

  Contact({this.phoneNumber, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
