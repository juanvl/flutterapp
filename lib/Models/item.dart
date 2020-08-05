class Item {
  String name;
  String login;
  String avatar_url;
  String bio;
  String html_url;

  Item({this.name, this.login, this.avatar_url, this.bio, this.html_url});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    login = json['login'];
    avatar_url = json['avatar_url'];
    bio = json['bio'];
    html_url = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['login'] = this.login;
    data['avatar_url'] = this.avatar_url;
    data['bio'] = this.bio;
    data['html_url'] = this.html_url;
    return data;
  }
}
