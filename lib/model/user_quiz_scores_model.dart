class UserQuizScoresModel {
  final String userId;
  final String quizTypeId;
  final int highScores;

  UserQuizScoresModel({
    required this.userId, 
    required this.quizTypeId, 
    required this.highScores
  });
}