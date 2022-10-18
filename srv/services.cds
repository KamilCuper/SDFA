using {
    sap.common.Languages as languages,
    sap.common.Currencies as currencies,
    sap.common.Countries as countries
} from '@sap/cds/common';


using {
    EUTObject as Eobject,
    EUT_Activities as Eactivities,
    FINANCIAL_INPUT as financialinput,
    SCInput as sc,
    DNSHInput as dnsh,
    MSInput as ms,
    CCM_Input as ccm,
    CCA_Input as cca,
    POL_Input as pol,
    BIO_Input as bio,
    WAT_Input as wat,
    CEC_Input as cec
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
    EnvObjectiveObject as envobjective,
    ContributionTypeObject as contrtype,
    CriteriaApplicability as critappl,
    ScreeningCriteriaTemplate as crittemplate
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
    @cds.odata.valuelist
    entity EUTObject as projection on Eobject order by ID;
    //@odata.draft.enabled
    entity EUT_Activities as projection on Eactivities;
    @odata.draft.enabled
    entity FINANCIAL_INPUT as projection on financialinput;
    @odata.draft.enabled
    entity SCInput as projection on sc;
    @odata.draft.enabled
    entity CCM_Input as projection on ccm;
    @odata.draft.enabled
    entity DNSHInput as projection on dnsh;
    @odata.draft.enabled
    entity MSInput as projection on ms;

    @odata.draft.enabled
    entity CorporateMD as projection on corporatemd;
    @odata.draft.enabled
    entity ProfitCenterObject as projection on profitcenter;
    @odata.draft.enabled
    entity PlantObject as projection on plant;
    @odata.draft.enabled
    entity SECTOR_OBJECT as projection on sector;
    @odata.draft.enabled
    entity ECO_ACT_OBJECT as projection on ecoobject;
    entity AcctTypeObject as projection on accounttype;
    entity EnvObjectiveObject as projection on envobjective;
    entity ContributionTypeObject as projection on contrtype;
    entity CriteriaApplicability as projection on critappl;
    entity ScreeningCriteriaTemplate as projection on crittemplate;

    entity MSInputCriteria as
        select
            key CRITER as Criteria,
            CRITER_DESCR as CriteriaDescription
        from ScreeningCriteriaTemplate
        where CRITER in ('MS_IBH','MS_ILO','MS_UNG','MS_OEC')

    /*entity YearsListView as
        select
            key EUT_Object.GJAHR as FiscalYear
        from EUT_Activities
        group by EUT_Object.GJAHR
    ;*/
}

service EUTObjectService {
    @odata.draft.enabled
    entity ACC_TYPE_MAPPING as projection on accountmapping;
    @odata.draft.enabled
    entity EA_MAPPING as projection on ecoactmapping
    @odata.draft.enabled
    @cds.odata.valuelist
    entity EUTObject as projection on Eobject order by ID;
    //@odata.draft.enabled
    entity EUT_Activities as projection on Eactivities;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity FINANCIAL_INPUT as projection on financialinput;
    @odata.draft.enabled
    entity SCInput as projection on sc;
    @odata.draft.enabled
    entity CCM_Input as projection on ccm;
    @odata.draft.enabled
    entity CCA_Input as projection on cca;
   @odata.draft.enabled
  entity POL_Input as projection on pol;
    @odata.draft.enabled
  entity BIO_Input as projection on bio;
    @odata.draft.enabled
    entity WAT_Input as projection on wat;
    @odata.draft.enabled
    entity CEC_Input as projection on cec;
    @odata.draft.enabled
    entity DNSHInput as projection on dnsh;
    @odata.draft.enabled
    entity MSInput as projection on ms;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity CorporateMD as projection on corporatemd;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity ProfitCenterObject as projection on profitcenter;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity PlantObject as projection on plant;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity SECTOR_OBJECT as projection on sector;
    @odata.draft.enabled
    @cds.odata.valuelist
    entity ECO_ACT_OBJECT as projection on ecoobject;
    entity EnvObjectiveObject as projection on envobjective;
    entity ContributionTypeObject as projection on contrtype;
    entity AcctTypeObject as projection on accounttype;
    entity CriteriaApplicability as projection on critappl;
    entity ScreeningCriteriaTemplate as projection on crittemplate;


    /*entity YearsListView as
        select
            key EUT_Object.GJAHR as FiscalYear
        from EUT_Activities
        group by EUT_Object.GJAHR
    ;*/
}