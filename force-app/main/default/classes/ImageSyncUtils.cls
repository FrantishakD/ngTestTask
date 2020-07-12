public with sharing class ImageSyncUtils {

    public static void startSync(){
        List<Image__c> retrievedImages = getImages(RestCalloutService.getImagesInfo());
    }

    private static List<Image__c> getImages(List<RestCalloutService.ImageWrapper> retrievedImageWrappers){
        List<Image__c> retrievedImages = new List<Image__c>();
        for(RestCalloutService.ImageWrapper wrapper : retrievedImageWrappers){
            retrievedImages.add(wrapper.getImage());
        }
        return retrievedImages;
    }
}