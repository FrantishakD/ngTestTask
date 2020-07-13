@isTest
global class ImageMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://jsonplaceholder.typicode.com/photos', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{ "albumId": 1, "id": 1, "title": "test", "url": "https://www.testupdated.test/", "thumbnailUrl": "https://www.test.test/" },' +
          '{ "albumId": 1, "id": 3, "title": "test insert", "url": "https://www.test.test/", "thumbnailUrl": "https://www.test.test/" }]');
        res.setStatusCode(200);
        return res;
    }
}