using {
    managed,
    Currency,
    temporal,
    Country,
    cuid,
    extensible,
    sap.common.CodeList
} from '@sap/cds/common';
using {
    ECO_ACT_OBJECT,
    CorporateMD,
    SCREEN_CRITER_TEMPLT,
    ScreeningCriteriaTemplate,
    ProfitCenterObject,
    PlantObject,
    EnvObjectiveObject,
    ContributionTypeObject
} from './ReferenceData';
using {
    GUID,
    Description,
    ProfitCenter,
    CostCenter,
    FiscalYear,
    GSCEN,
    Plant,
    Account,
    AccountType,
    GFIndicator,
    AcctTypeObject
} from './commonTypes';

entity EUTObject : managed {
    key ID            : GUID;
    Description       : Description;
    RBUKRS            : Association to one CorporateMD @title : 'Company';
    PRCTR             : Association to one ProfitCenterObject @title : 'Profit Center';
    //GJAHR             : FiscalYear; //moved to EUT_Activities
    WERKS             : Association to one PlantObject @title : 'Plant';
    Activities        : Composition of many EUT_Activities
                            on Activities.EUT_Object = $self @title : 'Economic Activities';
   // CRITICALIT : CRITICALIT;
}

entity EUT_Activities : managed {
    key ID              : GUID;
    Scenario            : GSCEN;
    GJAHR               : FiscalYear;
    EUT_Object          : Association to one EUTObject @title : 'EUT Reporting Object';
    EA_Object           : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    Financial_Input     : Association to many FINANCIAL_INPUT 
                            on Financial_Input.EUT_ACTIVITIES =$self @title : 'Financial Inputs';
    //This association lead to entity from v1 data model - to be removed and replaced by 3 new entities
    Screening_Input     : Association to many EUT_SCREENING_INPUT 
                            on Screening_Input.EUT_ACTIVITIES =$self @title : 'EUT Screening Inputs';
    SCInput             : Association to many SCInput 
                            on SCInput.EUT_ACTIVITIES =$self @title : 'Substantial Contribution Inputs';
    DNSHInput           : Association to many DNSHInput 
                            on DNSHInput.EUT_ACTIVITIES =$self @title : 'DNSH Contribution Inputs';
    MSInput             : Association to many MSInput 
                            on MSInput.EUT_ACTIVITIES =$self @title : 'Minimum Safeguards Inputs';                                                        
                                                   
};

//@Aggregation.CustomAggregate #KSL : 'Edm.Decimal'
@Aggregation.CustomAggregate #RKCUR : 'Edm.String'
@Aggregation.CustomAggregate #HSL : 'Edm.Decimal'
@Aggregation.CustomAggregate #RHCUR : 'Edm.String'
entity FINANCIAL_INPUT : managed {
    key ID              : GUID ;
    RBUKRS              : Association to one CorporateMD @title : 'Company';
    GJAHR               : FiscalYear;
    MATNR               : MaterialNumber;
    WERKS               : Association to one PlantObject @title : 'Plant';
    RCNTR               : CostCenter;
    PRCTR               : Association to one ProfitCenterObject;
    RLDNR               : Ledger;
    RACCT               : Account;
    KSL                 : AmountGC;
    POPER               : PostingPeriod;
    RKCUR               : GCurrency @title : 'Global Currency';
    HSL                 : AmountCC @title : 'Amount in Company Currency';
    RHCUR               : Currency @title : 'Company Currency';
    AWREF               : ReferenceDocument;
    AWITEM              : ReferenceItem;
    BUDAT               : Date;
    GSCEN               : GSCEN;
    RACCT_TYPE          : Association to one AcctTypeObject @title : 'Account Type';
    GF_INDICATOR        : GFIndicator;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    criticality         : Integer;
};

//This is an entity from v1 data model - to be removed and replaced by 3 new entities
entity EUT_SCREENING_INPUT : managed {
    key ID              : GUID ;
    //GJAHR               : FiscalYear; removed
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    //GSCEN               : GSCEN; removed
    CRITER              : Association to one SCREEN_CRITER_TEMPLT @title : 'Screening Criterion';
    Env_Ob              : Association to one EnvObjectiveObject;
    Typ_Cont           : Association to one ContributionTypeObject;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    CRITICALITY : Integer;
};
entity SCInput : managed {
    key ID              : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject;
    TYP_CONT            : Association to one ContributionTypeObject;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    CRITICALITY         : Integer;
};
entity DNSHInput : managed {
    key ID              : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject;
    TYP_CONT            : Association to one ContributionTypeObject;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    CRITICALITY         : Integer;
};
entity MSInput : managed {
    key ID              : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject;
    TYP_CONT            : Association to one ContributionTypeObject;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    CRITICALITY         : Integer;
};


type MaterialNumber     : String @title : 'Material Number';
type Ledger             : String @title : 'Ledger';
type PostingPeriod      : String @title : 'Posing Period';
type GCurrency          : Currency @title : 'Global Currency' @Semantics.currencyCode;
type AmountGC           : Decimal @title : 'Amount in Global Currency' @Common.IsCurrency @Semantics.amount.currencyCode : 'GCurrency' @DefaultAggregation : #SUM;
type CCurrency          : Currency @title : 'Company Currency' @Semantics.currencyCode;
type AmountCC           : Decimal @title : 'Amount in Company Currency' @Common.IsCurrency @Semantics.amount.currencyCode : 'CCurrency';
type ReferenceDocument  : String @title : 'Reference Document';
type ReferenceItem      : String @title : 'Reference Item';
type Indicator_InVal    : String @title : 'Input Value (Y/N)';

type InputValue         : Decimal @title : 'Input Value';
