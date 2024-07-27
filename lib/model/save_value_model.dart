class YesNOButtonStatus {
  final String id;
  bool isYesSelected;
  bool isNoSelected;

  YesNOButtonStatus({
    required this.id,
    this.isYesSelected = false,
    this.isNoSelected = false,
  });
}
