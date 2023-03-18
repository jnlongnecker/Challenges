@isTest
public class Challenge15Tests {

    @testSetup
    static void setup() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 60; i++) {
            testAccounts.add(new Account(Name = 'Test ' + i));
            testAccounts.add(new Account(Name = 'Account ' + i));
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
        
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 300; i++) {
            Integer selection = Math.round(Math.random() * (testAccounts.size() - 1));
            testContacts.add(new Contact(
            	FirstName = 'Contact',
                LastName = 'i',
                AccountId = testAccounts[selection].Id
            ));
        }
        insert testContacts;
    }
    
    @isTest
    static void TP_applyFilter10() {
        Test.startTest();
        
        Test.setCurrentPage(Page.Challenge10);
        Challenge10Controller c10 = new Challenge10Controller();
        c10.filter = 'Test';
        Test.setCurrentPageReference(c10.applyFilter());
        
        Test.stopTest();
        
        String filterParam = ApexPages.currentPage().getParameters().get('filter');
        Assert.areEqual('Test', filterParam);
    }
    
    @isTest
    static void TN_applyFilter10() {
        Test.startTest();
        
        Test.setCurrentPage(Page.Challenge10);
        Challenge10Controller c10 = new Challenge10Controller();
        Test.setCurrentPageReference(c10.applyFilter());
        
        Test.stopTest();
        
        String filterParam = ApexPages.currentPage().getParameters().get('filter');
        Assert.areEqual(null, filterParam);
    }
    
    @isTest
    static void TP_constructor11() {
        Test.startTest();
        
        PageReference p11 = Page.Challenge11;
        p11.getParameters().put('filter', 'Test');
        Test.setCurrentPage(p11);
        Challenge11Controller c11 = new Challenge11Controller();
        
        Test.stopTest();
        
        String filter = c11.filter;
        Assert.areEqual('%Test%', filter);
    }
    
    @isTest
    static void TN_constructor11() {
        Test.startTest();
        
        PageReference p11 = Page.Challenge11;
        Test.setCurrentPage(p11);
        Challenge11Controller c11 = new Challenge11Controller();
        
        Test.stopTest();
        
        String filter = c11.filter;
        Assert.areEqual('%%', filter);
    }
    
    @isTest
    static void TP_getAccs11() {
        Test.startTest();
        
        PageReference p11 = Page.Challenge11;
        p11.getParameters().put('filter', 'Test');
        Test.setCurrentPage(p11);
        Challenge11Controller c11 = new Challenge11Controller();
        
        Test.stopTest();
        
        
        Assert.areEqual(120, c11.myAccs.size());
    }
    
    @isTest
    static void TP_getAccsFilter11() {
        Test.startTest();
        
        PageReference p11 = Page.Challenge11;
        p11.getParameters().put('filter', 'Test');
        Test.setCurrentPage(p11);
        Challenge11Controller c11 = new Challenge11Controller();
        c11.searchFilter = 'AcCoUnt';
        
        Test.stopTest();
        
        
        Assert.areEqual(60, c11.myAccs.size());
        for (Challenge11Controller.Wrapper w : c11.myAccs) {
            Assert.isNotNull(w.getContactNames());
            Assert.isInstanceOfType(w.getContactNames(), String.class);
        }
    }
}