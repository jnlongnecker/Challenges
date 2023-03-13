public class AccountTriggerHelper {
  public static void preventDeleteWithContacts(Map<Id, Account> accsToId) {
    // Retrieve all account Ids that should not be deleted
    List<AggregateResult> accIdsToNotDelete = [
      SELECT AccountId accId
      FROM Contact
      WHERE AccountId IN :accsToId.keySet()
      GROUP BY AccountId
    ];

    // For each id, prevent that account from deletion
    for (AggregateResult idResult : accIdsToNotDelete) {
      Account acc = accsToId.get((Id) idResult.get('accId'));
      acc.addError('You cannot delete an Account with related Contacts.');
    }
  }

  public static void attachDefaultContact(List<Account> newAccs) {
    List<Contact> newContacts = new List<Contact>();
    for (Account acc : newAccs) {
      // Create and add contact related to this account
      newContacts.add(
        new Contact(
          FirstName = 'Con for ',
          LastName = acc.Name,
          AccountId = acc.Id,
          Phone = randomPhone(),
          Email = 'fake@email.com'
        )
      );
    }
    insert newContacts;
  }

  // Not necessary for any challenge, but allows this to work with the Elite Challenge to prevent duplicate contact phone numbers
  private static String randomPhone() {
    String phone = '';
    for (Integer i = 0; i < 10; i++) {
      Integer num = Math.round(Math.random() * 9);
      phone += String.valueOf(num);
    }

    return phone;
  }
}
