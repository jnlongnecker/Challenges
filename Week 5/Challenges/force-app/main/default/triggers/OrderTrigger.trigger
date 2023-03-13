trigger OrderTrigger on Order(
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
      OrderTriggerHelper.setDefaultPricebook(Trigger.new);
    }
    when BEFORE_UPDATE {
    }
    when BEFORE_DELETE {
    }
    when AFTER_INSERT {
      OrderTriggerHelper.addPortableProductToNewOrders(Trigger.new);
    }
    when AFTER_UPDATE {
    }
    when AFTER_DELETE {
    }
    when AFTER_UNDELETE {
    }
  }
}
