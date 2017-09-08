/**
  *@class that will generate visual force page as pdf
  **/
public class BestPractice_2_PDf 
{
	public String address{get;set;}
    public List<Invoice_Statement__c> listbill{get;set;}
    public ID id{get;set;}
    /**
      *@method that will query on Invoice statement object
      * and retuen the all requirred fields on PDf.
      **/
    public BestPractice_2_PDf(ApexPages.StandardController controller) 
    {
       id = Apexpages.currentPage().getParameters().get('id');
       listbill=[select id,Date__c,Invoice__c,Account_Address__r.billingcity,Account_Address__r.name,
                 Account_Address__r.billingstreet,Account_Address__r.billingState,Labor_del__c,
                 New_Client_Discount_del__c,Service_Fee_del__c,Tax_del__c,Total_del__c
                 from Invoice_Statement__c WHERE id=:id];
    }
}
