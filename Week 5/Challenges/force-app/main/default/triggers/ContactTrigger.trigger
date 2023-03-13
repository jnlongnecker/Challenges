trigger ContactTrigger on Contact(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      // Use case only requires we check contacts that are inserted
      ContactTriggerHelper.setDefaultEmail(Trigger.new);

      // Elite challenge only asks us to prevent contacts from being inserted with a duplicate phone
      ContactTriggerHelper.preventDuplicatePhoneNumbers(Trigger.new);
    }
    when BEFORE_UPDATE {
    }
    when BEFORE_DELETE {
    }
    when AFTER_INSERT {
    }
    when AFTER_UPDATE {
      // Use case only requires we check contacts that are updated
      ContactTriggerHelper.updateAccountPhone(Trigger.new, Trigger.old);
    }
    when AFTER_DELETE {
    }
    when AFTER_UNDELETE {
    }
  }
}
