@isTest
public with sharing class TestStudentRecordController 
{
    public static testmethod void positiveTestStudentRecordController()
    {
        SelectOption[] languageOptions=TestDataFactory.createLanguageRecords();
        StudentRecordController record =new StudentRecordController();
        List<SelectOption> languageSelected = new List<SelectOption>();
        languageSelected=record.getLanguages();
        system.assertEquals(languageSelected.size(),languageOptions.size());
    }
    public static testmethod void positiveChangeStudentRecordController()
    {
        SelectOption[] languageOptions=TestDataFactory.createLanguageRecords();
        StudentRecordController record =new StudentRecordController();
        record.selectedLanguage='French';
        record.afterSelectedLanguage();
        system.assertEquals(record.newLanguage,'fr');
    }  
    public static testmethod void negativeChangeStudentRecordController()
    {
        SelectOption[] languageOptions=TestDataFactory.createLanguageRecords();
        StudentRecordController record =new StudentRecordController();
        record.selectedLanguage='Spanish';
        record.afterSelectedLanguage();
        system.assertNotEquals(record.newLanguage,'fr');
    }
    public static testmethod void nullChangeStudentRecordController()
    {
        SelectOption[] languageOptions=TestDataFactory.createLanguageRecords();
        StudentRecordController record =new StudentRecordController();
        record.selectedLanguage='';
        record.afterSelectedLanguage();
        system.assertNotEquals(record.newLanguage,'fr');
    } 
    public static testmethod void positiveInsertStudentRecord()
    {
        Student__c[] studentArray=TestDataFactory.createTestStudentRecords(1);
        StudentRecordController record =new StudentRecordController();
        record.studentRecord=studentArray[0];
        record.saveRecord();
        system.assertEquals(studentArray[0],record.studentRecord);
    } 
    public static testmethod void negativeInsertStudentRecord()
    {
        Student__c[] studentArray=TestDataFactory.createTestStudentRecords(1);
        StudentRecordController record =new StudentRecordController();
        record.studentRecord=null;
        record.saveRecord();
        system.assertNotEquals(studentArray[0],record.studentRecord);
    } 
}