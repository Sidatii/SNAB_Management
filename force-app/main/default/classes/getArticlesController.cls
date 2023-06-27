public class getArticlesController {
  @AuraEnabled(cacheable=true)
  public static List<KnowledgeArticleWrapper> getArticles() {
      List<KnowledgeArticleWrapper> articleData = new List<KnowledgeArticleWrapper>();
      
      for (Knowledge__kav article : [SELECT Id, Title, question__c, answer__c,
                                     (SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension
                                      FROM ContentDocumentLinks LIMIT 1)
                                     FROM Knowledge__kav]) {
          List<ContentDocumentLink> fileLinks = article.ContentDocumentLinks;
          List<ContentDocument> files = new List<ContentDocument>();
          
          for (ContentDocumentLink fileLink : fileLinks) {
              files.add(fileLink.ContentDocument);
          }
          
          String relatedFilesData = relatedFiles(files);
          articleData.add(new KnowledgeArticleWrapper(article, files, relatedFilesData));
      }
      
      return articleData;
  }
  
  public class KnowledgeArticleWrapper {
      @AuraEnabled
      public Knowledge__kav article { get; set; }
      
      @AuraEnabled
      public List<ContentDocument> files { get; set; }
      
      @AuraEnabled
      public String filesData { get; set; }
      
      public KnowledgeArticleWrapper(Knowledge__kav article, List<ContentDocument> files, String filesData) {
          this.article = article;
          this.files = files;
          this.filesData = filesData;
      }
  }
  
  public static String relatedFiles(List<ContentDocument> contentDocuments) {
      String base64Data = '';
      
      if (!contentDocuments.isEmpty()) {
          ContentDocument contentDocument = contentDocuments[0];
          List<ContentVersion> versions = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :contentDocument.Id ORDER BY CreatedDate DESC LIMIT 1];
          
          if (!versions.isEmpty()) {
              ContentVersion latestVersion = versions[0];
              base64Data = 'data:image/' + contentDocument.FileExtension + ';charset=utf-8;base64, ';
              base64Data += EncodingUtil.base64Encode(latestVersion.VersionData);
          }
      }
      
      return base64Data;
  }
}
