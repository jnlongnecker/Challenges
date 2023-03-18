public class Challenge10Controller {

    public transient String filter {get; set;}
    
    public Challenge10Controller() {}
    
    public PageReference applyFilter() {
        PageReference nextPage = Page.Challenge11;
        nextPage.getParameters().put('filter', filter);
        return nextPage;
    }
}