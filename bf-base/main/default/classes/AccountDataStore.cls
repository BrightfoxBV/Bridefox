/**
 * Created by krisjacobs on 09/10/2019.
 */

public with sharing class AccountDataStore extends BFDataStore {
   private static AccountDataStore instance;

   public static AccountDataStore getInstance(){
      if (instance == null){
         System.debug('create new instance');
         instance = new AccountDataStore();
      }
      return instance;
   }

   public AccountDataStore (){
      /**
      * @description retrieve accounts with a set of account ids
      * @param arg0 Set of account ids Set<Id>
      * @return List of Accounts
      */
      newEntry('accounts_by_ids')
         .setSOQLQuery('SELECT Id, Name FROM Account WHERE Id IN :arg0');

      newEntry('contact_with_account_by_accountId')
              .setSOQLQuery('SELECT Id, FirstName, Account.Name FROM Contact WHERE AccountId IN :arg0');






      Id accountId = fflib_IDGenerator.generate(Account.SObjectType);
      mockdata.put('account',
              new Map<Id, SObject>{accountId => new Account(Id = accountId, Name = 'test account')}
      );

      Id contactId = fflib_IDGenerator.generate(Account.SObjectType);
      mockdata.put('contact',
              new Map<Id, SObject>{contactId => new Contact(Id = contactId, FirstName = 'test', LastName='test', AccountId = accountId)}
      );

      relationshipDefinitions.put('contact',
              new Map<String, Relationship>{'account' => new Relationship('account',  'accountId')}
      );
   }
}