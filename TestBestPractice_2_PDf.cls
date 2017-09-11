/**
  *Test cLass for best Practice 2
  **/
@isTest
public with sharing class TestBestPractice_2_PDf 
{
    /**
       *Test method for positive result,to check all field values requirred in PDF is added in list. 
       **/
    public static testmethod void positiveTestBestPractice_2_PDf()
    {
         Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
         insert accountObject;
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountObject.id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         invoiceList.add(invoiceObject);
         insert invoiceList;
         Test.startTest();
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         Test.stopTest();
         System.assertEquals(invoiceList.size(),best.listbill.size());
         System.assertEquals(1,[select count() from Account]);
     }
     
     /**
       *Test method for null value,to check that if pdf is generated when Account record is not created.
       **/
     public static testmethod void nullTestBestPractice_2_PDf()
    {
         Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountObject.id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         invoiceList.add(invoiceObject);
         insert invoiceList;
         Test.startTest();
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         Test.stopTest();
         System.assertEquals(0,[select count() from Account]);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }
     /**
       *Test method for bulk record,to check if its working when account record are created in bulk.
       **/
     public static testmethod void bulkTestBestPractice_2_PDf()
    {
         List<Account> accountList=new List<Account>();
         for(integer counter=1; counter<=200;counter++ )
         {
             Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
             accountList.add(accountObject);
         }
         insert accountList;
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountList[10].id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         invoiceList.add(invoiceObject);
         insert invoiceList;
         Test.startTest();
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         Test.stopTest();
         System.assertEquals(200,[select count() from Account]);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }
}
