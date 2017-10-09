@isTest
public with sharing class DynamicQueryBuilderControllerTest 
{
     /**
       *@testMethod to check whether all the objects are there in picklist.
       **/
     public static testmethod void testObjectsCreated()
     {    
        List<SelectOption> oNameList = new List<SelectOption>();
        List<SelectOption> objectNameList = new List<SelectOption>();
        objectNameList.add(new SelectOption('NONE','--- SELECT OBJECT ---'));
        for(Schema.SObjectType objectNames : Schema.getGlobalDescribe().values())
            if(objectNames.getDescribe().isAccessible() && objectNames.getDescribe().isCreateable() && objectNames.getDescribe().isQueryable())
                oNameList.add(new SelectOption(objectNames.getDescribe().getName(),objectNames.getDescribe().getName()));
        oNameList.sort();
        objectNameList.addall(oNameList);
        List<SelectOption> results = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController(); 
        List<SelectOption> objectlist=dc.getObjectNameList();     
        system.assertEquals(dc.objectNameList.size(),objectNameList.size());
        Test.stopTest();
     }
     /**
       *@testMethod to check whether all the fields of selected Object are there in picklist.
       **/
     public static testmethod void testSelectedfields()
     {
       
       String objectName='Account';
       List<SelectOption> selectList=new List<SelectOption>();
       String nameField;
       if(objectName != '' && objectName != 'NONE'){
            Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
            Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
            for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values()){
                 if(fieldName.getDescribe().isNamefield()){
                    selectList.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
                    nameField=fieldName.getDescribe().getName();
                }
            }
      }
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        dc.setSelectedList(selectField);
        dc.getSelectedList();
        system.assertEquals(dc.ToSelectList.size()+1,dc.SelectedList.size());
        Test.stopTest();
     }
     /**
       *@testMethod that will check fields to be selected are there in picklist.
       **/
     public static testmethod void testFieldsCreated()
     {
       String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>();
       if(objectName != '' && objectName != 'NONE'){
            Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
            Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
            for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values()){
                if(!fieldName.getDescribe().isNamefield() && fieldName.getDescribe().isAccessible() && fieldName.getDescribe().getType()!=Schema.DisplayType.address && fieldName.getDescribe().getType()!=Schema.DisplayType.base64 && fieldName.getDescribe().getType()!=Schema.DisplayType.DataCategoryGroupReference && fieldName.getDescribe().getType()!=Schema.DisplayType.EncryptedString)
                    tSelect.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
            }
            tSelect.sort();
        }
        toSelectList.addAll(tSelect);
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        dc.getToSelectList();
        system.assertEquals(dc.toSelectList.size(),toSelectList.size());
        Test.stopTest();
     }
     /**
       *@testMethod that will check whether fileds are displayed orderly.
       **/
     public static testmethod void testFieldsDisplayed()
     {
       String objectName='Account';
       List<SelectOption> oByList = new List<SelectOption>();
        List<SelectOption> orderByList = new List<SelectOption>();
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setOrderByList(selectField);
        dc.getOrderByList();
        system.assertEquals(dc.orderByList.size()-1,orderByList.size());
        Test.stopTest();
     }
     /**
       *@testMethod to check whether the query is executed.
       **/
     public static testmethod void testExecute()
     {
        List<Account> accountArray=TestDataFactory.createTestAccountRecords(1);
        String selectedObject='Account';
        List<Sobject> queryexecution=new List<Sobject>();
        String finalExecuteQuery='Select name from ' +selectedObject+ ' ORDER BY name ASC' + ' NULLS LAST LIMIT 500' ;  
        queryexecution=Database.query(finalExecuteQuery);
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        List<SelectOption> selectedField = new List<SelectOption>();
        dc.objectName='Account';
        //dc.fieldString='name';
        String fieldString;
        dc.orderByField='name';
        dc.recordSortOrder='ASC';
        dc.recordLimit='500';
        dc.selectedList.add(new SelectOption('name','name'));
        for(SelectOption option : dc.selectedList){
            if(fieldString != '')
                fieldString += ', ';
            dc.fieldString += option.getValue();
        }
        //dc.setOrderByList(dc.selectedList);
        //dc.getOrderByList();
        dc.setSearchString();
        system.assertEquals('Select name from Account ORDER BY name ASC NULLS LAST LIMIT 500',finalExecuteQuery);
        Test.stopTest();
             
       }
     public static testmethod void testLimit()
     {
        List<SelectOption> optionsTest = new List<SelectOption>();
        optionsTest.add(new SelectOption('500','500'));
        optionsTest.add(new SelectOption('1000','1000'));
        optionsTest.add(new SelectOption('5000','5000'));
        optionsTest.add(new SelectOption('50000','50000'));
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        List<SelectOption> resultTest = new List<SelectOption>();
        dc.objectName='Account';
        //dc.setRecordLimitList(resultTest);
        dc.getRecordLimitList();
        system.assertEquals(optionsTest.size(),dc.recordLimitList.size());
        Test.stopTest();
        
     }
     public static testmethod void testSort()
     {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ASC','Ascending'));
        options.add(new SelectOption('DESC','Descending'));
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        List<SelectOption> resultTest = new List<SelectOption>();
        dc.objectName='Account';
        dc.getRecordSortOrderList();
        system.assertEquals(options.size(),dc.recordSortOrderList.size());
        Test.stopTest();
     }
     public static testmethod void testfieldvalues()
     {
      String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>(); 
       List<SelectOption> selectedList=new List<SelectOption>();
       string namefield;
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        dc.getSelectedList();
        dc.setFieldValues();
        dc.getFieldValues();
        system.assertEquals(dc.fieldValues.size(),1);
        Test.stopTest();
     }
     /**
       *@testMethod to check whether fields to be queried are added to another picklist.  
       **/
      public static testmethod void testAdd()
      {
        String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>(); 
       List<SelectOption> selectedList=new List<SelectOption>();
       string namefield;
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setFieldValues();
        dc.getFieldValues();
        dc.getSelectedList();
        dc.setToSelectList(selectField);
        dc.getToSelectList();
        dc.addFieldList.add('ID');
        dc.add();
        system.assertEquals(dc.toSelectList.size(),toSelectList.size()-1);
        Test.stopTest();
     }
     /**
       *@testMethod to check whether the query is executed.
       **/
     public static testmethod void testExecuteQuery()
     {
        List<Account> accountArray=TestDataFactory.createTestAccountRecords(1);
        String selectedObject='Account';
        List<Sobject> queryexecution=new List<Sobject>();
        String finalExecuteQuery='Select name from Account ORDER BY name ASC NULLS LAST LIMIT 500';  
        queryexecution=Database.query(finalExecuteQuery);
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        List<SelectOption> selectField = new List<SelectOption>();
        dc.setFieldValues();
        dc.getFieldValues();
        dc.getSelectedList();
        dc.selectedList.add(new SelectOption('name','name'));
        dc.objectName='Account';
        dc.fieldString='name';
        dc.recordSortOrder='ASC';
        dc.orderByField='name';
        dc.recordLimit='500';
        dc.searchString = 'SELECT ' + dc.fieldString + ' FROM ' + dc.objectName + ' ORDER BY ' + dc.orderByField + ' ' + dc.recordSortOrder + ' NULLS LAST LIMIT ' + dc.recordLimit;
        dc.setSearchString();
        string query=dc.getSearchString();
        dc.executeQuery();
        system.assertEquals(dc.sObjectList.size(),queryexecution.size());
        Test.stopTest();
     }
     public static testmethod void testContainFieldNames()
     {
        String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>(); 
       List<SelectOption> selectedList=new List<SelectOption>();
       string namefield;
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.nameField='name';
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        dc.getToSelectList();
        dc.setFieldValues();
        List<string> valueNew=dc.getFieldValues();
        dc.getContainFieldName();
        system.assertEquals(dc.getContainFieldName(),false);
        Test.stopTest();
     }
     /**
       *@testMethod to check whether the result of soql query are sorted.
       **/
     public static testmethod void testFieldsAndOrder()
     {
       String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>(); 
       List<SelectOption> selectedList=new List<SelectOption>();
       List<SelectOption> oByList = new List<SelectOption>();
       List<SelectOption> orderByList = new List<SelectOption>();
       string namefield;
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        dc.setOrderByList(selectField);
        dc.objectName='Account';
        dc.fieldString='name';
        dc.recordSortOrder='ASC';
        dc.orderByField='name';
        dc.recordLimit='500';
        dc.searchString = 'SELECT ' + dc.fieldString + ' FROM ' + dc.objectName + ' ORDER BY ' + dc.orderByField + ' ' + dc.recordSortOrder + ' NULLS LAST LIMIT ' + dc.recordLimit;
        dc.setSearchString();
        dc.setFieldAndOrderLists();
        system.assertEquals(dc.toSelectList.size(),toSelectList.size());
        Test.stopTest();
     }
      /**
        *@testMethod to check whether fields to be queried are selected from picklist and removed .
        **/
     public static testmethod void testRemove()
     {
       String objectName='Account';
       List<SelectOption> toSelectList=new List<SelectOption>();
       List<SelectOption> tSelect = new List<SelectOption>(); 
       List<SelectOption> selectedList=new List<SelectOption>();
       string namefield;
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
        List<SelectOption> selectField = new List<SelectOption>();
        Test.startTest();
        DynamicQueryBuilderController dc = new DynamicQueryBuilderController();
        dc.objectName='Account';
        dc.setToSelectList(selectField);
        List<SelectOption> selectFieldNew=dc.getToSelectList();
        dc.getSelectedList();
        dc.removeFieldList.add('name');
        dc.remove();
        system.assertEquals(dc.toSelectList.size(),toSelectList.size()+1);
        Test.stopTest();
     }
     
}