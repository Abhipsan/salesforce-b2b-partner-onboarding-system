trigger PartnerApplicationTrigger 
on Partner_Application__c (before insert, before update) {

    if(Trigger.isBefore) {

        if(Trigger.isInsert || Trigger.isUpdate) {

            PartnerApplicationTriggerHandler.beforeInsertOrUpdate(
                Trigger.new
            );
        }
    }
}