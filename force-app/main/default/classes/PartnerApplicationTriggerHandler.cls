public class PartnerApplicationTriggerHandler {

    public static void beforeInsertOrUpdate(
        List<Partner_Application__c> applications
    ) {

        Set<String> gstinSet = new Set<String>();
        Set<String> emailSet = new Set<String>();

        // Collect values and apply lead scoring
        for(Partner_Application__c app : applications) {

            // Lead scoring logic
            if(app.Annual_Revenue__c != null &&
               app.Annual_Revenue__c > 1000000 &&
               String.isBlank(app.Application_Status__c)) {

                app.Application_Status__c = 'Under Review';
            }

            // Collect GSTIN values
            if(app.GSTIN__c != null) {
                gstinSet.add(app.GSTIN__c);
            }

            // Collect Email values
            if(app.Business_Email__c != null) {
                emailSet.add(app.Business_Email__c);
            }
        }

        // Query existing applications
        List<Partner_Application__c> existingApplications;

        if(Trigger.isUpdate) {

            existingApplications = [

                SELECT Id,
                       GSTIN__c,
                       Business_Email__c
                FROM Partner_Application__c
                WHERE (GSTIN__c IN :gstinSet
                   OR Business_Email__c IN :emailSet)
                AND Id NOT IN :Trigger.newMap.keySet()
            ];

        } else {

            existingApplications = [

                SELECT Id,
                       GSTIN__c,
                       Business_Email__c
                FROM Partner_Application__c
                WHERE GSTIN__c IN :gstinSet
                   OR Business_Email__c IN :emailSet
            ];
        }

        // Duplicate validation
        for(Partner_Application__c app : applications) {

            for(Partner_Application__c existingApp :
                existingApplications) {

                // Duplicate GSTIN check
                if(app.GSTIN__c != null &&
                   app.GSTIN__c == existingApp.GSTIN__c) {

                    app.GSTIN__c.addError(
                        'Duplicate GSTIN detected.'
                    );
                }

                // Duplicate Email check
                if(app.Business_Email__c != null &&
                   app.Business_Email__c ==
                   existingApp.Business_Email__c) {

                    app.Business_Email__c.addError(
                        'Duplicate Business Email detected.'
                    );
                }
            }
        }

        // Auto assign regional managers
        assignRegionalManagers(applications);
    }

    public static void assignRegionalManagers(
        List<Partner_Application__c> applications
    ) {

        // Collect regions
        Set<String> regionSet = new Set<String>();

        for(Partner_Application__c app : applications) {

            if(app.Region__c != null) {
                regionSet.add(app.Region__c);
            }
        }

        // Query regional managers
        List<Regional_Manager__c> managerList = [

            SELECT Id,
                   Name,
                   Region__c
            FROM Regional_Manager__c
            WHERE Region__c IN :regionSet
        ];

        // Create map
        Map<String, Id> regionManagerMap =
            new Map<String, Id>();

        for(Regional_Manager__c manager : managerList) {

            regionManagerMap.put(
                manager.Region__c,
                manager.Id
            );
        }

        // Assign managers
        for(Partner_Application__c app : applications) {

            if(regionManagerMap.containsKey(app.Region__c)) {

                app.Regional_Manager__c =
                    regionManagerMap.get(app.Region__c);
            }
        }
    }
}