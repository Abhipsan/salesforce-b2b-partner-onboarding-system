public with sharing class PartnerRegistrationController {

    @AuraEnabled
    public static String createPartnerApplication(

        String companyName,
        String businessEmail,
        String region
    ) {

        Partner_Application__c application =
            new Partner_Application__c(

                Company_Name__c = companyName,
                Business_Email__c = businessEmail,
                Region__c = region,
                Application_Status__c = 'Pending'
            );

        insert application;

        return 'Partner Application Created Successfully';
    }
}