@isTest
public with sharing class ImageSyncTest {
    @TestSetup
    static void makeData(){
        Image__c existingImage = new Image__c(
            Name = 'test',
            Source_Id__c = '1',
            Album_Id__c = '1',
            URL__c = 'https://www.test.test/',
            Thumbnail_URL__c = 'https://www.test.test/'
        );

        Image__c imageToDelete = new Image__c(
            Name = 'test to delete',
            Source_Id__c = '2',
            Album_Id__c = '1',
            URL__c = 'https://www.test.test/',
            Thumbnail_URL__c = 'https://www.test.test/'
        );

        insert new List<Image__c>{existingImage, imageToDelete};
    }

    @isTest
    static void testSync(){
        Test.setMock(HttpCalloutMock.class, new ImageMock());
        Test.startTest();
            ImageSyncScheduler scheduler = new ImageSyncScheduler();
            String jobId = System.schedule('ScheduledTest',
                '0 0 0 15 3 ? 2022', 
                scheduler);
            scheduler.execute(null);
        Test.stopTest();
        List<Image__c> existingImages = [SELECT Id FROM Image__c];
        System.assertEquals(2, existingImages.size());
        List<Image__c> deletedImages = [SELECT Id FROM Image__c WHERE Name = 'test to delete'];
        System.assertEquals(0, deletedImages.size());
        Image__c updatedImage = [SELECT Id, URL__c FROM Image__c WHERE Source_Id__c = '1'];
        System.assertEquals('https://www.testupdated.test/', updatedImage.URL__c);
        Image__c insertedImage = [SELECT Id, Name FROM Image__c WHERE Source_Id__c = '3'];
        System.assertEquals('test insert', insertedImage.Name);
    }
}
