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
    PRCTR             : Association to one ProfitCenterObject;
    //GJAHR             : FiscalYear; //moved to EUT_Activities
    WERKS             : Association to one PlantObject;
    Activities        : Composition of many EUT_Activities
                            on Activities.EUT_Object = $self @title : 'Economic Activities';
    CRITICALIT : CRITICALIT;
}

entity EUT_Activities : managed {
    key ID            : GUID;
    Scenario          : GSCEN;
    GJAHR             : FiscalYear;
    EUT_Object        : Association to one EUTObject @title : 'EUT Reporting Object';
    EA_Object         : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    Financial_Input   : Association to many FINANCIAL_INPUT 
                            on Financial_Input.EUT_ACTIVITIES =$self @title : 'Financial Inputs';
    Screening_Input   : Association to many EUT_SCREENING_INPUT 
                            on Screening_Input.EUT_ACTIVITIES =$self @title : 'EUT Screening Inputs';
                                                   
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
    WERKS               : Association to one PlantObject;
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
    RACCT_TYPE          : Association to one AcctTypeObject;
    GF_INDICATOR        : GFIndicator;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    criticality         : Integer;
};

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
    HELP : Help;
    HELP_I : Help_I;
    HELP_P : Help_P;
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
type Help         : Boolean @title : 'Help';
type Help_I         : Boolean @title : 'Help_I';
type Help_P         : Boolean @title : 'Help_P';
type CRITICALIT         : Integer @title : 'Criticality';