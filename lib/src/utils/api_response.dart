class ApiResponse<T> {
  bool success;
  T data;
  int status;
  String message;

  ApiResponse(this.success, this.data, {this.message, this.status});
}