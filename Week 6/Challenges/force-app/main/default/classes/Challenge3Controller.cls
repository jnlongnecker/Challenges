public class Challenge3Controller {
    public Account acc {get; set;}
    
    public Challenge3Controller() {
        acc = [SELECT Id FROM Account ORDER BY Rating ASC NULLS LAST LIMIT 1];
    }
}