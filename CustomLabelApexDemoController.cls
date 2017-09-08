/**
  *@class that is controller for visualforce page to show custom label
  **/
public with sharing class CustomLabelApexDemoController 
{
    public string customLabelValue{get;set;}
    /**
      *@method that will get the value of custom label and will show that on page
      **/
    public CustomLabelApexDemoController()
    {
        customLabelValue = System.Label.testCustomLabel;
    }
        
}