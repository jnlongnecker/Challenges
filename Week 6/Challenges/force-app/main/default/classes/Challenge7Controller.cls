public class Challenge7Controller {

    public String searchTerm {get; set;}
    public Account acc {get; set;}
    public Challenge7Controller() {}
    
    public void find() {
        List<List<Account>> result = [FIND :searchTerm IN ALL FIELDS RETURNING Account LIMIT 1];
        
        if (result.isEmpty()) return;
        
        acc = result[0][0];
        acc = [SELECT (SELECT Name, Phone, Email FROM Contacts) FROM Account WHERE Id =: acc.Id LIMIT 1];
    }
}