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
    PlantObject
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
    GFIndicator
} from './commonTypes';

entity EUTObject : managed {
    key ID            : GUID;
    RBUKRS            : Association to one CorporateMD @title : 'Company';
    PRCTR             : Association to one ProfitCenterObject;
    GJAHR             : FiscalYear;
    WERKS             : Association to one PlantObject;
    Activities        : Composition of many EUT_Activities
                            on Activities.EUT_Object = $self @title : 'Economic Activities';
}

entity EUT_Activities : managed {
    key ID            : GUID;
    Scenario          : GSCEN;
    EUT_Object        : Association to one EUTObject @title : 'EUT Reporting Object';
    EA_Object         : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    Financial_Input   : Association to many FINANCIAL_INPUT 
                            on Financial_Input.EUT_ACTIVITIES =$self @title : 'Financial Inputs';
    Screening_Input   : Association to many EUT_SCREENING_INPUT 
                            on Screening_Input.EUT_ACTIVITIES =$self @title : 'EUT Screening Inputs';                            
};

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
    RACCT_TYPE          : AccountType;
    GF_INDICATOR        : GFIndicator;
    EUT_ACTIVITIES      : Association to one EUT_Activities;
};

entity EUT_SCREENING_INPUT : managed {
    key ID              : GUID ;
    GJAHR               : FiscalYear;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    GSCEN               : GSCEN;
    CRITER              : Association to one SCREEN_CRITER_TEMPLT @title : 'Screening Criterion';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
};



type MaterialNumber     : String @title : 'Material Number';
type Ledger             : String @title : 'Ledger';
type PostingPeriod      : String @title : 'Posing Period';
type GCurrency          : Currency @title : 'Global Currency' @Semantics.currencyCode;
type AmountGC           : Decimal @title : 'Amount in Global Currency' @Common.IsCurrency @Semantics.amount.currencyCode : 'GCurrency';
type CCurrency          : Currency @title : 'Company Currency' @Semantics.currencyCode;
type AmountCC           : Decimal @title : 'Amount in Company Currency' @Common.IsCurrency @Semantics.amount.currencyCode : 'CCurrency';
type ReferenceDocument  : String @title : 'Reference Document';
type ReferenceItem      : String @title : 'Reference Item';
type Indicator_InVal    : Boolean @title : 'Input Value (Y/N)';
type InputValue         : Decimal @title : 'Input Value';