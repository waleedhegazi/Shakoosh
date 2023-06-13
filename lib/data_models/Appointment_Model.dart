class AppointmentModel {
  final String id;
  final String requestId;
  final int rate;
  final String review;

  const AppointmentModel({
    required this.id,
    required this.requestId,
    required this.rate,
    required this.review,
  });

  toJson() {
    return {
      "request_id": requestId,
      "rate": rate,
      "review": review,
    };
  }
}
