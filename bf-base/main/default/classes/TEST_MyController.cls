/**
 * Created by krisjacobs on 10/10/2019.
 */
@IsTest
public with sharing class TEST_MyController {

   @IsTest
   private static void test_retrieveAccountData(){
      Set<Id> accountIds = new Set<Id>{'0011X00000NeY52QAF'};

      AccountDataStore accountStore = AccountDataStore.getInstance();
      String key = 'accounts_by_ids';

      List<Account> accounts = (List<Account>)accountStore.getMockData(key);
      accounts.add(new Account(Name = 'test kris'));
      accountStore.findEntry(key)
              .setMockData(accounts);

      Test.startTest();

      accounts = (List<Account>) MyController.getAccounts(JSON.serialize(accountIds));
      System.debug(LoggingLevel.DEBUG, 'accounts: ' + accounts);

      System.assert(!accounts.isEmpty());

      Test.stopTest();
   }
}