public class ERPIntegrationService {

    @future(callout=true)
    public static void sendPartnerDataAsync(
        Id applicationId
    ) {
        System.debug('FUTURE METHOD STARTED');
        // Query Application Record
        Partner_Application__c application = [

            SELECT Id,
                   Company_Name__c,
                   Business_Email__c,
                   Region__c,
                   Application_Status__c
            FROM Partner_Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        Http http = new Http();

        HttpRequest request = new HttpRequest();

        request.setEndpoint(
            'https://postman-echo.com/post'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        // JSON Body
        Map<String, Object> requestBody =
            new Map<String, Object>();

        requestBody.put(
            'companyName',
            application.Company_Name__c
        );

        requestBody.put(
            'email',
            application.Business_Email__c
        );

        requestBody.put(
            'region',
            application.Region__c
        );

        requestBody.put(
            'status',
            application.Application_Status__c
        );

        String jsonBody =
            JSON.serialize(requestBody);

        request.setBody(jsonBody);

        // Send Callout
        HttpResponse response =
            http.send(request);

        System.debug(
            'Async Response: ' +
            response.getBody()
        );

        System.debug(
            'Status Code: ' +
            response.getStatusCode()
        );
    }
}