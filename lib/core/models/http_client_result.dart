abstract class HttpClientResult<T> {}

class SuccessfulRequest<T> extends HttpClientResult<T> {
  final T? retrievedData;

  SuccessfulRequest([this.retrievedData]);
}

class FailedRequest<T> extends HttpClientResult {
  final String errorCode;

  FailedRequest(this.errorCode);
}
