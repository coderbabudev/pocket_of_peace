// Main model class
class CardGroup {
  int id;
  String skillCategory;
  String subSkillCategory;
  List<CardBase> cardList;

  CardGroup({
    required this.id,
    required this.skillCategory,
    required this.subSkillCategory,
    required this.cardList,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      id: json['id'],
      skillCategory: json['skill_category'],
      subSkillCategory: json['sub_skill_category'],
      cardList:
          (json['card_list'] as List).map((i) => CardBase.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skill_category': skillCategory,
      'sub_skill_category': subSkillCategory,
      'card_list': cardList.map((card) => card.toJson()).toList(),
    };
  }
}

// Base class for all card types
class CardBase {
  String type;

  CardBase({required this.type});

  factory CardBase.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'MultipleChoiceCard':
        return MultipleChoiceCard.fromJson(json);
      case 'TextCard':
        return TextCard.fromJson(json);
      case 'YesNoCard':
        return YesNoCard.fromJson(json);
      case 'StatementCard':
        return StatementCard.fromJson(json);
      default:
        throw Exception('Unknown card type');
    }
  }

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}

// MultipleChoiceCard class
class MultipleChoiceCard extends CardBase {
  String title;
  String? hint;
  String? image;
  String? video;
  String? subtitle;
  int index;
  int? selectionMax;
  bool hasImages;
  List<MultipleChoiceOption> options;

  MultipleChoiceCard({
    required this.title,
    this.hint,
    this.image,
    this.video,
    this.subtitle,
    required this.index,
    this.selectionMax,
    required this.hasImages,
    required this.options,
  }) : super(type: 'MultipleChoiceCard');

  factory MultipleChoiceCard.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceCard(
      title: json['title'],
      hint: json['hint'],
      image: json['image'],
      video: json['video'],
      subtitle: json['subtitle'],
      index: json['index'],
      selectionMax: json['selection_max'],
      hasImages: json['has_images'],
      options: (json['options'] as List)
          .map((i) => MultipleChoiceOption.fromJson(i))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'hint': hint,
      'image': image,
      'video': video,
      'subtitle': subtitle,
      'index': index,
      'selection_max': selectionMax,
      'has_images': hasImages,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

// MultipleChoiceOption class
class MultipleChoiceOption {
  String? type;
  String? text;
  String? image;

  MultipleChoiceOption({this.text, this.image, this.type});

  factory MultipleChoiceOption.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceOption(
      type: json['type'],
      text: json['text'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text,
      'image': image,
    };
  }
}

// TextCard class
class TextCard extends CardBase {
  String title;
  String? hint;
  String? image;
  String? video;
  String? subtitle;
  int index;
  int numTextfields;
  bool isExpandable;
  List<String> placeholderTexts;

  TextCard({
    required this.title,
    this.hint,
    this.image,
    this.video,
    this.subtitle,
    required this.index,
    required this.numTextfields,
    required this.isExpandable,
    required this.placeholderTexts,
  }) : super(type: 'TextCard');

  factory TextCard.fromJson(Map<String, dynamic> json) {
    return TextCard(
      title: json['title'],
      hint: json['hint'],
      image: json['image'],
      video: json['video'],
      subtitle: json['subtitle'],
      index: json['index'],
      numTextfields: json['num_textfields'],
      isExpandable: json['is_expandable'],
      placeholderTexts:
          List<String>.from(json['placeholder_texts'] as List<dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'hint': hint,
      'image': image,
      'video': video,
      'subtitle': subtitle,
      'index': index,
      'num_textfields': numTextfields,
      'is_expandable': isExpandable,
      'placeholder_texts': placeholderTexts,
    };
  }
}

// YesNoCard class
class YesNoCard extends CardBase {
  String title;
  String? hint;
  String? image;
  String? video;
  String? subtitle;
  int index;

  YesNoCard({
    required this.title,
    this.hint,
    this.image,
    this.video,
    this.subtitle,
    required this.index,
  }) : super(type: 'YesNoCard');

  factory YesNoCard.fromJson(Map<String, dynamic> json) {
    return YesNoCard(
      title: json['title'],
      hint: json['hint'],
      image: json['image'],
      video: json['video'],
      subtitle: json['subtitle'],
      index: json['index'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'hint': hint,
      'image': image,
      'video': video,
      'subtitle': subtitle,
      'index': index,
    };
  }
}

// StatementCard class
class StatementCard extends CardBase {
  String? title;
  String? hint;
  String? image;
  String? video;
  String? subtitle;
  int? index;

  StatementCard({
    this.title,
    this.hint,
    this.image,
    this.video,
    this.subtitle,
    this.index,
  }) : super(type: 'StatementCard');

  factory StatementCard.fromJson(Map<String, dynamic> json) {
    return StatementCard(
      title: json['title'],
      hint: json['hint'],
      image: json['image'],
      video: json['video'],
      subtitle: json['subtitle'],
      index: json['index'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'hint': hint,
      'image': image,
      'video': video,
      'subtitle': subtitle,
      'index': index,
    };
  }
}
