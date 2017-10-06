/**
  * @class Apex SOAP web Service that will help external systems to manipulate Leads within Salesforce
  **/
global class MyWebService {
   global class ResponseWrapper 
   {
        public list<Lead> leadList;
        webService boolean isSuccess ;
        webService string status;
        global ResponseWrapper()
        {
            leadList = new list<Lead>();
            isSuccess= false;
        }      
    }
   /**
     *@method to create a new lead record
     *@return response
     **/
    webService static ResponseWrapper makeLead(String lastName, String firstName,String phone,String email,String company,String status) {
        Lead leadObj = new Lead(lastName = lastname,firstname=firstname,phone=phone,email=email,company=company,status=status);
        insert leadObj;
        List<Lead> leads;
        ResponseWrapper resWrap = new ResponseWrapper();
        leads = [SELECT Id, Name,Company FROM Lead WHERE Id = :leadObj.id];
        Database.SaveResult sr = Database.insert(leadObj, false);
        if(sr.isSuccess()){
          resWrap.isSuccess= true;
          resWrap.leadList=leads;
          resWrap.status='success';         
        }
        else
        {
            resWrap.IsSuccess=false;
            resWrap.status='fail';             
        }
        return resWrap;
    }
    /**
      *@method to delete a lead record
      *@return response
      **/
    webService static ResponseWrapper deleteLead(String lastName, String firstName,String phone,String email) {
       
        Lead listLead=[select name from lead where firstname=:firstname and lastname=:lastname and phone=:phone and email=:email];
        ResponseWrapper resWrap = new ResponseWrapper();
        Database.deleteResult sr=Database.delete(listLead,false);
        if(sr.isSuccess()){
          resWrap.isSuccess= true;
          resWrap.status='success';         
        }
        else
        {
            resWrap.IsSuccess=false;
            resWrap.status='fail';             
        }
        return resWrap;
    }
    /**
      *@method to update a lead record
      *@return response
      **/
     webService static ResponseWrapper updateLead(String lastName, String firstName,String phone,String email) {
       
        Lead listLead=[select name from lead where firstname=:firstname and lastname=:lastname and phone=:phone and email=:email];
        ResponseWrapper resWrap = new ResponseWrapper();
        Database.SaveResult sr=Database.update(listLead,false);
        if(sr.isSuccess()){
          resWrap.isSuccess= true;
          resWrap.status='success';         
        }
        else
        {
            resWrap.IsSuccess=false;
            resWrap.status='fail';             
        }
        return resWrap;
    }
}