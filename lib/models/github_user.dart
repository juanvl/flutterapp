class GithubUser {
  int id;
  String name;
  String login;
  String avatar_url;
  String bio;
  String html_url;

  GithubUser(
      {this.id,
      this.name,
      this.login,
      this.avatar_url,
      this.bio,
      this.html_url});

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      avatar_url: json['avatar_url'],
      bio: json['bio'],
      html_url: json['html_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login'] = this.login;
    data['avatar_url'] = this.avatar_url;
    data['bio'] = this.bio;
    data['html_url'] = this.html_url;
    return data;
  }
}
