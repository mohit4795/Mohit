/**
  *@class that will perform the search on the accounts and display the results accordingly. 
  **/  
public class AccountAdvanceController
{
	 public List <Account> listAccount {get;set;} 
     public List <Contact> listContact {get;set;}
     public List <Contact> newListContact {get;set;}
     public String receiveId {get;set;}
     public String contactId {get;set;}
     public String searchString {get;set;}
     public boolean accountDisplay{get;set;}
     public boolean flag{get;set;}
     public boolean flagNew{get;set;}
     public Integer count {get;set;}
     public List<String> listAlphabet {get; set;}
     public String filterAlphabet {get; set;}
     public AccountAdvanceController( ) 
     { 
        listAccount=new List<Account>();
        newListContact=new List<Contact>();
     } 
    /**
      *@method that will search the string in account and 
      *display respected accounts
      **/  
     public void search()
     { 
        
        listAccount.clear();
         newListContact.clear();
        if(searchString.length()<3 )
        {	
             Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Please enter Name or Input at least 3 characters to perform searching'));
        }
        else
        {
            listAccount = Database.query('Select Name,id From Account Where Name Like \'%'+searchString+'%\'');
            count = listAccount.size();
            if(listAccount.size()>0)
            {
                accountDisplay=true;
            }
            else
            {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'No records found'));
            }
        }
     }
    /**
      *@method that will display respected contact related to account records the string
      * and we can search them alphabetically.
      **/ 
     public void displayContact()
     {
        //contactDisplay=false;
        flag=false;
        listAlphabet = new List<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
        newListContact = [Select name,LastName,Contact.Account.id,id From Contact Where AccountId =: receiveId ];
        if(newListContact.size()==0)
         {
            flag=true;
        }
        else
        {
            flag=false;
        }
     }
    /**
      *@method display all contacts if clicked on ALL Link or display alphabetically
      **/   
     public void contactFilter()
     {  
         flagNew=false;
           
         if(filterAlphabet == 'All')
        {
        	listContact = [Select id,Name,Phone,LastName,Email From Contact Where AccountId =: receiveId ];
        }else
        {
        	String searchText = filterAlphabet+ '%';
        	listContact=[Select id,Name,Phone,LastName,Email From contact Where name Like : searchText And AccountId =: receiveId];
        	if(listContact.size()==0)
            {
                flagNew=true;
            }
            else
            {
                flagNew=false;
            }
        }
     }
     /**
       *@method that will delete the selected contact
       **/  
     @RemoteAction
     public static void deleteContact(String contactId){
        
        Contact deleteContact =[Select id,Name,Phone,Email From Contact Where Id =: contactId];
        delete deleteContact; 
     }
     /**
       *@method that will clear the contact list
       **/
     public void clear()
     { 
         flag=false;
         count=0;
         searchString='';
         listAccount.clear();
         newListContact=new List<Contact>();
         
     } 

}