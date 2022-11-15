// ignore_for_file: camel_case_types

class mememodel {
  String? name;
  String? profilepic;
  String? meme;
  String? memeuid;
  bool? islike;

  mememodel({
    this.name,
    this.islike,
    this.meme,
    this.profilepic,
    this.memeuid,
  });

  factory mememodel.fromMap(map) {
    return mememodel(
      meme: map['meme'],
      memeuid: map['memeuid'],
      name: map['name'],
      islike: map['islike'],
      profilepic: map['profilepic'],
    );
  }

//sending
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'profilepic': profilepic,
      'memeuid': memeuid,
      'islike': islike,
      'meme': meme,
    };
  }
}
