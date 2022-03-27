class User {
  String? username;
  String? password;
  String? profilePicture;
  User({this.username, this.password, this.profilePicture});
}

var user = User(username: 'default', profilePicture: 'images/user-profile-picture.jpg');
