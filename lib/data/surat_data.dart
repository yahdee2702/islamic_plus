class SuratData {
  final int number;
  final String name;
  final String nameLatin;
  final int ayahsQuantity;
  final String revelationType;

  const SuratData({
    required this.number,
    required this.name,
    required this.nameLatin,
    required this.ayahsQuantity,
    required this.revelationType,
  });

  factory SuratData.fromJSON(Map<String, dynamic> theJson) {
    return SuratData(
        number: theJson['number'],
        name: theJson['name'],
        nameLatin: theJson['englishName'],
        ayahsQuantity: theJson['numberOfAyahs'],
        revelationType: theJson['revelationType']);
  }
}
