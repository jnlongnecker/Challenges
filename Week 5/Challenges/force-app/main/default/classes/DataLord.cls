public class DataLord {
  public static Integer numAccounts() {
    return [SELECT COUNT() FROM Account];
  }

  public static Integer numHot() {
    return [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
  }

  public static Integer numComplex() {
    return [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
  }

  public static List<Account> big5() {
    return [
      SELECT Name
      FROM Account
      ORDER BY AnnualRevenue DESC NULLS LAST
      LIMIT 5
    ];
  }

  public static Opportunity lastBigOpportunity() {
    return [
      SELECT Name, Amount
      FROM Opportunity
      WHERE Amount > 100000
      ORDER BY CloseDate DESC NULLS LAST
      LIMIT 1
    ];
  }

  public static List<Contact> majorPlayers() {
    return [
      SELECT FirstName, LastName
      FROM Contact
      WHERE Account.Rating = 'Hot'
    ];
  }

  public static String mostPopularAccount() {
    return (String) ([
        SELECT Account.Name accName
        FROM Contact
        GROUP BY Account.Name
        ORDER BY COUNT(AccountId) DESC NULLS LAST
        LIMIT 1
      ][0]
      .get('accName'));
  }

  // Elite Challenge for SOQL
  public static List<String> mostLikelyLeadSources() {
    List<AggregateResult> results = [
      SELECT LeadSource source, AVG(Probability)
      FROM Opportunity
      WHERE NOT LeadSource = NULL
      GROUP BY LeadSource
      ORDER BY AVG(Probability) DESC
      LIMIT 5
    ];

    // All the elite challenge asked for was the SOQL query; this part is extra
    List<String> leadSources = new List<String>();
    for (AggregateResult result : results) {
      leadSources.add((String) result.get('source'));
    }

    return leadSources;
  }

  /************************* SOSL Challenges *************************/

  public static List<List<sObject>> getToms() {
    return [
      FIND 'Tom'
      IN NAME FIELDS
      RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)
    ];
  }

  public static List<Account> getAccountsWithAO() {
    return [
      FIND '*a*o* OR *o*a*'
      IN ALL FIELDS
      RETURNING Account(Name)
    ][0];
  }

  // Elite Challenge for SOSL
  public static List<String> helpRobin() {
    List<List<sObject>> results = [
      FIND '*1000'
      IN PHONE FIELDS
      RETURNING Account(Name), Contact(Name), Lead(Name)
    ];

    // Once you have the list of results, you can just return it. I format it for Robin here
    Map<Integer, String> indexToObjectName = new Map<Integer, String>{
      0 => 'Account',
      1 => 'Contact',
      2 => 'Lead'
    };
    List<String> possibleResults = new List<String>();
    for (Integer i = 0; i < results.size(); i++) {
      String objName = ' (' + indexToObjectName.get(i) + ')';
      List<sObject> objList = results[i];
      for (sObject obj : objList) {
        String possibilityName = (String) obj.get('Name') + objName;
        possibleResults.add(possibilityName);
      }
    }

    System.debug(
      'Robin\'s phone number could be in any of the following records: '
    );
    System.debug(possibleResults);

    return possibleResults;
  }

  /************************* DML Challenges *************************/

  public static void spawnContacts() {
    List<Contact> newContacts = new List<Contact>();
    for (Integer i = 1; i <= 200; i++) {
      Contact newContact = new Contact(
        FirstName = 'Contact',
        LastName = String.valueOf(i),
        Phone = '123 325 1234',
        Email = 'fakemail@gmail.com'
      );
      newContacts.add(newContact);
    }

    insert newContacts;
  }

  public static void createHomes() {
    List<Account> newHomes = new List<Account>();
    for (Integer i = 1; i <= 3; i++) {
      Account newHome = new Account(Name = 'Home ' + i);
      newHomes.add(newHome);
    }

    insert newHomes;
  }

  public static void relocate() {
    List<Contact> recentContacts = [
      SELECT Id
      FROM Contact
      ORDER BY CreatedDate DESC
      LIMIT 50
    ];
    delete recentContacts;
  }

  public static void assignHomes() {
    List<Contact> residents = [
      SELECT Id
      FROM Contact
      WHERE FirstName = 'Contact'
    ];
    List<Account> homes = [SELECT Id FROM Account WHERE Name LIKE 'Home %'];

    for (Contact resident : residents) {
      Integer randomChoice = Math.round(Math.random() * (homes.size() - 1));
      resident.AccountId = homes[randomChoice].Id;
    }

    update residents;
  }

  public static void play() {
    Integer contactsAtStart = [SELECT COUNT() FROM Contact];
    Integer accountsAtStart = [SELECT COUNT() FROM Account];

    Savepoint start = Database.setSavepoint();

    spawnContacts();
    createHomes();
    relocate();
    assignHomes();

    Integer contactsAtEnd = [SELECT COUNT() FROM Contact];
    Integer accountsAtEnd = [SELECT COUNT() FROM Account];
    List<AggregateResult> contactsPerAccount = [
      SELECT COUNT(AccountId) cnt, Account.Name accName
      FROM Contact
      GROUP BY Account.Name
    ];

    Database.rollback(start);

    List<String> contactsPerAccountFormatted = new List<String>();
    for (AggregateResult account : contactsPerAccount) {
      String numberPart = ' (' + String.valueOf(account.get('cnt')) + ')';
      String namePart = (String) account.get('accName');
      String formattedResult = namePart + numberPart;
      contactsPerAccountFormatted.add(formattedResult);
    }

    System.debug(
      'Accounts at the start: ' +
        accountsAtStart +
        ', Accounts at the end: ' +
        accountsAtEnd
    );
    System.debug(
      'Contacts at the start: ' +
        contactsAtStart +
        ', Contacts at the end: ' +
        contactsAtEnd
    );
    System.debug(contactsPerAccountFormatted);
  }
}
