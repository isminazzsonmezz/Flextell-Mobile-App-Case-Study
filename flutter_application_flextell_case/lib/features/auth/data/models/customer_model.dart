import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    int id;
    String firstName;
    String lastName;
    String phone;
    String email;
    String identityNumber;
    String passportNumber;
    DateTime birthDate;
    String country;
    String city;
    String district;
    String gender;
    String profession;
    String address;
    RelatedStaff relatedStaff;

    Customer({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.identityNumber,
        required this.passportNumber,
        required this.birthDate,
        required this.country,
        required this.city,
        required this.district,
        required this.gender,
        required this.profession,
        required this.address,
        required this.relatedStaff,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        identityNumber: json["identity_number"],
        passportNumber: json["passport_number"],
        birthDate: DateTime.parse(json["birth_date"]),
        country: json["country"],
        city: json["city"],
        district: json["district"],
        gender: json["gender"],
        profession: json["profession"],
        address: json["address"],
        relatedStaff: RelatedStaff.fromJson(json["related_staff"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "identity_number": identityNumber,
        "passport_number": passportNumber,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "country": country,
        "city": city,
        "district": district,
        "gender": gender,
        "profession": profession,
        "address": address,
        "related_staff": relatedStaff.toJson(),
    };
}

class RelatedStaff {
    int id;
    String name;
    String department;

    RelatedStaff({
        required this.id,
        required this.name,
        required this.department,
    });

    factory RelatedStaff.fromJson(Map<String, dynamic> json) => RelatedStaff(
        id: json["id"],
        name: json["name"],
        department: json["department"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department": department,
    };
}

