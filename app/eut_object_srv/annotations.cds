using EUTObjectService as service from '../../srv/services';


/*************************************************************************************************/
//               Annotations for External Entities fields display
/*************************************************************************************************/
annotate service.EUTObject with {
  ID @UI.Hidden;
};

annotate service.CorporateMD with {
    RBUKRS @Common.Text : {
        $value : Description,
        UI.TextArrangement : #TextFirst,
    }
};

annotate service.ProfitCenterObject with {
    PRCTR @Common.Text : {
        $value : DESCR,
        UI.TextArrangement : #TextFirst,
    }
};

annotate service.PlantObject with {
    WERKS @Common.Text : {
        $value : DESCR,
        UI.TextArrangement: #TextFirst,
    }
};

annotate service.EUT_Activities with {
    EA_Object @(
        Common: {
            Text : EA_Object.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Economic Activities',
                CollectionPath: 'ECO_ACT_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:EA_Object_ECO_ACT,
                    ValueListProperty: 'ECO_ACT'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'EUT_Eligible'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'ENB_ACT'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Comment'}
                ]
            }
        }
    );
};


/*************************************************************************************************/
//               Selection Fields, Selection Variant and Presentation Variant
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.SelectionFields : [
        RBUKRS_RBUKRS,
        GJAHR,
        PRCTR_PRCTR,
        WERKS_WERKS
    ]
);

/*************************************************************************************************/
//               Annotations for EUTObject fields display and Value Help lists
/*************************************************************************************************/
annotate service.EUTObject with {
    RBUKRS @(
        Common : {
            Text  : RBUKRS.Description,
            TextArrangement : #TextFirst,
            ValueListWithFixedValues : true
        }
    );
    GJAHR @(
        Common: {
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Years',
                CollectionPath: 'YearsListView',
                Parameters: [
                    { 
                        $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty: GJAHR,
                        ValueListProperty: 'FiscalYear'
                    }
                ]
            }
        }
    );
    PRCTR @(
        Common: {
            Text: PRCTR.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
    WERKS @(
        Common: {
            Text: WERKS.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
};


/*************************************************************************************************/
//                      Annotations for LIST REPORT Page
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.LineItem: {
        $value:[
            {
                $Type : 'UI.DataField',
                Label : 'Company Code',
                Value : RBUKRS_RBUKRS,
                ![@UI.Importance] : #High
            },
            {
                $Type : 'UI.DataField',
                Label: 'Year',
                Value : GJAHR
            },
            {
                $Type : 'UI.DataField',
                Label: 'Profit Center',
                Value : PRCTR_PRCTR
            },
            {
                $Type : 'UI.DataField',
                Label: 'Plant',
                Value : WERKS_WERKS,
                ![@UI.Importance] : #High
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.Description,
                Label : 'Assigned EUT Activities'
            }
        ]
    }
);


/*************************************************************************************************/
//                      Annotations for EUT OBJECT Page - Header & Content
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS
        },
        Description : {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS
        }
    },
    UI.DataPoint #Year :{
        Value : GJAHR ,
        Title : 'Fiscal Year'
    },
    UI.DataPoint #ProfitCenter :{
        Value : PRCTR_PRCTR,
        Title : 'Profit Center'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#ProfitCenter'
        }
    ],    
    UI.LineItem #ContentGroup2: [
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object_ECO_ACT,
                Label : 'Assigned Economic Activities',
                //Target: Activities
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.EUT_Eligible
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.ENB_ACT
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.Comment
            }
        ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details on Economic Activities',
            ID    : 'Activities',
            Target: 'Activities/@UI.LineItem#Activities'
        }
    ]
    
);


/*************************************************************************************************/
//                    Annotations for EUT Activity OBJECT Page - Header
/*************************************************************************************************/
annotate service.EUT_Activities with @(
    UI.DataPoint #Company :{
        Value : EUT_Object.RBUKRS.Description ,
        Title : 'Company'
    },
    UI.DataPoint #Year :{
        Value : EUT_Object.GJAHR ,
        Title : 'Fiscal Year'
    },
    UI.DataPoint #Scenario :{
        Value : Scenario ,
        Title : 'Scenario'
    },
    UI.DataPoint #Activity :{
        Value : EA_Object_ECO_ACT ,
        Title : 'Economic Activity'
    },
    UI.DataPoint #Plant:{
        Value : EUT_Object.WERKS,
        Title : 'Plant'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Activity'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Company'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Plant'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Scenario'
        },
    ]
);

