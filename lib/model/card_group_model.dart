class CardGroup {
  final int id;
  final String skillCategory;
  final String subSkillCategory;
  final List<CardItem> cardList;

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
      cardList: (json['card_list'] as List)
          .map((item) => CardItem.fromJson(item))
          .toList(),
    );
  }
}

class CardItem {
  final String type;
  final String title;
  final String? hint;
  final String? image;
  final String? video;
  final String? subtitle;
  final int index;
  final int? selectionMax;
  final bool hasImages;
  final List<CardOption>? options;
  final int? numTextFields;
  final bool? isExpandable;
  final List<String>? placeholderTexts;

  CardItem({
    required this.type,
    required this.title,
    this.hint,
    this.image,
    this.video,
    this.subtitle,
    required this.index,
    this.selectionMax,
    this.hasImages = false,
    this.options,
    this.numTextFields,
    this.isExpandable,
    this.placeholderTexts,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      type: json['type'],
      title: json['title'] ?? '',
      hint: json['hint'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      subtitle: json['subtitle'] ?? '',
      index: json['index'],
      selectionMax: json['selection_max'],
      hasImages: json['has_images'] ?? false,
      options: json['options'] != null
          ? (json['options'] as List)
              .map((item) => CardOption.fromJson(item))
              .toList()
          : null,
      numTextFields: json['num_textfields'],
      isExpandable: json['is_expandable'] ?? false,
      placeholderTexts: json['placeholder_texts'] != null
          ? List<String>.from(json['placeholder_texts'])
          : null,
    );
  }
}

class CardOption {
  final String? text;
  final String? image;

  CardOption({this.text, this.image});

  factory CardOption.fromJson(Map<String, dynamic> json) {
    return CardOption(
      text: json['text'],
      image: json['image'],
    );
  }
}
