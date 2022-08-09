class Customer{
  String login;
  String htmlUrl;

  Customer({
    required this.login,
    required this.htmlUrl
});
  factory Customer.fromJson(Map<dynamic, dynamic> dictionary) {
    print('customer model');
    return Customer(
        login: dictionary['xx'] ?? '',
        htmlUrl: dictionary['yy'] ?? ''
    );
  }

  static get empty => Customer(login: '', htmlUrl: '');

  @override
  //can be "one-line" function
  String toString() => 'countryName: $login, code = $htmlUrl';
}