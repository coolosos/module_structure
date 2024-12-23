## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [License](#license)

## Overview

In the development of complex projects, it is customary to organize code into distinct layers—commonly, domain, data, and UI. This separation ensures maintainability and scalability. A common challenge in managing HTTP DataSources is the repetition of similar code for handling HTTP requests and responses, which can lead to errors and code bloat.

This package aims to streamline the implementation of HTTP DataSources by providing an intuitive and concise approach. By abstracting repetitive tasks and providing explicit, consistent usage patterns, it minimizes code duplication and enhances clarity.


## Getting Started

This package enables the straightforward creation of DataSources by overriding various components that define their behavior. These overrides can be implemented directly within the `HttpDataSource` class or through pre-built or custom mixins.

Mixins are a powerful feature in Dart that allow you to reuse a set of functionalities across multiple classes without the need for inheritance. For example, here's how you might implement a `GetAuthDataSource`:

```dart
abstract class GetAuthDataSource<T extends Codable> extends HttpDataSource<T>
    with GetRequest<T>, OnlyOKResponses<T>, AllErrorResponses<T> {
  GetAuthDataSource(this.client);

  @override
  final BaseClient client;
}
```
The primary goal of these overrides is to simplify common DataSource use cases. For instance, you can override the definitions of what constitutes a successful or failed response, or specify the type of HTTP request to be performed, such as GET, POST, DELETE, or PATCH.

The package also includes solutions for common HTTP status scenarios, such as handling all responses within the 4XX, 2XX, or 200 status codes.

Below, you’ll find examples demonstrating the use of these pre-established mixins.

## Usage

Every project is unique, and so are its HTTP data providers. To maintain flexibility and organization, it is recommended to create a dedicated file in your project where you define the necessary classes for each type of HTTP request.

These classes can be generated as follows:

```dart
abstract class DeleteAuthDataSource<T extends Codable> extends HttpDataSource<T>
    with DeleteRequest<T>, OnlyOKResponses<T>, AllErrorResponses<T> {
  DeleteAuthDataSource(this.client);

  @override
  final BaseClient client;
}
```

## Example: Login DataSource

The following is an example of a PostAuthDataSource implementation for user login:

```dart
final class LoginDatasource extends PostAuthDataSource<LoginTokenRemote> {
  LoginDatasource(super.client);

  // Defines the body of the POST request
  @override
  PostParam generateCallRequirement({required LoginDatasourceParams params}) {
    return PostParam(
      encodeBody: () => params.toMap(),
    );
  }

  // Specifies the base URL for the API
  @override
  String get host => "https://awesome-datasource.com";

  // Defines the API endpoint path
  @override
  String? get path => "/login";

  // Transforms the HTTP response into a LoginTokenRemote object
  @override
  LoginTokenRemote transformation({required Response remoteResponse}) {
    return const LoginTokenRemote().decode(remoteResponse.body);
  }
}

```


## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).  
© Coolosos. See the LICENSE file for details.