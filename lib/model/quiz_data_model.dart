class CardDetail {
  final int? id;
  final String? type;
  final String? skillCategory;
  final String? subSkillCategory;
  final int? index;
  final List<String>? multiChoiceOptionText;
  final List<String>? textValue;
  final String? yesNoAnswer;

  CardDetail({
    this.id,
    this.type,
    this.index,
    this.skillCategory,
    this.subSkillCategory,
    this.multiChoiceOptionText,
    this.textValue,
    this.yesNoAnswer,
  });

  factory CardDetail.fromJson(Map<String, dynamic> json) {
    return CardDetail(
      id: json['id'],
      type: json['type'],
      skillCategory: json['skill_category'],
      subSkillCategory: json['sub_skill_category'],
      index: json['index'],
      multiChoiceOptionText:
          json['options'] != null ? List<String>.from(json['options']) : null,
      textValue: json['text_value'] != null
          ? List<String>.from(json['text_value'])
          : null,
      yesNoAnswer: json['yes_no_answer'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'type': type,
      'skill_category': skillCategory,
      'sub_skill_category': subSkillCategory,
      'index': index,
    };

    if (type == 'MultipleChoiceCard') {
      data['options'] = multiChoiceOptionText;
    }

    if (type == 'TextCard') {
      data['text_value'] = textValue;
    }

    if (type == 'YesNoCard') {
      data['yes_no_answer'] = yesNoAnswer;
    }

    return data;
  }
}
