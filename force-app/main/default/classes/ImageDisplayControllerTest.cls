@isTest
public class ImageDisplayControllerTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createImages();
    }

    @isTest
    static void sendEmailTest(){
        Integer emailbefore = Limits.getEmailInvocations();
        ImageDisplayController.sendEmail(ImageDisplayController.getImages(), 'test@test.com');
        System.assertEquals(emailbefore + 1, Limits.getEmailInvocations());
    }
}