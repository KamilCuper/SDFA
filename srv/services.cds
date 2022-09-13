using {
    sap.common.Languages as languages,
    sap.common.Currencies as currencies,
    sap.common.Countries as countries
} from '@sap/cds/common';


using {
    EUTObject as Eobject,
    EUT_Activities as Eactivities,
    FINANCIAL_INPUT as financialinput,
    EUT_SCREENING_INPUT as screeninginput, //to remove after data model v1 changes
    SCInput as sc,
    DNSHInput as dnsh,
    MSInput as ms
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
    SCREEN_CRITER_TEMPLT as screencriter,   //to remove after data model v1 changes
    ECON_CRITER_APPL as criterappl, //to remove after data model v1 changes
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
    entity EUTObject as projection on Eobject order by ID;
    //@odata.draft.enabled
    entity EUT_Activities as projection on Eactivities;
    @odata.draft.enabled
    entity FINANCIAL_INPUT as projection on financialinput;
    entity SCREEN_CRITER_TEMPLT as projection on screencriter; //to remove after data model v1 changes
    @odata.draft.enabled
    entity EUT_SCREENING_INPUT as projection on screeninginput; //to remove after data model v1 changes
    @odata.draft.enabled
    entity SCInput as projection on sc;
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
    entity ECON_CRITER_APPL as projection on criterappl; //to remove after data model v1 changes
    entity AcctTypeObject as projection on accounttype;
    entity EnvObjectiveObject as projection on envobjective;
    entity ContributionTypeObject as projection on contrtype;
    entity CriteriaApplicability as projection on critappl;
    entity ScreeningCriteriaTemplate as projection on crittemplate;

    entity CriterView as 
        select  
                EcoActivity.SECTOR.Description as Sector, 
                EcoActivity.Description as EcoActivity,
                EcoActivity.EUT_Eligible,
                CRITER.CRITER_DESC as Criterion,
                TYP_CONT.Description as Contribution_Type,
                key CRITER
        from ECON_CRITER_APPL
    ;
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
    entity EUTObject as projection on Eobject order by ID;
    //@odata.draft.enabled
    entity EUT_Activities as projection on Eactivities;
    @odata.draft.enabled
    entity FINANCIAL_INPUT as projection on financialinput;
    @odata.draft.enabled
    entity EUT_SCREENING_INPUT as projection on screeninginput; //to remove after data model v1 changes
    @odata.draft.enabled
    entity SCInput as projection on sc;
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
    entity SECTOR_OBJECT as projection on sector;
    @odata.draft.enabled
    entity ECO_ACT_OBJECT as projection on ecoobject;
    entity SCREEN_CRITER_TEMPLT as projection on screencriter; //to remove after data model v1 changes
    entity EnvObjectiveObject as projection on envobjective;
    entity ContributionTypeObject as projection on contrtype;
    entity ECON_CRITER_APPL as projection on criterappl; //to remove after data model v1 changes
    entity AcctTypeObject as projection on accounttype;
    entity CriteriaApplicability as projection on critappl;
    entity ScreeningCriteriaTemplate as projection on crittemplate;

    entity CriterView as 
        select  
                EcoActivity.SECTOR.Description as Sector, 
                EcoActivity.Description as EcoActivity,
                EcoActivity.EUT_Eligible,
                CRITER.CRITER_DESC as Criterion,
                TYP_CONT.Description as Contribution_Type,
                key CRITER
        from ECON_CRITER_APPL
    ;
    /*entity YearsListView as
        select
            key EUT_Object.GJAHR as FiscalYear
        from EUT_Activities
        group by EUT_Object.GJAHR
    ;*/
}