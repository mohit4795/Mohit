/**
  *Utility test Class
  **/
@istest
public with sharing class TestDataFactory 
{
  /**
    *@method test method to insert account records
    *@param number of accounts record to be inserted
    *@returntype Account List
    **/
  public static List<Account> createTestAccountRecords(Integer numAccts)
  {
        List<Account> accountList = new List<Account>();
         
        for(Integer i=0;i<numAccts;i++) {
            Account accountObject = new Account(Name='TestAccount');
            accountList.add(accountObject);
        }
        insert accountList;
        return accountList;
  }
  /**
    *@method test method to insert contact records
    *@param number of accounts record to be inserted and account id
    *@returntype contact List
    **/
  public static List<Contact> createTestContactRecords(Integer numContactsPerAcct, Id receiveId)
  {      
        List<Contact> contactList = new List<Contact>();
            for (Integer k=0;k<numContactsPerAcct;k++) {
                contactList.add(new Contact(firstname='Test'+k,
                                     lastname='Test'+k,
                                     AccountId=receiveId));
            }
        insert contactList;
        return contactList;
  }
  /**
    *@method test method to insert Opportunity records
    *@param number of opportunity record to be inserted and account id
    *@returntype opportunity List
    **/
  public static List<Opportunity> createTestOpportunityRecords(Integer numOpportunityPerAcct, Id receiveId)
  {      
        List<Opportunity> opportunityList = new List<Opportunity>();
            for (Integer m=0;m<numOpportunityPerAcct;m++) {
                opportunityList.add(new Opportunity(Name='Test'+m,StageName ='Closed Won',CloseDate= Date.parse('05/22/2012')
                                    ,AccountId=receiveId));
            }
        insert opportunityList;
        return opportunityList;
  }
  /**
    *@method test method to insert Lead records
    *@param number of Lead record to be inserted and account id
    *@returntype Lead List
    **/
  public static List<Lead> createTestLeadRecords(Integer numLeadPerAcct)
  {      
        List<Lead> leadList = new List<Lead>();
        for(Integer n=0;n<numLeadPerAcct;n++) 
        {
            Lead leadObject = new Lead(LastName='Test',Company ='Mohit',Status='Open');
            leadList.add(leadObject);
        }
        insert leadList;
        return leadList;
    }
    public static List<Country_List__c> createCountryRecords()
    {
        List<Country_List__c> options = new List<Country_List__c>();
        options.add(new Country_List__c(Name='India',Country__c='India'));
        options.add(new Country_List__c(Name='France',Country__c='France'));
        options.add(new Country_List__c(Name='Italy',Country__c='Italy'));
        options.add(new Country_List__c(Name='USA',Country__c='USA'));
        insert options;
        return options;
    }
    public static List< City__c> createCityCountryRecords()
    {
        List<Country_List__c> options = new List<Country_List__c>();
        options.add(new Country_List__c(Name='India',Country__c='India'));
        options.add(new Country_List__c(Name='France',Country__c='France'));
        options.add(new Country_List__c(Name='Italy',Country__c='Italy'));
        options.add(new Country_List__c(Name='USA',Country__c='USA'));
        insert options;
        List< City__c> cityOptions = new List< City__c>();
        cityOptions.add(new City__c(Name='Kolkata',City__c='Kolkata',Country__c='India'));
        cityOptions.add(new City__c(Name='Pune',City__c='Pune',Country__c='India'));
        cityOptions.add(new City__c(Name='Mumbai',City__c='Mumbai',Country__c='India'));
        cityOptions.add(new City__c(Name='New Delhi',City__c='New Delhi',Country__c='India'));
        insert cityOptions;
        return cityOptions;
    }
    public static List<SelectOption> createLanguageRecords()
    {
        Student__c student= new Student__c(Student_Name__c='Mohit');
        insert student;
        List<SelectOption> languageOptions = new List<SelectOption>();
        languageOptions.add(new SelectOption('English','English'));
        languageOptions.add(new SelectOption('French','French'));
        languageOptions.add(new SelectOption('Spanish','Spanish'));
        return languageOptions;
    }
    public static List<Student__c> createTestStudentRecords(Integer numberStudents)
  {
        List<Student__c> studentList=new List<Student__c>();
        for(Integer i=0;i<numberStudents;i++) {
            Student__c studentObject = new Student__c(Student_Name__c='TestAccount' + i);
            studentList.add(studentObject);
        }
        insert studentList;
        return studentList;
  }
  public static List<JsonObject__c> createTestJsonRecords(Integer jsonRecords)
  {
        List<JsonObject__c> jsonList=new List<JsonObject__c>();
        for(Integer i=0;i<jsonRecords;i++) {
            JsonObject__c jsonObject = new JsonObject__c(JsonField__c='{"Name":"suryajit", "ObjectName" : "Account"}',IsProcessed__c=false);
            jsonList.add(jsonObject);
        }
        insert jsonList;
        return jsonList;
  }
}
    
