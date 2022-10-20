
const cds = require('@sap/cds')

module.exports = cds.service.impl( async function() {
    this.after('READ', 'ScreeningCriteriaTemplate', screenTem => {
        const scr = Array.isArray(screenTem) ? screenTem : [screenTem]
            scr.forEach ( scr => {
           switch(true){
             case  (scr.COMB_UNIT == null &&  scr.CALC_MEAS == null && scr.TYP_PLANT == null) :
                scr.HELP_P = true;
                break;
            case  (scr.COMB_UNIT != null ||  scr.CALC_MEAS != null && scr.TYP_PLANT != null) :
                    scr.HELP_P = false;
                    break;
            default :
                    scr.HELP_P = false;
                    break;    
            }
        })  
       }        
    );
               
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







