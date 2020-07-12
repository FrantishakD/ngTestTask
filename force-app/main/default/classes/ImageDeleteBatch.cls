global class ImageDeleteBatch implements Database.batchable<SObject> {
    global List<String> newImagesSourceIds;

    global Database.QueryLocator start(Database.BatchableContext info){
        return Database.getQueryLocator('SELECT Id FROM Image__c WHERE Source_Id__c NOT IN :newImagesSourceIds');
    }    

    global void execute(Database.BatchableContext info, List<Image__c> scope){        
        Database.delete(scope, false);
    }  

    global void finish(Database.BatchableContext info){

    }
}
