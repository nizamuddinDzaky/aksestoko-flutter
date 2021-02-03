class Issue {
  String id;
  String key;
  String type;
  String status;
  String subject;
  String description;
  String assignee;
  String created;
  String updated;
  List<Comments> comments;

  Issue(
      {this.id,
        this.key,
        this.type,
        this.status,
        this.subject,
        this.description,
        this.assignee,
        this.created,
        this.updated,
        this.comments});

  Issue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    type = json['type'];
    status = json['status'];
    subject = json['subject'];
    description = json['description'];
    assignee = json['assignee'];
    created = json['created'];
    updated = json['updated'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['type'] = this.type;
    data['status'] = this.status;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['assignee'] = this.assignee;
    data['created'] = this.created;
    data['updated'] = this.updated;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  bool isUser;
  String body;
  String author;
  String created;

  Comments({this.isUser, this.body, this.author, this.created});

  Comments.fromJson(Map<String, dynamic> json) {
    isUser = json['isUser'];
    body = json['body'];
    author = json['author'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUser'] = this.isUser;
    data['body'] = this.body;
    data['author'] = this.author;
    data['created'] = this.created;
    return data;
  }
}