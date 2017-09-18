@RestResource(urlMapping='/Lead/*')
/**
  *@class  Apex REST Service that will help external systems to manipulate Leads within
  * Salesforce
  **/
global with sharing class LeadRestService 
{
   /**
     *@class wrapper class
     **/
   global class ResponseWrapper 
   {
        global list<Lead> leadList;
        public boolean isSuccess ;
        public string status;
        global ResponseWrapper()
        {
            leadList = new list<Lead>();
            isSuccess= false;
        }      
    }
    /**
      *@method to fetch or get any lead record
      *@return response 
      **/
    @HttpGet
    global static ResponseWrapper doGet() 
    {
        ResponseWrapper resWrap = new ResponseWrapper();
        List<Lead> leads;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String leadId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        leads = [SELECT Id, Name,LastName FROM Lead WHERE Id = :leadId];
        resWrap.leadList=leads;
        resWrap.isSuccess= true;
        resWrap.status='success';
        return resWrap;
    }
    /**
      *@method to create a new lead record
      *@return response 
      **/
    @HttpPost
    global static ResponseWrapper doPost(String firstName,String lastName,String company,String phone, String email) 
    {
        Lead leadObject = new Lead();
        List<Lead> leads;
        ResponseWrapper resWrap = new ResponseWrapper();
        leadObject.FirstName =firstName;
        leadObject.LastName =lastName;
        leadObject.Company =company;
        leadObject.Phone = phone;
        leadObject.Email = email;
        insert leadObject;
        leads = [SELECT Id, Name,Company FROM Lead WHERE Id = :leadObject.id];
        resWrap.leadList=leads;
        resWrap.isSuccess= true;
        resWrap.status='success';
        return resWrap;
    }
    /**
      *@method to delete lead record
      *@return response 
      **/
    @HttpDelete
    global static void deleteLead() 
    {
        RestRequest request = RestContext.request;
        String leadId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
        Lead leadObject = [SELECT Id FROM Lead WHERE Id = :leadId];
        delete leadObject;
    }  
    /**
      *@method to update a  lead record
      *@return response 
      **/ 
    @HttpPatch
    global static ResponseWrapper updateLeadFields() 
    {
        RestRequest request = RestContext.request;
        String leadId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Lead leadObject = [SELECT Id FROM Lead WHERE Id =:leadId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        for(String fieldName : params.keySet()) 
        {
            leadObject.put(fieldName, params.get(fieldName));
        }
        update leadObject;
        ResponseWrapper resWrap = new ResponseWrapper();
        resWrap.leadList.add(leadObject);
        resWrap.isSuccess= true;
        resWrap.status='success';
        return resWrap;
    }
 }  
