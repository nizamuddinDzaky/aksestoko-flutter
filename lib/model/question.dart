import 'package:flutter/material.dart';

class Question {
  String id;
  String categoryId;
  String type;
  String question;
  String label;
  String maxCheck;
  String singleLine;
  String isRequired;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;
  String answer;
  List<String> multiAnswer = [];
  bool isRadioSelected = false;
  List<OptionList> optionList;
  GlobalKey key;

  Question(
      {this.id,
      this.categoryId,
      this.type,
      this.question,
      this.label,
      this.maxCheck,
      this.singleLine,
      this.isRequired,
      this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.optionList});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    type = json['type'];
    question = json['question'];
    label = json['label'];
    maxCheck = json['max_check'];
    singleLine = json['single_line'];
    isRequired = json['is_required'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['option_list'] != null) {
      optionList = new List<OptionList>();
      json['option_list'].forEach((v) {
        optionList.add(new OptionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['question'] = this.question;
    data['label'] = this.label;
    data['max_check'] = this.maxCheck;
    data['single_line'] = this.singleLine;
    data['is_required'] = this.isRequired;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.optionList != null) {
      data['option_list'] = this.optionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionList {
  String id;
  String questionId;
  String option;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;

  OptionList({this.id,
    this.questionId,
    this.option,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt});

  OptionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    option = json['option'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['option'] = this.option;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
