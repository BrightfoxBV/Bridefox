/**
 * Created by krisjacobs on 17/09/2019.
 */

public with sharing class AccountController {
   @AuraEnabled(cacheable=true)
   public static List<Account> findAccounts(String searchKey) {
      String key = '%' + searchKey + '%';
      return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
   }
}