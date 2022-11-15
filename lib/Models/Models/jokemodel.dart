// ignore_for_file: camel_case_types

class jokemodel {
  String? name;
  String? profilepic;
  String? joke;
  String? jokeuid;
  bool? islike;

  jokemodel({
    this.name,
    this.islike,
    this.joke,
    this.profilepic,
    this.jokeuid,
  });

  factory jokemodel.fromMap(map) {
    return jokemodel(
      joke: map['joke'],
      jokeuid: map['jokeuid'],
      islike: map['islike'],
      name: map['name'],
      profilepic: map['profilepic'],
    );
  }

//sending
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'jokeuid': jokeuid,
      'islike': islike,
      'profilepic': profilepic,
      'joke': joke,
    };
  }
}
