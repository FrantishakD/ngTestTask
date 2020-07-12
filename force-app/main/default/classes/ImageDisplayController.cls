public with sharing class ImageDisplayController {

    @AuraEnabled(cacheable=true)
    public static List<Image__c> getImages(){
        return [SELECT Id, Name, URL__c, Thumbnail_URL__c FROM Image__c LIMIT 50000];
    }

    @AuraEnabled
    public static void sendEmail(List<Image__c> images, String email){
        if(email != null && images != null && images.size() > 0){
            String htmlBody = '<html> <head></head> <body> ';
            for(Image__c image : images){
                htmlBody += getHtmlImg(image);
            }
            htmlBody += '</body> </html>';

            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(new String[] {email});
            message.setSaveAsActivity( false );
            message.setSubject('Filtered Images');
            message.setHtmlBody(htmlBody);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        }
    }

    private static String getHtmlImg(Image__c image){
        return '<img src="' + image.URL__c + '" alt="' + image.Name + '" title="' + image.Name + '"> ';
    }
}