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
    GUID,
    Description,
    Comment,
    Account,
    AccountType,
    GFIndicator,
    ProfitCenter,
    Plant,
    FiscalYear,
    AcctTypeObject
} from './commonTypes';
using {
    CorporateMD,
    ECO_ACT_OBJECT,
    ProfitCenterObject,
    PlantObject
} from './ReferenceData';


entity ACC_TYPE_MAPPING : managed {
    key ID      : GUID;
    Company     : Association to CorporateMD @title : 'Company';
    RACCT       : Account;
    RACCT_TYPE  : Association to  AcctTypeObject @title : 'Account Type';
    GF_INDICATOR: GFIndicator;
    Comment     : Comment;
}

entity EA_MAPPING : managed {
    key ID          : GUID;
    Company         : Association to one CorporateMD @title : 'Company';
    PRCTR           : Association to one ProfitCenterObject @title : 'Profit Center';
    WERKS           : Association to one PlantObject @title : 'Plant';
    GJAHR           : FiscalYear;
    ECO_ACT         : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
}