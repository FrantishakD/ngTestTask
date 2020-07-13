public with sharing class ImageSyncUtils {

    @future(callout=true)
    public static void startSync(){
        List<Image__c> retrievedImages = getImages(RestCalloutService.getImagesInfo());
        System.debug('retrievedImages ' + retrievedImages);
        Database.upsert(retrievedImages, Image__c.Fields.Source_Id__c, false);
        List<String> sourceIds = new List<String>();
        for(Image__c image : retrievedImages){
            sourceIds.add(image.Source_Id__c);
        }
        List<Image__c> imagesToDelete = [SELECT Id FROM Image__c WHERE Source_Id__c NOT IN :sourceIds];
        Database.delete(imagesToDelete, false);
    }

    private static List<Image__c> getImages(List<RestCalloutService.ImageWrapper> retrievedImageWrappers){
        List<Image__c> retrievedImages = new List<Image__c>();
        for(RestCalloutService.ImageWrapper wrapper : retrievedImageWrappers){
            retrievedImages.add(wrapper.getImage());
        }
        return retrievedImages;
    }
}