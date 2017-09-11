/**
  *@class that will perform the search on the accounts and display the results accordingly. 
  **/  
global class AccountAdvanceController
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
     public boolean flagOther{get;set;}
     public Integer count {get;set;}
     public List<String> listAlphabet {get; set;}
     public String filterAlphabet {get; set;}   
     public AccountAdvanceController( ) 
     { 
        listAccount=new List<Account>();
        listContact=new List<Contact>();
        newListContact=new List<Contact>();
        flagNew=false;
     } 
    /**
      *@method that will search the string in account and 
      *display respected accounts
      **/
    public void search()
    { 
     	if(searchString.length()<3 )
        {   
             Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Please enter Name or Input at least 3 characters to perform searching'));
        }
        else
        {
            listAccount = Database.query('Select Name,id From Account Where Name Like \'%'+searchString+'%\'');
            count = listAccount.size();
            system.debug(count); 
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
        flagNew=true;
        flag=false;
        listAlphabet = new List<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
        listContact = [Select name,LastName,Contact.Account.id,id From Contact Where AccountId =: receiveId ];
        if(listContact.size()==0)
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
         flagNew=true;
         listContact=new List<Contact>();
         if(filterAlphabet == 'All')
        {
            listContact = [Select id,Name,Phone,LastName,Email From Contact Where AccountId =: receiveId ];
           
        }else
        {
            String searchText = filterAlphabet+ '%';
            listContact=[Select id,Name,Phone,LastName,Email From contact Where name Like : searchText And AccountId =: receiveId];
            if(listContact.size()==0)
         {
            flagOther=true;
        }
        else
        {
            flagOther=false;
        }
        }
     }
     /**
       *@method that will delete the selected contact
       **/  
    @RemoteAction
     global static boolean deleteContact(ID contactId){
         system.debug(contactId);
        Contact contactObject = new Contact();
         if(contactId!=null)
         {
             for(Contact contObj:[select id from Contact])
             {
                 if(contactId==contObj.id)
                 {
                   contactObject=[select accountId from Contact where id=:contactId];  
                 }   
             }   
         } 
         contactObject.accountId=null;
         Database.SaveResult sr=Database.update(contactObject,false);
         if(sr.isSuccess())
         {
             return true;
         }
         else
         {
          	return false;   
         }
     }
     /**
       *@method that will clear the contact list
       **/
     public void clear()
     { 
         flagNew=false;
         flag=false;
         searchString='';
         listAccount.clear();
         listContact.clear();
         listAccount=new List<Account>();
         listContact=new List<Contact>();
         count=0;         
     } 
}