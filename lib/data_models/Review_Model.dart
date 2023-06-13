class RequestModel {
  final String id;
  final String clientId;
  final String workerId;
  final String review;

  const RequestModel(
      {required this.id,
      required this.clientId,
      required this.workerId,
      required this.review});

  toJson() {
    return {
      "client_id": clientId,
      "worker_id": workerId,
      "review": review,
    };
  }
}
