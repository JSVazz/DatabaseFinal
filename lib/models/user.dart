class user {
  late String email;
  late String password;
  late String username;

  user({
    required this.email,
    required this.password,
    required this.username,
  });

  // Getter methods for email, password, and username
  String get userEmail => email;
  String get userPassword => password;
  String get userUsername => username;

  set userEmail(String email) {
    // Perform email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw ArgumentError('Invalid email format');
    }
    this.email = email;
  }

  set userPassword(String password) {
    // Perform password strength validation
    if (password.length < 8) {
      throw ArgumentError('Password must be at least 8 characters long');
    }
    // You can add more password strength checks here as needed
    this.password = password;
  }

  set userUsername(String username) {
    // Perform username constraints (e.g., length)
    if (username.length > 20) {
      throw ArgumentError('Username cannot exceed 20 characters');
    }
    this.username = username;
  }

  // Convert User object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }

  // Convert a Map object to User object
  static user fromMap(Map<String, dynamic> map) {
    return user(
      email: map['email'],
      password: map['password'],
      username: map['username'],
    );
  }
}
