class User {
  String name, email, bio, phone, photo, uid;
  List<dynamic> saved, liked;
  dynamic joinedDate;
  User({
    this.name,
    this.uid,
    this.email,
    this.liked,
    this.joinedDate,
    this.photo,
    this.phone,
    this.saved,
  });
}
