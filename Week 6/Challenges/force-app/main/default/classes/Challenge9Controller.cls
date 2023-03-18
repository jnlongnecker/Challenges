public class Challenge9Controller {
	
    public List<Wrapper> myAccs {get; set;}
    
    public Challenge9Controller() {
        myAccs = new List<Wrapper>();
        
        String filter = ApexPages.currentPage().getParameters().get('filter');
        
        if (filter == null) filter = '';
        filter = '%' + filter + '%';
        
        for (Account acc : [SELECT Name, (SELECT Name FROM Contacts) FROM Account WHERE Name LIKE :filter]) {
            myAccs.add(new Wrapper(acc));
        }
    }
    
    class Wrapper {
        public Account acc {get; set;}
        
        public Wrapper(Account acc) {
            this.acc = acc;
        }
        
        public String getContactNames() {
            String output = '';
            if (acc.Contacts.isEmpty()) return output;
            for (Contact con : acc.Contacts) {
                output += con.Name;
                output += ', ';
            }
            return output.substring(0, output.length() - 2);
        }
    }
}