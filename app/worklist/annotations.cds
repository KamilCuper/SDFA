using DataService as service from '../../srv/services';
using from '../../srv/services';
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
        },
        {
            $Type : 'UI.DataField',
            Value : Activities.EA_Object.Description,
            Label : 'Assigned Economic Activities'
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
    UI.DataPoint #Company :{
        Value : RBUKRS_RBUKRS ,
        Title : 'Company'
    },
    UI.DataPoint #Year :{
        Value : GJAHR ,
        Title : 'Fiscal Year'
    },
    UI.DataPoint #ProfitCenter :{
        Value : PRCTR_PRCTR,
        Title : 'Profit Center'
    },
        UI.DataPoint #Plant :{
        Value : WERKS_WERKS ,
        Title : 'Plant'
    },
        UI.DataPoint #ID :{
        Value : ID ,
        Title : 'EUT Object ID'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#ID'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Company'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#ProfitCenter'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Plant'
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Economic Activities',
            ID    : 'Activities',
            Target: 'Activities/@UI.LineItem#Activities'
        }
        
    ]
);

annotate service.EUTObject with {
  ID @UI.Hidden;
};


annotate service.EUTObject with @(
    UI.SelectionFields : [
        RBUKRS_RBUKRS,
        GJAHR,
        PRCTR_PRCTR,
        WERKS_WERKS
    ]
);

annotate service.EUTObject with {
    RBUKRS @(
        Common: {
            Text: RBUKRS.Description,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
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
    GJAHR @(
        Common: {
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Years',
                CollectionPath: 'YearsListView',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:GJAHR,
                    ValueListProperty: 'FiscalYear'}
                ]
            }
        }
    );
    PRCTR @(
        Common: {
            Text: PRCTR.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
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
            ValueListWithFixedValues : true,
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
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Scenario'
        },
    ],
    UI.LineItem #Activities: [
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
            Value : Financial_InputT.KSL,
            @Aggregation.Default: #SUM 
        }
        
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
    },
    UI.FieldGroup #ActivityHeader : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : EUT_Object.RBUKRS_RBUKRS,
                Label : 'Company',
            },{
                $Type : 'UI.DataField',
                Value : EUT_Object_ID.GJAHR,
                Label : 'Fiscal Year',
            },{
                $Type : 'UI.DataField',
                Value : Scenario,
                Label : 'Scenario',
            }
        ]
    },
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
);
annotate service.EUT_Activities with @(
   UI.PresentationVariant #Activities: {
    Total : [
        {
            Property: Financial_Input.KSL
        }
    ],
}
);

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
    ],
    UI.HeaderInfo : {
        TypeName : 'Financial Statement',
        TypeNamePlural : 'Financial Statements',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'Financial Input',
        },
    },
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
            Label : 'Technical Screening Input Details',
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