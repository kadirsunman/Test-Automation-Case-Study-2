Feature: my callers features

  Background:
    * url baseUrl

  @name=RandomString
  Scenario: string request callers
    * def random_string =
    """
    function(s, state) {
        var text = "";
        var possible = "";
        switch(state) {
            case "string":
              possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
              break;
            case "name":
              possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
              break;
            case "phone":
              possible = "1234567890";
              break;
            default:
              possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        }
        for (var i = 0; i < s; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));
        return text;
    }
    """
    * def value =  random_string(length, state)


  @name=RandomInt
  Scenario: int request callers
    * def random_int =
    """
    function(s, state) {
        var text = "";
        var possible = "";
        switch(state) {
            case "id":
               possible = "1234567890";
               break;
            case "status":
               possible = "01";
               break;
            default:
               possible = "1234567890";
         }
        for (var i = 0; i < s; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));
        return parseInt(text);
    }
    """
    * def value =  random_int(length, state)

  @name=Task4
  Scenario: Task Four
    * def RandomStringPath = 'classpath:callers/callers.feature@name=RandomString'
    * def RandomIntPath = 'classpath:callers/callers.feature@name=RandomInt'
    * def id = call read(RandomIntPath) {length: 6, state:"id"}
    * def firstName = call read(RandomStringPath) {length: 6, state: "name"}
    * def emailData = read('classpath:helper/emailData.json')
    * def password = call read(RandomStringPath) {length: 8, state: "string"}
    * def phone = call read(RandomStringPath) {length: 11, state: "phone"}
    * def userStatus = call read(RandomIntPath) {length: 1, state: "status"}
    * def myJson =
    """ {
          "id": 0,
          "username": "string",
          "firstName": "string",
          "lastName": "string",
          "email": "string",
          "password": "string",
          "phone": "string",
          "userStatus": 0
        }
    """
    * set myJson.id = id.value
    * set myJson.username = username
    * set myJson.firstName = firstName.value
    * set myJson.lastName = lastName
    * set myJson.email = emailData.email
    * set myJson.password = password.value
    * set myJson.phone = phone.value
    * set myJson.userStatus = userStatus.value
    * header Content-Type = 'application/json'
    * path 'user'
    * request myJson
    * method POST
    * status 200
    * def convertToString =
    """
    function(s) {
      return s.toString();
    }
    """
    * match response.message == convertToString(id.value)