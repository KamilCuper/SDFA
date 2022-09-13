using EUTObjectService as service from '../../srv/services';


/*************************************************************************************************/
//               Annotations for External Entities fields display
/*************************************************************************************************/
annotate service.EUTObject with {
  ID @UI.Hidden;
};

annotate service.EUT_Activities with {
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
    /*GJAHR @(
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
    );*/
};


/*************************************************************************************************/
//               Selection Fields, Selection Variant and Presentation Variant
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.SelectionFields : [
        Description,
        RBUKRS_RBUKRS,
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
    Description @(
        Common: {
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
                Value : Description,
                Label : 'Description',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Label : 'Company Code',
                Value : RBUKRS_RBUKRS,
                ![@UI.Importance] : #High,
                ![@HTML5.CssDefaults] : {width : '20rem'}
            },
            {
                $Type : 'UI.DataField',
                Label: 'Profit Center',
                Value : PRCTR_PRCTR,
                ![@HTML5.CssDefaults] : {width : '15rem'}
            },
            {
                $Type : 'UI.DataField',
                Label: 'Plant',
                Value : WERKS_WERKS,
                ![@UI.Importance] : #High,
                ![@HTML5.CssDefaults] : {width : '15rem'}
            },
            {
                $Type: 'UI.DataFieldForIntentBasedNavigation',
                Label: 'Company Data Details',
                SemanticObject: 'CorporateMD',
                Action: 'app'
            },
            {
                $Type: 'UI.DataFieldForIntentBasedNavigation',
                Label: 'Plants Details',
                SemanticObject: 'Plants',
                Action: 'app'
            },
            {
                $Type: 'UI.DataFieldForIntentBasedNavigation',
                Label: 'Profit Centers Details',
                SemanticObject: 'ProfitCenters',
                Action: 'app'
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
            Value : ''
        }
    },
    UI.DataPoint #ProfitCenter :{
        Value : PRCTR_PRCTR,
        Title : 'Profit Center'
    },
    UI.DataPoint #Plants :{
        Value : WERKS_WERKS,
        Title : 'Plant'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#ProfitCenter'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Plants'
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
        Value : GJAHR ,
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
        Value : EUT_Object.WERKS.DESCR,
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
annotate service.ECO_ACT_OBJECT with{
EUT_Eligible    @readonly;
ENB_ACT         @readonly;
Comment         @readonly
};


annotate service.EUT_Activities with @(
    UI.LineItem #Activities: [
        {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT,
            ![@HTML5.CssDefaults] : {width : '20rem'}
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : Scenario,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.EUT_Eligible,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.ENB_ACT,
            ![@HTML5.CssDefaults] : {width : '10rem'}
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.Comment,
            ![@HTML5.CssDefaults] : {width : '15rem'}
        },
        {
            $Type: 'UI.DataFieldForIntentBasedNavigation',
            Label: 'Details',
            SemanticObject: 'EcoActivities',
            Action: 'app',
            IconUrl: 'sap-icon://detail-view',
            Inline : true,
            ![@UI.Importance]   : #High,
        },
        {
            $Type: 'UI.DataFieldForIntentBasedNavigation',
            Label: 'Economic Activities Page',
            SemanticObject: 'EcoActivities',
            Action: 'app',
            //RequiresContext : true,
            /*Mapping : [
                {
                    $Type : 'Common.SemanticObjectMappingType',
                    LocalProperty : EA_Object.Description,
                    SemanticObjectProperty : 'Description',
                },
           ],*/
        }
    ],
    
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Financial Inputs',
            ID    : 'FinInputs',
            Target: 'Financial_Input/@UI.LineItem#FinInputs'
            //Target: 'Financial_Input/@UI.SelectionPresentationVariant#OpenSPVWithPVPath'
        }
    ]
);

annotate service.FINANCIAL_INPUT with @(
    UI.SelectionPresentationVariant #OpenSPVWithPVPath : {
        $Type : 'UI.SelectionPresentationVariantType',
        Text                : 'Open',
        SelectionVariant    : {
                Text          : 'Open',
                SelectOptions : []
            },
            PresentationVariant : ![@UI.PresentationVariant#PVPath]
        },

    UI.PresentationVariant #PVPath : {
        MaxItems       : 10,
        SortOrder      : [{Property : RACCT}],
        //GroupBy : [RACCT_TYPE_code],
        Visualizations : ['@UI.LineItem#FinInputs']
    }
);


/*************************************************************************************************/
//                    Annotations for Financial Input OBJECT Page - Content
/*************************************************************************************************/
annotate service.FINANCIAL_INPUT with @(
    UI.LineItem #FinInputs: [
        {
            $Type : 'UI.DataField',
            Value : RACCT,
            Label : 'Account Number',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code,
            Label : 'Account Type',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR,
            Label : 'Cost Center',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : BUDAT,
            Label : 'Posting Date',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},        
        },
                {
            $Type : 'UI.DataField',
            Value : RLDNR,
            Label : 'Ledger',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : MATNR,
            Label : 'Material Number',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
                {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR,
            Label: 'Green Finance Indicator',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : KSL,
            Label : 'Amount GC',
            Criticality: criticality,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type: 'UI.DataFieldForIntentBasedNavigation',
            Label: 'Manage Account Types',
            SemanticObject: 'AccTypeMapping',
            Action: 'app',
            //RequiresContext : true,
            /*Mapping : [
                {
                    $Type : 'Common.SemanticObjectMappingType',
                    LocalProperty : RACCT_TYPE_code,
                    SemanticObjectProperty : 'RACCT_TYPE',
                },
           ]*/
        }
    ]
);

annotate service.FINANCIAL_INPUT with @(
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

/*************************************************************************************************/
//               Annotations for Financial Inputs fields display and Value Help lists
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
                CollectionPath: 'EUT_Activities',
                Parameters: [
                    { 
                        $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty: GJAHR,
                        ValueListProperty: 'GJAHR'
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

    KSL @Measures.ISOCurrency : RKCUR_code;

    /*RACCT_TYPE @Common.Text : {
            $value : RACCT_TYPE.descr,
            ![@UI.TextArrangement] : #TextFirst,
    }*/
};