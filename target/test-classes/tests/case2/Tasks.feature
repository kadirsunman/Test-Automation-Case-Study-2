Feature: Test Automation Case Study 2 (API)

  Background:
    Given url baseUrl


  Scenario Outline: Task One
    * param status = ['available','pending']
    And path 'pet', status
    When method GET
    Then status 200
    Then match responseHeaders['Content-Type'][0] == 'application/json'
    Examples:
      | status  |
      | findByStatus |

    @name=Task2
  Scenario: Task Two
    * def random_email =
    """
    function(s) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        for (var i = 0; i < s; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));
        return text + "@gmail.com";
    }
    """
    * def email =  random_email(10)
    * Java.type('callers.JsonFileWrite').StringRandomCreator(email)

  Scenario: Task Three
    * def RandomStringPath = 'classpath:callers/callers.feature@name=RandomString'
    * def RandomIntPath = 'classpath:callers/callers.feature@name=RandomInt'
    #Attribute lerin random olarak callers feature içersinden int olanları int e göre string olanları stringe göre çektiğimiz yer
    * def id = call read(RandomIntPath) {length: 6, state:"id"}
    * def username = call read(RandomStringPath) {length: 8, state: "string"}
    * def firstName = call read(RandomStringPath) {length: 6, state: "name"}
    * def lastName = call read(RandomStringPath) {length: 6, state: "name"}
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
    #Random aldığımız değerleri myJson dosyamıza set komutu ile atıyoruz.
    * set myJson.id = id.value
    * set myJson.username = username.value
    * set myJson.firstName = firstName.value
    * set myJson.lastName = lastName.value
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

  Scenario: Task Four Run Scenario
    * def Task4Path = 'classpath:callers/callers.feature@name=Task4'
    * def id = call read(Task4Path) {username: "Kadir", lastName: "Sunman"}