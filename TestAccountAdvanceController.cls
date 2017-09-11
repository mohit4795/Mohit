/**
  *Test class for search on the accounts and display the results accordingly.
  **/
@isTest
public with sharing class TestAccountAdvanceController 
{
     /**
       *@method Testmethod to check,if the displayed contacts and accounts are removed from screen.
       **/
    public static testmethod void clearTestAccountAdvanceController()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.receiveid=accountArray[0].id;
        controller.searchString='Test';
        controller.search();
        controller.displayContact();
        Test.stopTest();
        controller.clear();
        system.assertEquals(0,controller.listAccount.size());
        system.assertEquals(0,controller.listContact.size());
        system.assertEquals(0,controller.count);
    }
    /**
      *@method Testmethod to check,if the contacts are displayed on clicking respected alphabet.
      **/
    public static testmethod void positiveContactFilterTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.filterAlphabet='T';
        controller.receiveid=accountArray[0].id;
        controller.searchString='Test';
        controller.search();
        controller.contactFilter();
        Test.stopTest();
        system.assertEquals(1,controller.listAccount.size());
        system.assertEquals(1,controller.listContact.size());
     }
     /**
       *@method Testmethod to check,if the contacts are not displayed on clicking respected alphabet.
       **/
     public static testmethod void negativeContactFilterTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.filterAlphabet='M';
        controller.receiveid=accountArray[0].id;
        controller.searchString='Test';
        controller.search();
        controller.contactFilter();
        Test.stopTest();
        system.assertEquals(1,controller.listAccount.size());
        system.assertNotEquals(1,controller.listContact.size());
        system.assertEquals(true,controller.flagOther);
     }
     /**
       *@method Testmethod to check,if the contacts are displayed on clicking 'All' Link.
       **/
     public static testmethod void allContactFilterTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(2);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.filterAlphabet='All';
        controller.searchString='Test';
        controller.search();
        controller.receiveid=accountArray[0].id;
        controller.contactFilter();
        Test.stopTest();
        system.assertEquals(2,controller.listAccount.size());
        system.assertEquals(1,controller.listContact.size());
     }
     /**
       *@method Testmethod to check,if the respected contact is deleted on clicking 'DELETE' Link.
       **/
     public static testmethod void deleteContactTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
         Test.startTest();
        controller.receiveid=accountArray[0].id;
        controller.searchString='Test';
        controller.search();
        controller.displayContact();
         Test.stopTest();
        AccountAdvanceController.deleteContact(contactArray[0].id);
        system.assertEquals(1,controller.listAccount.size());
        system.assertEquals(1,controller.listContact.size());
        system.assertEquals(0,[select count() from contact where id=:accountArray[0].id]);
     }    
     /**
       *@method Testmethod to check,if the searched results displayed are correct
       **/
     public static testmethod void positiveTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.searchString='Test';
        controller.search();
        Test.stopTest();
        system.assertEquals(1,controller.listAccount.size());
     }
     /**
       *@method Testmethod to check negative results i.e it must display error when no records are found.
       **/
     public static testmethod void negativeTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.searchString='Mohit';
        controller.search();
        Test.stopTest(); 
        system.assertNotEquals(accountArray,controller.listAccount);
     }
     /**
       *@method Testmethod , if searched string is null.
       **/
     public static testmethod void nullTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(0);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest(); 
        controller.searchString='';
        controller.search();
        Test.stopTest();
        system.assertEquals(accountArray,controller.listAccount);
     }
     /**
       *@method Testmethod for bulk records.
       **/
     public static testmethod void bulkTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(200);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.searchString='%Test%';
        controller.search();
        Test.stopTest();
        system.assertEquals(accountArray,controller.listAccount);
     }
     /**
       *@method Testmethod to check if the related contacts are displayed of accounts are displayed.
       **/
     public static testmethod void positiveSearchContactTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.receiveid=accountArray[0].id;
        controller.searchString='Test';
        controller.search();
        Test.stopTest();
        controller.displayContact();
        system.assertEquals(1,controller.listContact.size());
        system.assertEquals(1,controller.listAccount.size());
     }
     /**
       *@method Testmethod to check if the related contacts of account are not displayed.
       **/ 
     public static testmethod void negativeSearchContactTestAccountAdvanceController()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        AccountAdvanceController controller=new AccountAdvanceController();
        Test.startTest();
        controller.searchString='';
        controller.search();
        Test.stopTest();
        controller.displayContact();
        system.assertNotEquals(1,controller.listContact.size());
        system.assertNotEquals(1,controller.listAccount.size());
        system.assertEquals(true,controller.flag);
     }      
}