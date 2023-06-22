public class getArticlesController {
	 @AuraEnabled(cacheable=true)
  public static List<Knowledge__kav> getArticles() {
      //system.debug([SELECT Id,question__c, answer__c FROM Knowledge__kav]);
  return [SELECT Id,question__c, answer__c FROM Knowledge__kav];
  }
}