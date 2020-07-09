public with sharing class RestCalloutService {

    public static List<ImageWrapper> getImagesInfo(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://jsonplaceholder.typicode.com/photos');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<ImageWrapper> results = (List<ImageWrapper>) JSON.deserialize(response.getBody(), List<ImageWrapper>.class);
            return results;
        } else{
            System.debug('Error ' + response.getStatusCode());
            return null;
        }
    }

    public class ImageWrapper{
        public String albumId {get; set;}
        public String id {get; set;}
        public String title {get; set;}
        public String url {get; set;}
        public String thumbnailUrl {get; set;}

        public Image__c getImage(){
            return new Image__c(
                Name = this.title,
                Source_Id__c = this.id,
                Album_Id__c = this.albumId,
                URL__c = this.url,
                Thumbnail_URL__c = this.thumbnailUrl
            );
        }
    }
}