/*************************************************************************************************/
//                    Annotations for EUT Activity OBJECT Page - Content
/*************************************************************************************************/
annotate service.EUT_Activities with @(
    UI.LineItem #Activities: [
        {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT
            
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.EUT_Eligible,
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.ENB_ACT,
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.Comment,
        }
    ],
    
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Screening Inputs',
            ID    : 'ScreenInputs',
            Target: 'Screening_Input/@UI.LineItem#ScreenInputs'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Financial Inputs',
            ID    : 'FinInputs',
            Target: 'Financial_Input/@UI.LineItem#FinInputs'
        }
    ]
);


/*************************************************************************************************/
//                    Annotations for Financial Input OBJECT Page - Content
/*************************************************************************************************/
annotate service.FINANCIAL_INPUT with @(
    UI.LineItem #FinInputs: [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS,
            Label : 'Company Code'
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
            Label : 'Fiscal Year'
        },{
            $Type : 'UI.DataField',
            Value : MATNR,
            Label : 'Material Number'
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
            Label : 'Plant'
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR,
            Label : 'Cost Center'
        },
        /*{
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR,
            Label : 'Profit Center'
        },
        {
            $Type : 'UI.DataField',
            Value : RLDNR,
            Label : 'Ledger'
        },*/
        {
            $Type : 'UI.DataField',
            Value : RACCT,
            Label : 'Account Number'
        },
        {
            $Type : 'UI.DataField',
            Value : KSL,
            Label : 'Amount GC'                 
        },
        /*{
            $Type : 'UI.DataField',
            Value : POPER,
            Label : 'Posting Period'             
        },*/
        {
            $Type : 'UI.DataField',
            Value : RKCUR_code,
            Label : 'Global Currency'              
        },
        /*{
            $Type : 'UI.DataField',
            Value : HSL,
            Label : 'Amount CC'             
        },
        {
            $Type : 'UI.DataField',
            Value : RHCUR_code,
            Label : 'Company Currency'    
        },
        {
            $Type : 'UI.DataField',
            Value : AWREF,
            Label : 'Reference Document'
        },
        {
            $Type : 'UI.DataField',
            Value : AWITEM,
            Label : 'Reference Item'          
        },*/
        {
            $Type : 'UI.DataField',
            Value : BUDAT,
            Label : 'Posting Date'               
        },
        {
            $Type : 'UI.DataField',
            Value : GSCEN,
            Label : 'Scenario for Reporting'       
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code,
            Label : 'Account Type'       
        },
        {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR,
            Label: 'Green Finance Indicator'     
        }
    ]
);

/*************************************************************************************************/
//               Annotations for EUTObject fields display and Value Help lists
/*************************************************************************************************/
annotate service.FINANCIAL_INPUT with {
    RBUKRS @(
        Common : {
            Text  : RBUKRS.Description,
            TextArrangement : #TextFirst,
            ValueListWithFixedValues : true
        }
    );
    GJAHR @(
        Common: {
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Years',
                CollectionPath: 'YearsListView',
                Parameters: [
                    { 
                        $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty: GJAHR,
                        ValueListProperty: 'FiscalYear'
                    }
                ]
            }
        }
    );
    PRCTR @(
        Common: {
            Text: PRCTR.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
    WERKS @(
        Common: {
            Text: WERKS.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
};

/*************************************************************************************************/
//                    Annotations for EUT SCREENING CRITERIA OBJECT Page - Content
/*************************************************************************************************/
annotate service.EUT_SCREENING_INPUT with @(
    UI.LineItem #ScreenInputs : [
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT
        },
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_U,
            Label : 'Upper Limit'
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_L,
            Label : 'Lower Limit'
        },
    ]
);