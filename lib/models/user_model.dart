class UserModel{
  final int id;
  final String name;
  final String username;
  final String email;
  final String profile_image;
  final String address;

  UserModel(
      {required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.profile_image,
        required this.address});
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
      id: json['id'],
      name: json['name'] ?? "First Name",
      username: json['username'] ?? "User Name",
      email: json['email'],
      profile_image: json["profile_image"]?? "https://randomuser.me/api/portraits/men/1.jpg",
      address: json["address"] ?? "Address",
    );
  }
}