/** 
  *Test class to display Account and Contact record in tabular format
  **/

@isTest
public with sharing class TestAccountTabularFormat 
{
     /**
       *Test class for Positive result
       **/
     
     public static testmethod void positiveTestAccountTabularFormat()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Acc_Tab_Form accountForm=new Acc_Tab_Form();
        accountForm.receiveid=accountArray[0].id;
        accountForm.setupContacts();
        //system.assertEquals(1,accountForm.contactList.size());
        system.assertEquals(1,accountForm.opportunityList.size());
     }
     /**
       *Test class for Negative result
       **/ 
     public static testmethod void negativeTestAccountTabularFormat()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,null);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,null);
        Acc_Tab_Form accountForm=new Acc_Tab_Form();
        accountForm.receiveid=accountArray[0].id;
        accountForm.setupContacts();
        //system.assertNotEquals(contactArray.size(),accountForm.contactList.size());
        system.assertNotEquals(opportunityArray.size(),accountForm.opportunityList.size());
     }
     /**
       *Test class for null records 
       **/ 
     public static testmethod void nullTestAccountTabularFormat()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(0,null);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(0,null);
        Acc_Tab_Form accountForm=new Acc_Tab_Form();
        accountForm.receiveid=accountArray[0].id;
        accountForm.setupContacts();
        system.assertEquals(0,accountForm.opportunityList.size());
     }
     /**
       *Test class for bulk record
       **/ 
     public static testmethod void bulkTestAccountTabularFormat()
     {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(200,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(200,accountArray[0].id);
        Acc_Tab_Form accountForm=new Acc_Tab_Form();
        accountForm.receiveid=accountArray[0].id;
        accountForm.setupContacts();
        system.assertEquals(200,accountForm.opportunityList.size());
     }           
}