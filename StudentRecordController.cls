/**
  *@class controller for visual force page that will create a new student record.
  **/
public with sharing class StudentRecordController 
{
    public string newLanguage{get; set;}
    public string selectedLanguage{get;set;}
    Public Student__c emp = new Student__c();
    public Student__c studentRecord {
    get {
      if (studentRecord == null)
        studentRecord = new Student__c();
      return studentRecord;
    }
    set;
  }
  /**
    *@method that will create a picklist for language to be selected.
    **/
  public List<SelectOption> getLanguages() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('English','English'));
        options.add(new SelectOption('French','French'));
        options.add(new SelectOption('Spanish','Spanish'));
        return options;
    }
    /**
    *@method that will pass a value of language that is selected from picklist to the visual force page.
    **/
    public void afterSelectedLanguage()
    {
        if(selectedLanguage=='French')
        {
           newLanguage='fr';
        }
        else if(selectedLanguage=='English')
        {
            newLanguage='en_US';
        }
        else
        {
            newLanguage='es_MX';
        }
    
    }
  /**
    *@method that will print the thank you message after insertion of record.
    **/
   public PageReference saveRecord()
   {
   try {
      insert studentRecord; // inserts the new record into the database
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new contact.'));
    }
    return page.StudentThankYou;
   } 
}