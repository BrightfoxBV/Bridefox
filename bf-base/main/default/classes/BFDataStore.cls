/**
 * Created by krisjacobs on 09/10/2019.
 */

public abstract class BFDataStore implements BFDataStoreInterface{
   private Map<String, StoreEntry> entries = new Map<String, StoreEntry>();
   private String currentKey;
   protected Map<String, Map<Id, SObject>> mockdata = new Map<String, Map<Id, SObject>>();
   protected Map<String, Map<String, RelationShip>> relationshipDefinitions = new Map<String, Map<String, RelationShip>>();

   public BFDataStore newEntry (String key){
      this.entries.put(key, new StoreEntry());
      this.currentKey = key;
      return this;
   }

   public BFDataStore findEntry (String key){
      if (!this.entries.containsKey(key)) throw new KeyNotFoundException ('Key "' + key + '" not found in data store');
      this.currentKey = key;
      return this;
   }

   public void updateMockData (String key, StoreEntry entry){
      if (!this.entries.containsKey(key)) throw new KeyNotFoundException ('Key "' + key + '" not found in data store');
      this.entries.get(key).mockData = entry;
   }

   public BFDataStore setSOQLQuery (String soqlQuery){
      this.entries.get(currentKey).soqlQuery = soqlQuery;
      return this;
   }

   public String getSOQLQuery (String key){
      if (!this.entries.containsKey(key)) throw new KeyNotFoundException ('Key "' + key + '" not found in data store');
      return this.entries.get(key).soqlQuery;
   }

   public BFDataStore setMockData (Object mockdata){
      this.entries.get(currentKey).mockData = mockdata;
      return this;
   }

   public Object getMockData (String key){
      if (!this.entries.containsKey(key)) throw new KeyNotFoundException ('Key "' + key + '" not found in data store');
      String query = this.entries.get(key).soqlQuery;

      //Parse query
      String columnsString = query.toLowerCase().substringBetween('SELECT', 'FROM');
      List<String> columns = columnsString.split(',');

      System.debug(LoggingLevel.DEBUG, 'columns: ' + columns);

      //Loop columns
      for (String col : columns){
         //check if
      }

      return null;
   }

   public class StoreEntry {
      String soqlQuery {get;set;}
      Object mockData {get;set;}
   }

   public class KeyNotFoundException extends Exception {}

   public class Relationship {
      public String referencesToSObject {get;set;}
      public String fieldName {get;set;}

      public Relationship (String referencesToSObject, String fieldName){
         this.referencesToSObject = referencesToSObject;
         this.fieldName = fieldName;
      }
   }
}