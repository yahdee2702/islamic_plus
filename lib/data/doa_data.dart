class DoaData {
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  DoaData({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory DoaData.fromJSON(Map<String, dynamic> json) {
    return DoaData(
      title: json["title"],
      arabic: json["arabic"],
      latin: json["latin"],
      translation: json["translation"],
    );
  }
}
