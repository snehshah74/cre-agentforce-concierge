public with sharing class DeterminePriorityAction {

    public class PriorityRequest {
        @InvocableVariable(required=true)
        public String assetId;
    }

    public class PriorityResult {
        @InvocableVariable
        public String priority;
        @InvocableVariable
        public String reason;
    }

    @InvocableMethod(label='Determine Maintenance Priority' description='Looks up equipment reading and calculates case priority based on deviation from normal range')
    public static List<PriorityResult> determinePriority(List<PriorityRequest> requests) {
        List<PriorityResult> results = new List<PriorityResult>();

        for (PriorityRequest req : requests) {
            PriorityResult res = new PriorityResult();

            Asset a = [SELECT Current_Reading__c, Normal_Range_Low__c, Normal_Range_High__c
                       FROM Asset WHERE Id = :req.assetId LIMIT 1];

            Decimal midpoint = (a.Normal_Range_Low__c + a.Normal_Range_High__c) / 2;
            Decimal deviation = Math.abs(a.Current_Reading__c - midpoint);
            Decimal rangeSpan = a.Normal_Range_High__c - a.Normal_Range_Low__c;

            if (deviation > rangeSpan) {
                res.priority = 'High';
                res.reason = 'Reading significantly outside normal operating range';
            } else if (deviation > (rangeSpan / 2)) {
                res.priority = 'Medium';
                res.reason = 'Reading moderately outside normal operating range';
            } else {
                res.priority = 'Low';
                res.reason = 'Reading within acceptable variance';
            }
            results.add(res);
        }
        return results;
    }
}
