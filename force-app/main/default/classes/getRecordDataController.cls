public with sharing class getRecordDataController {
 //@AuraEnabled is annotation enables LWC to access below apex method
 //(cacheable=true) is for caching the data on client side storage without waiting for server trips. Which imporves the performance
 @AuraEnabled(cacheable=true)
  public static List<Knowledge__kav> getAcounts() {
      system.debug([SELECT Id,question__c, answer__c FROM Knowledge__kav]);
  return [SELECT Id,question__c, answer__c FROM Knowledge__kav];
  }
}