/**
  *Test class on Visualforce Page that will allow the user to search for entered value
  **/
@isTest
public with sharing class TestSearchProgMod4 
{
    /**
      *test method for positive Result.
      **/
    public static testmethod void positiveTestSearchProgMod4()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Lead[] leadArray=TestDataFactory.createTestLeadRecords(1);
        Id [] fixedSearchResults = new Id[4];
        fixedSearchResults[0]=accountArray[0].id;
        fixedSearchResults[1]=contactArray[0].id;
        fixedSearchResults[2]=opportunityArray[0].id;
        fixedSearchResults[3]=leadArray[0].id;
        Test.setFixedSearchResults(fixedSearchResults);
        Pm4_Ass1 controllerObject=new Pm4_Ass1();
        //List<List<SObject>> searchQuery=[Find '*Test*' in all fields returning Account(id,name),Contact(id,name),Opportunity(Id,name),Lead(Id,name)];
        controllerObject.searchString='*Test*';
        controllerObject.searchString();
        system.assertEquals(controllerObject.searchQuery[0][0].id,accountArray[0].id);
      
    }
    /**
      *@test method for clearing result
      **/
     public static testmethod void clearTestSearchProgMod4()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Lead[] leadArray=TestDataFactory.createTestLeadRecords(1);
        Pm4_Ass1 controllerObject=new Pm4_Ass1();
        List<List<SObject>> searchQuery=[Find '%Test%' in all fields returning Account(id,name),Contact(id,name),Opportunity(Id,name),Lead(Id,name)];
        controllerObject.searchString='Test';
        controllerObject.searchString();
        controllerObject.clearResult();
        system.assertEquals(searchQuery.size(),controllerObject.searchQuery.size());
        system.assertEquals(false,controllerObject.rendAccount);
        system.assertEquals(false,controllerObject.rendLead);
        system.assertEquals(false,controllerObject.rendContact);
        system.assertEquals(false,controllerObject.rendOpp);
    }
    /**
      *test class for negative Result.
      **/ 
    public static testmethod void negativeTestSearchProgMod4()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Lead[] leadArray=TestDataFactory.createTestLeadRecords(1);
        Pm4_Ass1 controllerObject=new Pm4_Ass1();
        List<List<SObject>> searchQuery=[Find '%Test%' in all fields returning Account(id,name),Contact(id,name),Opportunity(Id,name),Lead(Id,name)];
        controllerObject.searchString='Mohit';
        controllerObject.searchString();       
        system.assertEquals(0,controllerObject.listAccount.size());
    }
    /**
      *test class for null Record.
      **/
    public static testmethod void nullTestSearchProgMod4()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(1);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Lead[] leadArray=TestDataFactory.createTestLeadRecords(1);
        Pm4_Ass1 controllerObject=new Pm4_Ass1();
        String q='';
        List<List<SObject>> searchQuery=[Find :q in all fields returning Account(id,name),Contact(id,name),Opportunity(Id,name),Lead(Id,name)];
        controllerObject.searchString='';
        controllerObject.searchString();
        system.assertEquals(null,controllerObject.searchQuery);
    } 
    /**
      *test class for bulk record.
      **/   
    public static testmethod void bulkTestSearchProgMod4()
    {
        Account[] accountArray=TestDataFactory.createTestAccountRecords(200);
        Contact[] contactArray=TestDataFactory.createTestContactRecords(1,accountArray[0].id);
        Opportunity[] opportunityArray=TestDataFactory.createTestopportunityRecords(1,accountArray[0].id);
        Lead[] leadArray=TestDataFactory.createTestLeadRecords(200);
        Pm4_Ass1 controllerObject=new Pm4_Ass1();
        List<List<SObject>> searchQuery=[Find 'test' in all fields returning Account(id,name),Contact(id,name),Opportunity(Id,name),Lead(Id,name)];
        controllerObject.searchString='Test';
        controllerObject.searchString();
        system.assertEquals(searchQuery.size(),controllerObject.searchQuery.size());
    }   
}