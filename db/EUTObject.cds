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
    ScreeningCriteriaTemplate,
    ProfitCenterObject,
    PlantObject,
    EnvObjectiveObject,
    CriteriaApplicability,
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
    WERKS             : Association to one PlantObject @title : 'Plant';
    Activities        : Composition of many EUT_Activities
                            on Activities.EUT_Object = $self @title : 'Economic Activities';
    MSInput            : Association to many MSInput 
                            on MSInput.RBUKRS = $self.RBUKRS @title : 'Minimum Safeguards Inputs';   
}

entity EUT_Activities : managed {
    key ID              : GUID;
    Scenario            : GSCEN;
    GJAHR               : FiscalYear;
    EUT_Object          : Association to one EUTObject @title : 'EUT Reporting Object';
    EA_Object           : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    Financial_Input     : Association to many FINANCIAL_INPUT 
                            on Financial_Input.EUT_ACTIVITIES =$self @title : 'Financial Inputs';
    CCM_Input           : Association to many CCM_Input 
                            on CCM_Input.EUT_ACTIVITIES =$self @title : 'Climate Mitigation Inputs';
    CCA_Input           : Association to many CCA_Input 
                            on CCA_Input.EUT_ACTIVITIES =$self @title : 'Climate Adaptation Inputs';
    POL_Input           : Association to many POL_Input 
                            on POL_Input.EUT_ACTIVITIES =$self @title : 'Pollution Inputs';
    BIO_Input           : Association to many BIO_Input 
                            on BIO_Input.EUT_ACTIVITIES =$self @title : 'Biodiversity Inputs';
    WAT_Input           : Association to many WAT_Input 
                            on WAT_Input.EUT_ACTIVITIES =$self @title : 'Water Inputs';
    CEC_Input           : Association to many CEC_Input 
                            on CEC_Input.EUT_ACTIVITIES =$self @title : 'Circular Economy Inputs';
                                                                                 
                                                   
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


entity MSInput : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    GJAHR               : FiscalYear;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    TYP_CONT            : Association to one ContributionTypeObject;
    RBUKRS              : Association to one CorporateMD @title : 'Company Name';
    CRITICALITY         : Integer;
};


entity CCM_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;

};

entity CCA_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;
};



entity POL_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;
};

entity BIO_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;
};

entity WAT_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;
};

entity CEC_Input : managed {
    key ID               : GUID ;
    INDICATOR_IV        : Indicator_InVal;
    KEY_FIGURE          : InputValue;
    CRITER              : Association to one ScreeningCriteriaTemplate @title : 'Screening Criterion';
    ENV_OB              : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    EUT_ACTIVITIES      : Association to one EUT_Activities;
    APPL                : Association to one CriteriaApplicability;
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
