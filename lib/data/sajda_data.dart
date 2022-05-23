class SajdaData {
  final int id;
  final bool isSajda;
  final bool isRecommended;
  final bool isObligatory;

  SajdaData({
    required this.id,
    required this.isSajda,
    required this.isRecommended,
    required this.isObligatory,
  });

  factory SajdaData.fromJSON(dynamic data) {
    if (data is bool) {
      return SajdaData(
        id: -1,
        isSajda: false,
        isRecommended: false,
        isObligatory: false,
      );
    } else {
      return SajdaData(
        id: data['id'],
        isSajda: true,
        isRecommended: data['recommended'],
        isObligatory: data['obligatory'],
      );
    }
  }
}
