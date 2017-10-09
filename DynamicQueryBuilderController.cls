/**
  *@controllerClass generate dynmamic SOQl query
  **/
public with sharing class DynamicQueryBuilderController 
{
    public String objectName{get; set;}
    public String fieldString{get; set;}
    public List<SelectOption> objectNameList;
    public String recordSortOrder{get; set;}
    public List<SelectOption> recordSortOrderList;
    public String recordLimit{get; set;}
    public List<SelectOption> recordLimitList;
    public List<String> addFieldList{get; set;}
    public List<SelectOption> toSelectList;
    public List<String> removeFieldList{get; set;}
    public List<SelectOption> selectedList;
    public String orderByField{get; set;}
    public List<SelectOption> orderByList;
    public String searchString;
    public List<sObject> sObjectList{get; set;}
    public List<String> fieldValues;
    public String nameField{get; set;}    
    /**
      *@constructor method
      **/
    public DynamicQueryBuilderController()
    {
    	objectNameList = new List<SelectOption>();
    	setObjectNameList(new List<SelectOption>());
    	recordSortOrderList = new List<SelectOption>();
    	setRecordSortOrderList(new List<SelectOption>());
    	recordLimitList = new List<SelectOption>();
    	setRecordLimitList(new List<SelectOption>());
    	addFieldList = new List<String>();
    	toSelectList = new List<SelectOption>();
		removeFieldList = new List<String>();
		selectedList = new List<SelectOption>();
		orderByList = new List<SelectOption>();
    	orderByList.add(new SelectOption('NONE','--- SELECT ORDER BY FIELD ---'));
    	fieldValues = new List<String>();
    }
    /**
      *@method that will set all object in a list.
      **/
    public void setObjectNameList(List<SelectOption> oNameList)
    {
    	objectNameList.add(new SelectOption('NONE','--- SELECT OBJECT ---'));
    	for(Schema.SObjectType objectNames : Schema.getGlobalDescribe().values())
    		if(objectNames.getDescribe().isAccessible() && objectNames.getDescribe().isCreateable() && objectNames.getDescribe().isQueryable())
    			oNameList.add(new SelectOption(objectNames.getDescribe().getName(),objectNames.getDescribe().getName()));
    	oNameList.sort();
    	objectNameList.addall(oNameList);
    }
    /**
      *@method that will return the list of all objects.
      **/
    public List<SelectOption> getObjectNameList(){
    	return objectNameList;
    }
    /**
      *@method that will sort the records ,got from SOQL query
      **/   
    public void setRecordSortOrderList(List<SelectOption> rSortOrderList){
    	rSortOrderList.add(new SelectOption('ASC','Ascending'));
    	rSortOrderList.add(new SelectOption('DESC','Descending'));
    	recordSortOrderList = rSortOrderList;
    	recordSortOrder='ASC';
    }
    /**
      *@method that will return the list of sorted records.
      **/
    public List<SelectOption> getRecordSortOrderList(){
    	return recordSortOrderList;
    }
    /**
      *@method that will set the limits on records to be searched.
      **/
    public void setRecordLimitList(List<SelectOption> rLimitList){
    	rLimitList.add(new SelectOption('500','500'));
    	rLimitList.add(new SelectOption('1000','1000'));
    	rLimitList.add(new SelectOption('5000','5000'));
    	rLimitList.add(new SelectOption('50000','50000'));
    	recordLimitList.addAll(rLimitList);
    	recordLimit = '500';
    }
    /**
      *@method that will return the list of limits to be selected.
      **/
    public List<SelectOption> getRecordLimitList(){
    	return recordLimitList;
    }
    /**
      *@method that will display aal fields in a picklist, on the basis of selected Object.  
      **/
    public void setToSelectList(List<SelectOption> tSelect){
    	if(objectName != '' && objectName != 'NONE'){
    		Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
	    	Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
    		for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values()){
    			if(!fieldName.getDescribe().isNamefield() && fieldName.getDescribe().isAccessible() && fieldName.getDescribe().getType()!=Schema.DisplayType.address && fieldName.getDescribe().getType()!=Schema.DisplayType.base64 && fieldName.getDescribe().getType()!=Schema.DisplayType.DataCategoryGroupReference && fieldName.getDescribe().getType()!=Schema.DisplayType.EncryptedString)
    				tSelect.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    			else if(fieldName.getDescribe().isNamefield()){
    				selectedList.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    				nameField=fieldName.getDescribe().getName();
    			}
    		}
    		tSelect.sort();
    	}
    	toSelectList.addAll(tSelect);
    }
    /**
      *@method that will return list of all fields in a picklist,
      **/
    public List<SelectOption> getToSelectList(){
    	return toSelectList;
    }
    public void setSelectedList(List<SelectOption> slected){
    	selectedList.addAll(slected);
    }
    public List<SelectOption> getSelectedList(){
    	return selectedList;
    }
    /**
      *@method that will display aal fields in a picklist, on the basis of selected Object.  
      **/
    public void setOrderByList(List<SelectOption>  oByList){
    	if(objectName != '' && objectName != 'NONE'){
    		Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
	    	Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
    		for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values())
    			if(fieldName.getDescribe().isAccessible() && fieldName.getDescribe().getType()!=Schema.DisplayType.MultiPicklist && fieldName.getDescribe().getType()!=Schema.DisplayType.address && fieldName.getDescribe().getType()!=Schema.DisplayType.EncryptedString && fieldName.getDescribe().getType()!=Schema.DisplayType.TextArea && fieldName.getDescribe().getType()!=Schema.DisplayType.base64)
    				oByList.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    		oByList.sort();
    	}
    	orderByList.add(new SelectOption('NONE','--- SELECT ORDER BY FIELD ---'));
    	orderByList.addAll(oByList);
    }
     /**
       *@method that will return list of all fields in a picklist,
       **/
    public List<SelectOption> getOrderByList(){
    	return orderByList;
    }
    public String getSearchString(){
    	return searchString;
    }
    /**
      *@method that will set the SOQL query to be executed.
      **/
    public void setSearchString(){
    	sObjectList = null;
    	searchString = '';
    	if(selectedList.size()>0 && objectName != null && objectName != 'NONE' && orderByField != null && orderByField != 'NONE' && recordLimit != null && recordLimit != 'NONE'){
    	fieldString = '';
    	for(SelectOption option : selectedList){
    		if(fieldString != '')
    			fieldString += ', ';
    		fieldString += option.getValue();
    	}
    	searchString = 'SELECT ' + fieldString + ' FROM ' + objectName + ' ORDER BY ' + orderByField + ' ' + recordSortOrder + ' NULLS LAST LIMIT ' + recordLimit;
    	}
    }
    public List<String> getFieldValues(){
    	return fieldValues;
    }
    public List<String> setFieldValues(){
    	for(SelectOption option : selectedList)
    		fieldValues.add(option.getValue());
    	System.debug(fieldValues);
    	return fieldValues;
    }
    
    public void setFieldAndOrderLists(){
    	orderByField='NONE';
    	toSelectList.clear();
    	selectedList.clear();
    	orderByList.clear();
    	setToSelectList(new List<SelectOption>());
    	setOrderByList(new List<SelectOption>());
    	setSearchString();
    }
    /**
      *@method that will add selected fields to be queried, in another picklist.
      **/
    public PageReference add(){
    	for(String str : addFieldList){
    		Integer j;
    		for(Integer i = 0 ; i < toSelectList.size() ; i++)
    			if(toSelectList[i].getLabel()==str){
    				j=i;
    				break;
    			}
    		selectedList.add(toSelectList.get(j));
    		toSelectList.remove(j);
    	}
    	setSearchString();
    	return null;
    }
    /**
      *@method that will remove selected fields to be queried, from a  picklist.
      **/
    public PageReference remove(){
    	for(String str : removeFieldList){
    		Integer j;
    		for(Integer i = 0 ; i < selectedList.size() ; i++)
    			if(selectedList[i].getLabel()==str) {
    				j=i;
    				break;
    			}
    		toSelectList.add(selectedList.get(j));
    		selectedList.remove(j);
    	}
    	setSearchString();
    	return null;
    }
    /**
      *@method that will execute the SOQL query.
      **/
    public PageReference executeQuery() {
    	setSearchString();
    	fieldValues.clear();
    	setFieldValues();
    	if(searchString == '' || searchString == null)
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Select Field to order by'));
    	else
    		sObjectList = Database.query(searchString);
    	return null;
    }
    public boolean getContainFieldName() {
    	Integer j = -1;
    	for(Integer i = 0 ; i < fieldValues.size() ; i++)
    		if(fieldValues[i]==nameField){
    			j=i;
    			break;
    		}	
    	if(j != -1) {
    		fieldValues.remove(j);
    		return true;
    	} else
    		return false;
    }
}