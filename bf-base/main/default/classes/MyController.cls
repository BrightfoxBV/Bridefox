/**
 * Created by krisjacobs on 10/10/2019.
 */

public with sharing class MyController {
   @AuraEnabled
   public static List<Account> getAccounts(String accountIdsJSON){
      List<Object> args = new List<Object>();
      args.add((Set<Id>)JSON.deserialize(accountIdsJSON, Set<Id>.class));

      AccountDataStore accountStore = AccountDataStore.getInstance();
      List<Account> accounts = BFDataService.retrieveData('accounts_by_ids', accountStore, args);
      return accounts;
   }
}