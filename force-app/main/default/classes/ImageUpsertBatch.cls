global class ImageUpsertBatch implements Database.batchable<Image__c>{
    global List<Image__c> newImages;

    global List<Image__c> start(Database.BatchableContext info){
        return newImages;
    }    

    global void execute(Database.BatchableContext info, List<Image__c> scope){        
        Database.upsert(scope, Image__c.Fields.Source_Id__c, false);
    }  

    global void finish(Database.BatchableContext info){
        List<String> sourceIds = new List<String>();
        for(Image__c image : newImages){
            sourceIds.add(image.Source_Id__c);
        }
        ImageDeleteBatch deleteBatch = new ImageDeleteBatch();
        deleteBatch.newImagesSourceIds = sourceIds;
        Database.executeBatch(deleteBatch);
    }
}
