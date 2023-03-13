public class ContactTriggerHelper {
  public static void setDefaultEmail(List<Contact> newContacts) {
    for (Contact con : newContacts) {
      // Skip contacts that have an email set already
      if (con.Email != null) {
        continue;
      }

      con.Email = 'default@email.com';
    }
  }

  public static void updateAccountPhone(
    List<Contact> newContacts,
    List<Contact> oldContacts
  ) {
    Map<Id, Contact> accIdToCon = new Map<Id, Contact>();

    for (Integer i = 0; i < newContacts.size(); i++) {
      Contact newContact = newContacts[i];
      Contact oldContact = oldContacts[i];

      // Don't need to do anything for Contacts with no Account or whose phone didn't update
      if (newContact.AccountId == null) {
        continue;
      }
      if (newContact.Phone == oldContact.Phone) {
        continue;
      }

      accIdToCon.put(newContact.AccountId, newContact);
    }

    // Get accounts related to a contact that had a change in phone number
    List<Account> accsToUpdate = [
      SELECT Id
      FROM Account
      WHERE Id IN :accIdToCon.keySet()
    ];

    if (accsToUpdate.isEmpty()) {
      return;
    }

    // Copy the phone number from contact to account
    for (Account acc : accsToUpdate) {
      Contact changedCon = accIdToCon.get(acc.Id);
      acc.Phone = changedCon.Phone;
    }

    update accsToUpdate;
  }

  public static void preventDuplicatePhoneNumbers(List<Contact> newContacts) {
    Map<String, Contact> phoneToContact = new Map<String, Contact>();

    // Map phone numbers to contacts for ease of retrieval later
    for (Contact con : newCOntacts) {
      if (con.Phone == null) {
        continue;
      }
      phoneToContact.put(con.Phone, con);
    }

    // Existing contacts whose phone numbers are being copied
    List<Contact> phoneCopiedContacts = [
      SELECT Phone
      FROM Contact
      WHERE Phone IN :phoneToContact.keySet()
    ];

    for (Contact con : phoneCopiedContacts) {
      Contact copycatContact = phoneToContact.get(con.Phone);
      copycatContact.addError(
        'Cannot insert a Contact with an existing phone number.'
      );
    }
  }
}
