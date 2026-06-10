@isTest
public class PartnerApplicationTriggerHandlerTest {

    @isTest
    static void testLeadScoringAndAssignment() {

        // Create Regional Manager
        Regional_Manager__c manager = new Regional_Manager__c(
            Name = 'John Smith',
            Region__c = 'Asia',
            Manager_Email__c = 'john@test.com'
        );

        insert manager;

        // Create Partner Application
        Partner_Application__c application =
            new Partner_Application__c(

                Company_Name__c = 'Global Tech Ltd',
                Business_Email__c = 'global@test.com',
                GSTIN__c = '29ABCDE1234F1Z5',
                Region__c = 'Asia',
                Company_Size__c = 'Enterprise',
                Annual_Revenue__c = 5000000
            );

        Test.startTest();

        insert application;

        Test.stopTest();

        // Query inserted record
        Partner_Application__c savedApplication = [

            SELECT Id,
                   Application_Status__c,
                   Regional_Manager__c
            FROM Partner_Application__c
            WHERE Id = :application.Id
        ];

        // Verify Status
        System.assertEquals(
            'Draft',
            savedApplication.Application_Status__c
        );

        // Verify Manager Assignment
        System.assertNotEquals(
            null,
            savedApplication.Regional_Manager__c
        );
    }
}