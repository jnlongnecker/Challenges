public class Challenge11Controller {
    
    // This can be transient because it's always being sent back as part of the <apex:inputText>
    public transient String searchFilter {get; set;}
    
    // We can greatly reduce the records stored in the view state by querying for them each time.
    // We're already on the server, so queries run way faster than a server call that uses lots of data
    public List<Wrapper> myAccs {
        get {
            String f = searchFilter.toLowerCase();
            List<Wrapper> ret = new List<Wrapper>();
            for (Account acc : [SELECT Name, (SELECT Name FROM Contacts) FROM Account WHERE Name LIKE :filter]) {
                if (!acc.Name.toLowerCase().contains(f)) continue;
                ret.add(new Wrapper(acc));
            }
            return ret;
        }
    }
    
    // This needs to be part of the view state because it's only set once and we need it to stay
    public String filter {get; set;}
    
    public Challenge11Controller() {        
        filter = ApexPages.currentPage().getParameters().get('filter');
        searchFilter = '';
        
        if (filter == null) filter = '';
        filter = '%' + filter + '%';
    }
    
    
    @testVisible class Wrapper {
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