public with sharing class CustomLabelApexDemoController 
{
    public string customLabelValue{get;set;}
    public CustomLabelApexDemoController()
    {
        customLabelValue = System.Label.testCustomLabel;
    }
        
}