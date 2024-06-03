class UserData {
  final String uid;
  final String name;
  final int age;

  const UserData({
    required this.uid,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      name: map['name'],
      age: map['age'],
    );
  }
}
