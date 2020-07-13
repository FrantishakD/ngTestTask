@isTest
public with sharing class ImageSyncTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createImages();
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