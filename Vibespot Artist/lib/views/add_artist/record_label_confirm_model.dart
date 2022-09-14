class RecordLabelConfirmModel {
  int? id;
  int? userId;
  String? recordLabelName;
  String? createdAt;

  RecordLabelConfirmModel(
      {this.id, this.userId, this.recordLabelName, this.createdAt});

  RecordLabelConfirmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    recordLabelName = json['record_label_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['record_label_name'] = this.recordLabelName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
