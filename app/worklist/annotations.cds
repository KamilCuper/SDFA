using DataService as service from '../../srv/services';
using from '../../db/EUTObject';
using from '../../db/ReferenceData';

annotate service.EUTObject with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR
        },
        {
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS
        }
    ],
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : RBUKRS_RBUKRS
            },
            {
                $Type : 'UI.DataField',
                Value : GJAHR
            },
            {
                $Type : 'UI.DataField',
                Value : PRCTR_PRCTR
            },
            {
                $Type : 'UI.DataField',
                Value : WERKS_WERKS
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'EUT Reporting Object',
            Target : '@UI.FieldGroup#GeneratedGroup1'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Economic Activities',
            ID    : 'Activities',
            Target: 'Activities/@UI.LineItem#Activities'
        }
    ]
);

annotate service.EUTObject with {
    RBUKRS @(
        Common: {
            Text: RBUKRS.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Companies',
                CollectionPath: 'CorporateMD',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:RBUKRS_RBUKRS,
                    ValueListProperty: 'RBUKRS'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'}
                ]
            }
        }
    );
    PRCTR @(
        Common: {
            Text: PRCTR.DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Profit Centers',
                CollectionPath: 'ProfitCenterObject',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:PRCTR_PRCTR,
                    ValueListProperty: 'PRCTR'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'DESCR'}
                ]
            }
        }
    );
    WERKS @(
        Common: {
            Text: WERKS.DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Plants',
                CollectionPath: 'PlantObject',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:WERKS_WERKS,
                    ValueListProperty: 'WERKS'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'DESCR'}
                ]
            }
        }
    );
};

annotate service.CorporateMD with{
RBUKRS      @title : 'Company Code';
Description @title : 'Description' 
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

annotate service.EUT_Activities with @(
    // Wanted to add a facet showing EUT Details in header, but EUT_Object/@UI.FieldGroup#GeneratedGroup1 does not show any values when it's in Header Facet. Find another way to show it
    /*UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'EUT Reporting Object',
            Target : 'EUT_Object/@UI.FieldGroup#GeneratedGroup1'
        }
    ],*/
    UI.HeaderInfo : {
        TypeName : 'Economic Activity',
        TypeNamePlural : 'Economic Activities',
        Title : {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT
        },
        Description : {
            $Type : 'UI.DataField',
            Value : Scenario
        }
    },
    UI.LineItem #Activities: [
        {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT
        },
        {
            $Type : 'UI.DataField',
            Value : Scenario
        },
        /*{
            $Type : 'UI.DataField',
            Value : EUT_Object_ID
        }*/
        
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT
        },
        {
            $Type : 'UI.DataField',
            Value : Scenario
        },
        {
            $Type : 'UI.DataField',
            Value : EUT_Object_ID
        }
        
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Financial Inputs',
            ID    : 'FinInputs',
            Target: 'Financial_Input/@UI.LineItem#FinInputs'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Screening Inputs',
            ID    : 'ScreenInputs',
            Target: 'Screening_Input/@UI.LineItem#ScreenInputs'
        }
        
    ],
    UI.FieldGroup #ActivityDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            /*{
                $Type : 'UI.DataField',
                Value : EUT_Object_ID,
                Label : 'EUT Reporting Object',
            },*/{
                $Type : 'UI.DataField',
                Value : EA_Object_ECO_ACT,
                Label : 'Economic Activity',
            },{
                $Type : 'UI.DataField',
                Value : Scenario,
                Label : 'Scenario',
            }
        ]
    }
)
;
annotate service.FINANCIAL_INPUT with @(
    UI.LineItem #FinInputs: [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
        },{
            $Type : 'UI.DataField',
            Value : MATNR
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
            Label : 'Plant'
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR
        },
        {
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR,
            Label : 'Profit Center'
        },
        {
            $Type : 'UI.DataField',
            Value : RLDNR
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT
        },
        {
            $Type : 'UI.DataField',
            Value : KSL                 
        },
         {
            $Type : 'UI.DataField',
            Value : POPER               
        },
         {
            $Type : 'UI.DataField',
            Value : RKCUR_code               
        },
         {
            $Type : 'UI.DataField',
            Value : HSL                 
        },
         {
            $Type : 'UI.DataField',
            Value : RHCUR_code          
        },
         {
            $Type : 'UI.DataField',
            Value : AWREF               
        },
         {
            $Type : 'UI.DataField',
            Value : AWITEM              
        },
         {
            $Type : 'UI.DataField',
            Value : BUDAT,
            Label : 'Posting Date'               
        },
         {
            $Type : 'UI.DataField',
            Value : GSCEN               
        },
         {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code          
        },
         {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR        
        }
    ],
    UI.FieldGroup #Group1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
        },{
            $Type : 'UI.DataField',
            Value : MATNR
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
            Label : 'Plant'
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR
        },
        {
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR,
            Label : 'Profit Center'
        },
        {
            $Type : 'UI.DataField',
            Value : RLDNR
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT
        },
        {
            $Type : 'UI.DataField',
            Value : KSL                 
        },
         {
            $Type : 'UI.DataField',
            Value : POPER               
        },
         {
            $Type : 'UI.DataField',
            Value : RKCUR_code               
        },
         {
            $Type : 'UI.DataField',
            Value : HSL                 
        },
         {
            $Type : 'UI.DataField',
            Value : RHCUR_code          
        },
         {
            $Type : 'UI.DataField',
            Value : AWREF               
        },
         {
            $Type : 'UI.DataField',
            Value : AWITEM              
        },
         {
            $Type : 'UI.DataField',
            Value : BUDAT,
            Label : 'Posting Date'               
        },
         {
            $Type : 'UI.DataField',
            Value : GSCEN               
        },
         {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code          
        },
         {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR        
        }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Financial Input Details',
            Target : '@UI.FieldGroup#Group1'
        }
    ]
);
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
    ],
    UI.FieldGroup #ScreenGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
            {
            $Type : 'UI.DataField',
            Value : CRITER.SUBST,
            Label : 'Substance'
            },
        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Financial Input Details',
            Target : '@UI.FieldGroup#ScreenGroup'
        }
    ]
);

annotate service.EUT_SCREENING_INPUT with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_DESC,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'SCREEN_CRITER_TEMPLT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:CRITER_CRITER,
                    ValueListProperty: 'CRITER'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CRITER_DESC'}
                ]
            }
        }
    );
}