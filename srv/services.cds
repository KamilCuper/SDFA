using {
    sap.common.Languages as languages,
    sap.common.Currencies as currencies,
    sap.common.Countries as countries
} from '@sap/cds/common';


using {
    EUTObject as Eobject,
    EUT_Activities as Eactivities,
    FINANCIAL_INPUT as financialinput,
    EUT_SCREENING_INPUT as screeninginput
} from '../db/EUTObject';
using {
    ACC_TYPE_MAPPING as accountmapping,
    EA_MAPPING as ecoactmapping
} from '../db/Mappings';
using { 
    CorporateMD as corporatemd,
    ProfitCenterObject as profitcenter,
    PlantObject as plant,
    SECTOR_OBJECT as sector,
    ECO_ACT_OBJECT as ecoobject,
    SCREEN_CRITER_TEMPLT as screencriter,
    ECON_CRITER_APPL as criterappl
} from '../db/ReferenceData';
using {
    AcctTypeObject as accounttype
} from '../db/commonTypes';


@path     : 'sevice/SDFA'

service DataService {

    @odata.draft.enabled
    entity ACC_TYPE_MAPPING as projection on accountmapping;
        annotate accountmapping with @odata.draft.enabled;
    entity EA_MAPPING as projection on ecoactmapping
        annotate ecoactmapping with @odata.draft.enabled;
    @odata.draft.enabled
    entity EUTObject as projection on Eobject order by ID;
   // @odata.draft.enabled
    entity EUT_Activities as projection on Eactivities;
    //@odata.draft.enabled
    entity FINANCIAL_INPUT as projection on financialinput;
    //@odata.draft.enabled
    entity EUT_SCREENING_INPUT as projection on screeninginput;
    @odata.draft.enabled
    entity CorporateMD as projection on corporatemd;
    entity ProfitCenterObject as projection on profitcenter;
    entity PlantObject as projection on plant;
    entity SECTOR_OBJECT as projection on sector;
    entity ECO_ACT_OBJECT as projection on ecoobject;
    entity SCREEN_CRITER_TEMPLT as projection on screencriter;
    entity ECON_CRITER_APPL as projection on criterappl;
    entity AcctTypeObject as projection on accounttype
}