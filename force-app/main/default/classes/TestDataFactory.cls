@isTest
public class TestDataFactory {
    public static List<Image__c> createImages(){
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

        List<Image__c> images = new List<Image__c>{existingImage, imageToDelete};
        insert images;
        return images;
    }
}
