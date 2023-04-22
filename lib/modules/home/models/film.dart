class Film {
  String? id;
  String? title;

  Film({this.id, this.title});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??
        json['url']?.split('/')[json['url'].split('/').length - 2];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
