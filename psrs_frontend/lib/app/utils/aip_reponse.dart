class APIResponse {
  final bool success;
  final String? message;
  final dynamic data;

  APIResponse({required this.success, this.message, this.data});  
}