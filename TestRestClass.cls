/**
  *@class test class for resr service.
  **/
@isTest
public with sharing class TestRestClass 
{
    /**
      *@testMethod to check if user is able to fetch records.
      **/
    public static testmethod void getTestRestClass()
    {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Lead/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        LeadRestService.ResponseWrapper resp = LeadRestService.doGet();
        resp.leadList=[SELECT Id,Name,LastName FROM Lead WHERE Id = :recordId]; 
        System.assertEquals(resp.leadList.size(),1);
    }  
    /**
      *@testMethod to check if user is able to insert new lead records.
      **/
    public static testmethod void insertTestRestClass()
    {
        LeadRestService.ResponseWrapper resp = LeadRestService.doPost('Mohit','Khurana','Eternus','0123456789','test@gmail.com');
        System.assertEquals(resp.leadList[0].Company, 'Eternus');
    } 
    /**
      *@testMethod to check if new record is not inserted(negative case).
      **/
    public static testmethod void insertNegativeTestRestClass()
    {
        LeadRestService.ResponseWrapper resp = LeadRestService.doPost('Mohit','Khurana','Eternus','0123456789','test@gmail.com');
        System.assertNotEquals(resp.isSuccess,false);
    } 
    /**
      *@testMethod to check if user is able to delete existing lead records.
      **/
    public static testmethod void deleteTestRestClass()
    {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Lead/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        LeadRestService.deleteLead();
        List<Lead> leadList = [SELECT Id FROM Lead WHERE Id=:recordId];
        System.assert(leadList.size() == 0);
    }   
    /**
      *@testMethod to check if user is able to update existing lead records.
      **/
    public static testmethod void updateTestRestClass()
    {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri ='https://ap5.salesforce.com/services/apexrest/Lead/'+ recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"company": "Infosys"}');
        RestContext.request = request;
        LeadRestService.ResponseWrapper resp = LeadRestService.updateLeadFields();
        Lead thisLead = [SELECT Id,Company FROM Lead WHERE Id=:recordId];
        System.assertEquals(thisLead.Company, 'Infosys');

    } 
    /**
      *@helper method
      **/    
    static Id createTestRecord()
     {
        Lead leadTest = new Lead(
            FirstName='Test record',
            LastName='New',
            Phone='9896169484',
            Email='test@gmail.com',
            Company='Medium');
        insert leadTest;
        return leadTest.Id;
    }    
}