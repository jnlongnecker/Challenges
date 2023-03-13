public class CaseTriggerHelper {
  public static void setCaseStatusToNew(List<Case> newCases) {
    for (Case c : newCases) {
      c.Status = 'New';
    }
  }

  public static void updateStatusForChangedComments(
    List<Case> updatedCases,
    List<Case> oldCases
  ) {
    for (Integer i = 0; i < updatedCases.size(); i++) {
      Case newCase = updatedCases[i];
      Case oldCase = oldCases[i];

      if (newCase.Comments == oldCase.Comments) {
        continue;
      }
      if (newCase.Status != 'New') {
        continue;
      }

      newCase.Status = 'Working';
    }
  }
}
