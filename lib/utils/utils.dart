enum Status { initial, success, failure }

class ApiUrl {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  static String getUrl(Url urlType) {
    switch (urlType) {
      case Url.posts:
        return '$baseUrl/posts';
      case Url.photos:
        return '$baseUrl/photos';
    }
  }
}

enum Url { posts, photos }
