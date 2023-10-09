class AppUser {
  String name, email, phone, photo, uid;
  List<dynamic> saved, liked;
  dynamic joinedDate;
  AppUser({
    required this.name,
    required this.uid,
    required this.email,
    required this.liked,
    required this.joinedDate,
    required this.photo,
    required this.phone,
    required this.saved,
  });
}
