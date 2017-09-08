@isTest
public with sharing class TestClassCustomSettings 
{
     public static testmethod void positivecountryTestClassCustomSettings()
     {    
        Country_List__c[] options=TestDataFactory.createCountryRecords();
        List<SelectOption> countryOptions = new List<SelectOption>();
        CountryStatePicker customObject = new CountryStatePicker();
        countryOptions=customObject.getCountriesSelectList();
        system.assertEquals(options.size()+1,countryOptions.size());
        
     }
     public static testmethod void positiveCityTestClassCustomSettings()
     {    
        City__c[] cityOptions=TestDataFactory.createCityCountryRecords();
        CountryStatePicker customObject = new CountryStatePicker();
        List<SelectOption> cityFinalOptions = new List<SelectOption>();
        customObject.country='India';
        cityFinalOptions=customObject.getCitiesSelectList();
        system.assertEquals(cityOptions.size(),cityFinalOptions.size());
     }
     
     public static testmethod void negativeCityTestClassCustomSettings()
     {    
        Country_List__c[] options=TestDataFactory.createCountryRecords();
        City__c[] cityOptions=TestDataFactory.createCityCountryRecords();
        CountryStatePicker customObject = new CountryStatePicker();
        List<SelectOption> cityFinalOptions = new List<SelectOption>();
        customObject.country='Italy';
        cityFinalOptions=customObject.getCitiesSelectList();
        system.assertNotEquals(cityOptions.size(),cityFinalOptions.size());
     }
     public static testmethod void nullCityTestClassCustomSettings()
     {    
        Country_List__c[] options=TestDataFactory.createCountryRecords();
        City__c[] cityOptions=TestDataFactory.createCityCountryRecords();
        CountryStatePicker customObject = new CountryStatePicker();
        List<SelectOption> cityFinalOptions = new List<SelectOption>();
        customObject.country='-- Select One --';
        cityFinalOptions=customObject.getCitiesSelectList();
        system.assertNotEquals(cityOptions.size(),cityFinalOptions.size());
     }
}