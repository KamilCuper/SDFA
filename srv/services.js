const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {
    this.after('READ', 'FINANCIAL_INPUT', financialData => {
        const records = Array.isArray(financialData) ? financialData : [financialData];
        records.forEach(records => {
            if (records.KSL >= 400000) {
                records.criticality = 3;
            } else if (records.KSL < 400000 && records.KSL >= 100000) {
                records.criticality = 0;
            } else {
                records.criticality = 1;
            }
        });
    });
});