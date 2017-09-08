/**
  *Test cLass for best Practice 2
  **/
@isTest
public with sharing class TestBestPractice_2_PDf 
{
    /**
       *Test method for positive result
       **/
    public static testmethod void positiveTestBestPractice_2_PDf()
    {
         Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
         insert accountObject;
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountObject.id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         invoiceList.add(invoiceObject);
         insert invoiceList;
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }
     /**
       *Test method for negative result
       **/
     public static testmethod void negativeTestBestPractice_2_PDf()
    {
         List<Account> accountList=new List<Account>();
         for(integer counter=1; counter<=2;counter++ )
         {
             Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
             accountList.add(accountObject);
         }
         insert accountList;
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountList[0].id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         ApexPages.CurrentPage().getParameters().put('id',invoiceObject.id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }
     /**
       *Test method for null value
       **/
     public static testmethod void nullTestBestPractice_2_PDf()
    {
         Account accountObject = new account(name='acc',billingcity='Karnal',billingstreet='Karnal',billingState='Haryana');
         List<Invoice_Statement__c> invoiceList=new List<Invoice_Statement__c>();
         Invoice_Statement__c invoiceObject=new Invoice_Statement__c(Account_Address__c=accountObject.id,New_Client_Discount_del__c=50,Service_Fee_del__c=200);
         invoiceList.add(invoiceObject);
         insert invoiceList;
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }
     /**
       *Test method for bulk record
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
         ApexPages.CurrentPage().getParameters().put('id',invoiceList[0].id);
         Apexpages.StandardController sc = new Apexpages.StandardController(invoiceObject);
         BestPractice_2_PDf best=new BestPractice_2_PDf (sc);
         System.assertEquals(invoiceList.size(),best.listbill.size());
     }    
}