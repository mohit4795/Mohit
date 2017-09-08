public with sharing class CountryStatePicker 
{
    public String city { get; set; }
    public String country {get; set;}  
    public List<SelectOption> getCountriesSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));       
 
        Map<String, Country_List__c> countries = Country_List__c.getAll();
         
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
        countryNames.sort();
         
        for (String countryName : countryNames) {
            Country_List__c country = countries.get(countryName);
            options.add(new SelectOption(country.Country__c, country.Name));
        }
        return options;
    }
    public List<SelectOption> getCitiesSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        Map<String, City__c> allCities = City__c.getAll();
 
        Map<String, City__c> cities = new Map<String, City__c>();
        for(City__c city : allCities.values()) {
            if (city.Country__c == this.country) {
                cities.put(city.name, city);
            }
        }
         
        List<String> cityNames = new List<String>();
        cityNames.addAll(cities.keySet());
        cityNames.sort();
         
        for (String cityName : cityNames) {
            City__c city = cities.get(cityName);
            options.add(new SelectOption( city.Country__c,city.City__c));
        }
        return options;
    }
    
      
}