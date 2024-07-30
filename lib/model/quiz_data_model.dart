class CardDetail {
  final int id;
  final String skillCategory;
  final String subSkillCategory;
  final List<CardItemDetail> cardList;

  CardDetail({
    required this.id,
    required this.skillCategory,
    required this.subSkillCategory,
    required this.cardList,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skill_category': skillCategory,
      'sub_skill_category': subSkillCategory,
      'card_list': cardList.map((e) => e.toJson()).toList(),
    };
  }
}

class CardItemDetail {
  final String type;
  final String title;
  final String subtitle;
  final int index;
  final List<String>? placeholderTexts;

  CardItemDetail({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.index,
    this.placeholderTexts,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'subtitle': subtitle,
      'index': index,
      'placeholder_texts': placeholderTexts,
    };
  }
}
