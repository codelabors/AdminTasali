// ignore_for_file: camel_case_types

class videomodel {
  String? name;
  String? profilepic;
  String? video;
  String? viduid;
  bool? islike;

  videomodel({
    this.name,
    this.islike,
    this.video,
    this.viduid,
    this.profilepic,
  });

  factory videomodel.fromMap(map) {
    return videomodel(
      video: map['video'],
      islike: map['islike'],
      name: map['name'],
      profilepic: map['profilepic'],
      viduid: map['viduid']
    );
  }

//sending
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'viduid': viduid,
      'islike': islike,
      'profilepic': profilepic,
      'video': video,
    };
  }
}
