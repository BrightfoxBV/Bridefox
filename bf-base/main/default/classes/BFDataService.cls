/**
 * Created by krisjacobs on 09/10/2019.
 */

public with sharing class BFDataService {
   public static List<SObject> retrieveData (String key, BFDataStore dataStore, List<Object> args){
      //Max allowed args is 10 for the moment
      Integer maxArguments = 10;
      if (args.size() > maxArguments) throw new MaxArgumentsException('max number of arguments is ' + maxArguments);

      //Define args
      Object arg0 = args.size() >= 1 ? args[0] : null;
      Object arg1 = args.size() >= 2 ? args[1] : null;
      Object arg2 = args.size() >= 3 ? args[2] : null;
      Object arg3 = args.size() >= 4 ? args[3] : null;
      Object arg4 = args.size() >= 5 ? args[4] : null;
      Object arg5 = args.size() >= 6 ? args[5] : null;
      Object arg6 = args.size() >= 7 ? args[6] : null;
      Object arg7 = args.size() >= 8 ? args[7] : null;
      Object arg8 = args.size() >= 9 ? args[8] : null;
      Object arg9 = args.size() >= 10 ? args[9] : null;

      //Main code
      if (!Test.isRunningTest()){
         return Database.query(dataStore.getSOQLQuery(key));
      } else {
         return (List<SObject>)dataStore.getMockData(key);
      }
   }

   public class MaxArgumentsException extends exception {}
}