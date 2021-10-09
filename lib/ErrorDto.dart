class ErrorDto {
final String reason;

  ErrorDto(this.reason);

   static ErrorDto fromJson(Map<String, dynamic> map) {
     var reason = map["reason"];

     return ErrorDto(reason);
   }
}