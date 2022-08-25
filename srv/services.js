
const cds = require('@sap/cds')


module.exports = cds.service.impl(async function() {
    this.after('READ', 'EUT_SCREENING_INPUT', eutInput => {
        const eut = Array.isArray(eutInput) ? eutInput : [eutInput];
        eut.forEach(eut => {
            switch (true){
               case (eut.INDICATOR_IV=='YES') :
                eut.CRITICALITY = 3; 
                eut.HELP = true;
                eut.HELP_I = false;
                break;
                case (eut.INDICATOR_IV=='NO') :
                    eut.CRITICALITY = 1; 
                    eut.HELP = false;
                    eut.HELP_I = true;
                break;
                case (eut.CRITER.CRIT_UNIT !='INDICATOR (Y/N)' && eut.KEY_FIGURE >= eut.CRITER.CRIT_L && eut.KEY_FIGURE <= eut.CRITER.CRIT_U) :
                        eut.CRITICALITY = 3; 
                        eut.HELP = false;
                        eut.HELP_I = true;
                        break;
                case (eut.CRITER.CRIT_UNIT !='INDICATOR (Y/N)' && ((eut.KEY_FIGURE < eut.CRITER.CRIT_L || eut.KEY_FIGURE > eut.CRITER.CRIT_U)       )) :
                            eut.CRITICALITY = 1; 
                            eut.HELP = false;
                            eut.HELP_I = true;
                            break;
                default :
                                eut.CRITICALITY = 0; 
                                eut.HELP = true;
                                eut.HELP_I = false;
                                break;
                
            }
           switch(true){
             case  (eut.CRITER.COMB_UNIT == null &&  eut.CRITER.CALC_MEAS == null && eut.CRITER.TYP_PLANT == null) :
                eut.HELP_P = true;
                break;
            case  (eut.CRITER.COMB_UNIT != null ||  eut.CRITER.CALC_MEAS != null && eut.CRITER.TYP_PLANT != null) :
                    eut.HELP_P = false;
                    break;
            default : 
                    eut.HELP_P = false;
                    break;    
            }  
            
        }        
        );
    });

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







