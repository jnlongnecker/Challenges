public class Challenge6Controller {
    
    public Account acc {get; set;}
    public String greeting {get; set;}
    
    public Challenge6Controller() {
        Id accId = ApexPages.currentPage().getParameters().get('id');
        
        acc = [SELECT Name FROM Account WHERE Id = :accId];
        greeting = '';
    }
    
    public void greet() {
        greeting = 'Hello, ' + acc.Name + '!';
    }
}