/**
  *Test class for search on the accounts and display the results accordingly.
  **/
@isTest
public with sharing class TestAccountAdvanceController 
{
     /**
       *@method Testmethod to check,if the searched results displayed are correct
       **/
     public static testmethod void positiveTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.searchString='Test';
        controller.search();
        system.assertEquals(1,controller.listAccount.size());
     }
     /**
       *@method Testmethod to check negative results.
       **/
     public static testmethod void negativeTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.searchString='Mohit';
        controller.search();
        system.assertNotEquals(accountArray,controller.listAccount);
     }
     /**
       *@method Testmethod , if searched string is null.
       **/
     public static testmethod void nullTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(0);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.searchString='';
        controller.search();
        system.assertEquals(accountArray,controller.listAccount);
     }
     /**
       *@method Testmethod for bulk records.
       **/
     public static testmethod void bulkTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(200);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.searchString='%Test%';
        controller.search();
        system.assertEquals(accountArray.size(),controller.listAccount.size());
     }
     /**
       *@method Testmethod to check if the related contacts are displayed of accounts are displayed.
       **/
     public static testmethod void positiveSearchContactTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.receiveid=accountArray[0].id;
        controller.displayContact();
        system.assertEquals(1,controller.newListContact.size());
     } 
     /**
       *@method Testmethod to check if the selected contacts is deleted or not.
       **/
     public static testmethod void positiveContactFilterTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.filterAlphabet='T';
        controller.receiveid=accountArray[0].id;
        controller.contactFilter();
        system.assertEquals(1,controller.listContact.size());
     }
     public static testmethod void allContactFilterTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(2);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.filterAlphabet='All';
        controller.receiveid=accountArray[0].id;
        controller.contactFilter();
        system.assertEquals(1,controller.listContact.size());
     }
     public static testmethod void deleteContactTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        AccountAdvanceController.deleteContact(contactArray[0].id);
        system.assertEquals(0,[select count() from contact]);
     }
     public static testmethod void clearTestAccountAdvanceController()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        controller.searchString='%Test%';
        controller.search();
        controller.clear();
        system.assertEquals(0,controller.count);
    }    
}