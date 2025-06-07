class PostsModels {
  num _userId;
  num _id;
  String _title;
  String _body;

  PostsModels({
    required num userId,
    required num id,
    required String title,
    required String body,
  })  : _userId = userId,
        _id = id,
        _title = title,
        _body = body;

  PostsModels.fromJson(dynamic json)
      : _userId = json['userId'],
        _id = json['id'],
        _title = json['title'],
        _body = json['body'];

  PostsModels copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) =>
      PostsModels(
        userId: userId ?? _userId,
        id: id ?? _id,
        title: title ?? _title,
        body: body ?? _body,
      );

  num get userId => _userId;
  num get id => _id;
  String get title => _title;
  String get body => _body;

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'id': _id,
      'title': _title,
      'body': _body,
    };
  }
}
