class ChatModel {
  final String role;
  final String text;

  ChatModel({required this.role, required this.text});

  //this will convert json objects to model objects
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    var candidatesList = json['candidates'] as List;
    var content =
        candidatesList.isNotEmpty ? candidatesList[0]['content'] : null;
    var partsList = content != null ? content['parts'] as List : [];
    String text = partsList.isNotEmpty ? partsList[0]['text'] : '';
    String role = content != null ? content['role'] : '';

    return ChatModel(
      role: role,
      text: text,
    );
  }

  //this will convert model objects to json objects
  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "parts": [
        {"text": text}
      ]
    };
  }

  @override
  String toString() {
    return 'ChatModel(role: $role, text: $text)';
  }
}
