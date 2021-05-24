import 'quisioner_item.dart';

class SplitQuisionerModel {
  final String id;
  final String idQuisioner;
  final String idPertanyaan;
  final String pertanyaan;
  final List<String> pilihan;

  // ignore: public_member_api_docs
  SplitQuisionerModel(
      {this.id,
      this.idQuisioner,
      this.idPertanyaan,
      this.pertanyaan,
      this.pilihan});

  factory SplitQuisionerModel.fromModel(QuisionerItem model) {
    var question = model.pertanyaan.trim();
    var pertanyaan = question;
    List<String> pilihan = [];
    if (question.contains("(") && (question.endsWith(")"))) {
      var rawQuestion = question;
      pertanyaan = rawQuestion.substring(0, rawQuestion.indexOf("("));
      var rawChoice = rawQuestion
          .substring(rawQuestion.indexOf("("))
          .replaceAll("(", "")
          .replaceAll(")", "");
      pilihan = rawChoice.split('/').toList();
    }

    return SplitQuisionerModel(
        id: model.id,
        idQuisioner: model.idQuisioner,
        idPertanyaan: model.idPertanyaan,
        pertanyaan: pertanyaan,
        pilihan: pilihan);
  }
}
