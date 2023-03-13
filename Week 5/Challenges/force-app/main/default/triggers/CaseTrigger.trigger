trigger CaseTrigger on Case(
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
      CaseTriggerHelper.setCaseStatusToNew(Trigger.new);
    }
    when BEFORE_UPDATE {
      CaseTriggerHelper.updateStatusForChangedComments(
        Trigger.new,
        Trigger.old
      );
    }
    when BEFORE_DELETE {
    }
    when AFTER_INSERT {
    }
    when AFTER_UPDATE {
    }
    when AFTER_DELETE {
    }
    when AFTER_UNDELETE {
    }
  }
}
