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
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Minimum Social Safeguard Inputs',
            ID    : 'MS_Inputs',
            Target: 'MSInput/@UI.LineItem#MSInput'
        },
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
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : ''
        },
        Description : {
            $Type : 'UI.DataField',
            Value : ''
        }
    },
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
            Label : 'Substantial Contribution Inputs',
            ID    : 'SC_Inputs',
            Target: 'SCInput/@UI.LineItem#SCInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Do No Significant Harm Inputs',
            ID    : 'DNSH_Inputs',
            Target: 'DNSHInput/@UI.PresentationVariant#DNSHPresentation'
        },
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
            Label: 'Account Type Page',
            SemanticObject: 'AccTypeMapping',
            Action: 'app'
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

/*************************************************************************************************/
//                    Annotations for EUT SCREENING CRITERIA OBJECT Page - Content
/*************************************************************************************************/



/*************************************************************************************************/
//                    Annotations for EUT SCREENING CRITERIA OBJECT Page - Annotation Views
/*************************************************************************************************/


annotate service.EnvObjectiveObject with {
    Env_Obj @Common.Text : {
        $value : Description,
        ![@UI.TextArrangement] : #TextFirst,
    }
};


annotate service.ContributionTypeObject with {
    Typ_Cont @Common.Text : {
        $value : Description,
        ![@UI.TextArrangement] : #TextFirst,
    }
};



//// ANNOTATION FOR SC/DNSH/MS INPUT PAGES ///////

annotate service.SCInput with @(
    UI.LineItem #SCInput : [
        {
            $Type : 'UI.DataField',
            Value : ENV_OB_ID,
           Label : 'Environmental Objective',
           ![@HTML5.CssDefaults] : {width : '15rem'},           
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            ![@HTML5.CssDefaults] : {width : '15rem'},
            },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_L,
            Label : 'Lower Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_U,
            Label : 'Upper Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },       
    ],

);


annotate service.SCInput with @(
        UI.HeaderInfo : {
            TypeName : 'Substantial Contribution Input',
            TypeNamePlural : 'Substantial Contribution Input',
            Description : {
                $Type : 'UI.DataField',
                Value : 'Substantial Contribution Input',
            },
            Title : {
                $Type : 'UI.DataField',
                Value : CRITER_CRITER,
            },
        },

        UI.FieldGroup #SCCriteriaForm : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : EUT_ACTIVITIES.EA_Object.Description,
                },                      
                {
                    $Type : 'UI.DataField',
                    Value : INDICATOR_IV,
                    @UI.Hidden : CRITER.HELP_I,
                    Criticality : CRITICALITY
                },
                {
                    $Type : 'UI.DataField',
                    Value : KEY_FIGURE,
                    @UI.Hidden : CRITER.HELP,
                    Criticality : CRITICALITY
                },
                {
                    $Type : 'UI.DataField',
                    Value : CRITER.CRIT_UNIT,
                }
            ]
        },

        UI.FieldGroup #SCCriteriaForm2 : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : CRITER.CRIT_L,
                },{
                    $Type : 'UI.DataField',
                    Value : CRITER.CRIT_U,
                },
                {
                $Type : 'UI.DataField',
                    Value : CRITER.SUBST, 
                },            
            ],
        },

        UI.FieldGroup #SCExtraForm : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : CRITER.COMB_UNIT,
                    @UI.Hidden : CRITER.HELP_P,
                },{
                    $Type : 'UI.DataField',
                    Value : CRITER.CALC_MEAS,
                    @UI.Hidden : CRITER.HELP_P,
                },{
                $Type : 'UI.DataField',
                    Value : CRITER.TYP_PLANT, 
                    @UI.Hidden : CRITER.HELP_P,
                },{
                $Type : 'UI.DataField',
                    Value : CRITER.COMBP_L, 
                    @UI.Hidden : CRITER.HELP_P,
                },{
                $Type : 'UI.DataField',
                    Value : CRITER.COMBP_U, 
                    @UI.Hidden : CRITER.HELP_P,
                },{
                $Type : 'UI.DataField',
                    Value : CRITER.OPH_L, 
                    @UI.Hidden : CRITER.HELP_P,
                }          
            ]
        },

        UI.DataPoint #Criteria :{
            Value : CRITER_CRITER ,
            Title : 'Screening Criteria'
        },
        UI.DataPoint #EcoActivity :{
            Value : EUT_ACTIVITIES.EA_Object.Description,
            Title : 'Economic Activity'
        },
   
        UI.HeaderFacets : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.DataPoint#Criteria'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.DataPoint#EcoActivity'
            }
        ],

        UI.Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Substantial Contribution Parameters',
                ID : 'SCEUTIputForm',
                Target : '@UI.FieldGroup#SCCriteriaForm',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Details',
                ID : 'SCDetailsForm',
                Target : '@UI.FieldGroup#SCCriteriaForm2',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : '',
                ID : 'SCExtraForm',
                Target : '@UI.FieldGroup#SCExtraForm',
                
            },
        ] 
    );

annotate service.DNSHInput with @(
    UI.LineItem #DNSHScreenInputs : [
        {
            $Type : 'UI.DataField',
            Value : ENV_OB_ID,
           Label : 'Environmental Objective',
           ![@HTML5.CssDefaults] : {width : '15rem'},            
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            ![@HTML5.CssDefaults] : {width : '15rem'},
            },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_L,
            Label : 'Lower Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_U,
            Label : 'Upper Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },       
    ],
    
);
annotate service.DNSHInput with @(
    UI.HeaderInfo : {
        TypeName : 'Do No Significant Harm Input',
        TypeNamePlural : 'Do No Significant Harm Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Do No Significant Harm Input',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
        },
    },
    UI.FieldGroup #DNSHInputsForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
             {
                $Type : 'UI.DataField',
                Value : EUT_ACTIVITIES.EA_Object.Description,
            },          
                       
            {
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
                @UI.Hidden : CRITER.HELP_I,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : KEY_FIGURE,
                @UI.Hidden : CRITER.HELP,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            },
            ],
    },
    UI.FieldGroup #DNSHInputsForm2 : {
        $Type : 'UI.FieldGroupType',
        Data : [          
            {
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
              //  @UI.Hidden : CRITER.HELP_I,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : KEY_FIGURE,
             //   @UI.Hidden : CRITER.HELP,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            },
            ],
    },
    UI.DataPoint #Criteria :{
        Value : CRITER_CRITER ,
        Title : 'Screening Criteria'
    },
    UI.DataPoint #EcoActivity :{
        Value : EUT_ACTIVITIES.EA_Object.Description,
        Title : 'Economic Activity'
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Do No Significant Harm Inputs',
            ID : 'DNSHInputs',
            Target : '@UI.FieldGroup#DNSHInputsForm',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            ID : 'DNSHInputs2',
            Target : '@UI.FieldGroup#DNSHInputsForm2',
        },
        
    ]
);

annotate service.SCInput with {
    ENV_OB @(
        Common: {
            Text: ENV_OB.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Env Objective',
                CollectionPath: 'EnvObjectiveObject',
                
            }
        }
    );
}

annotate service.DNSHInput with {
    ENV_OB @(
        Common: {
            Text: ENV_OB.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Env Objective',
                CollectionPath: 'EnvObjectiveObject',
                
            }
        }
    );
}

annotate service.SCInput with @(
    UI.PresentationVariant #SCPresentation: {
        Text : 'All records',
        GroupBy: [
            ENV_OB_ID          
        ],
        Visualizations : [
            '@UI.LineItem#SCInput',
        ],        
    }
);

annotate service.SCInput with @(
    UI.SelectionVariant #SCWith : {
        Text : 'Available Input Values',
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #NE,
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.SCInput with @(
    UI.SelectionVariant #SCWithout : {
        Text : 'Missing Input Values',
        $Type : 'UI.SelectionVariantType',       
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #EQ,
                        Low : '',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);


annotate service.MSInput with @(
    UI.HeaderInfo : {
        TypeName : 'Miniumum Social Input',
        TypeNamePlural : 'Miniumum Social Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Miniumum Social Input',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
        },
    },
);


annotate service.MSInput with @(
    UI.FieldGroup #MSForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
           {
                $Type : 'UI.DataField',
                Value : EUT_ACTIVITIES.EA_Object.Description,
            },
           {
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
                @UI.Hidden : CRITER.HELP_I,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : KEY_FIGURE,
                @UI.Hidden : CRITER.HELP,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            },
        ],
    },
    UI.DataPoint #Criteria :{
        Value : CRITER_CRITER ,
        Title : 'Screening Criteria'
    },
    UI.DataPoint #EcoActivity :{
        Value : EUT_ACTIVITIES.EA_Object.Description,
        Title : 'Economic Activity'
    },
   UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'MSForm',
            Label : 'Minimum Social Safeguard Inputs',
            Target : '@UI.FieldGroup#MSForm',
        },
    ] 
);

annotate service.MSInput with {
      ENV_OB @(
        Common: {
            Text: ENV_OB.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Env Objective',
                CollectionPath: 'EnvObjectiveObject',
                
            }
        }
    );
}

annotate service.MSInput with @(
    UI.LineItem #MSInput : [
        {
            $Type : 'UI.DataField',
            Value : ENV_OB_ID,
           Label : 'Environmental Objective',
           ![@HTML5.CssDefaults] : {width : '15rem'},           
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            ![@HTML5.CssDefaults] : {width : '15rem'},
            },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_L,
            Label : 'Lower Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_U,
            Label : 'Upper Limit',
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
         {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
     /*   {
          $Type : 'UI.DataFieldWithUrl',
          Url : EUT_COMPASS,
          Value : EUT_COMPASS,
          Label : 'Link to EUT Compass',
          ![@HTML5.CssDefaults] : {width : '12rem'},
} , */
               
    ]);


    annotate service.SCInput with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'ScreeningCriteriaTemplate',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:CRITER_CRITER,
                    ValueListProperty: 'CRITER'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CRITER_DESCR'}
                ]
            }
        }
    );
}

annotate service.DNSHInput with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'ScreeningCriteriaTemplate',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:CRITER_CRITER,
                    ValueListProperty: 'CRITER'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CRITER_DESCR'}
                ]
            }
        }
    );
}

annotate service.MSInput with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'ScreeningCriteriaTemplate',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:CRITER_CRITER,
                    ValueListProperty: 'CRITER'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CRITER_DESCR'}
                ]
            }
        }
    );
}




annotate service.MSInput with @(
    UI.PresentationVariant #MSPresentation: {
        Text : 'All records',
        GroupBy: [
            ENV_OB_ID          
        ],
        Visualizations : [
            '@UI.LineItem#MSInput',
        ],        
    }
);


annotate service.MSInput with @(
    UI.SelectionVariant #MSWith : {
        Text : 'Available Input Values',
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #NE,
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.MSInput with @(
    UI.SelectionVariant #MSWithout : {
        Text : 'Missing Input Values',
        $Type : 'UI.SelectionVariantType',       
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #EQ,
                        Low : '',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);



annotate service.DNSHInput with @(
    UI.PresentationVariant #DNSHPresentation: {
        Text : 'All records',
        GroupBy: [
            ENV_OB_ID,          
        ],
        Label : '',
        Visualizations : [
            '@UI.LineItem#DNSHScreenInputs',
        ],        
    }
);


annotate service.DNSHInput with @(
    UI.SelectionVariant #DNSHWith : {
        Text : 'Available Input Values',
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #NE,
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.DNSHInput with @(
    UI.SelectionVariant #DNSHWithout : {
        Text : 'Missing Input Values',
        $Type : 'UI.SelectionVariantType',       
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #EQ,
                        Low : '',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);


annotate service.ScreeningCriteriaTemplate with @(
 UI.FieldGroup #CriteriaQuickView : {
        Data : [
            
            {
                $Type : 'UI.DataField',
                Value : CRIT_UNIT
            },
            {
                $Type : 'UI.DataField',
                Value : CONT_MEAS
            },
            {
                    $Type : 'UI.DataField',
                    Value : CALC_MEAS,              
                },
                
        ]
    },                 
    UI.FieldGroup #ExtraQuickView : {
        Data : [
        {
                $Type : 'UI.DataField',
                Value : CRIT_L,
                
            },
            {
                $Type : 'UI.DataField',
                Value : CRIT_U
            },
        ]
    },
    UI.QuickViewFacets  : [
        {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#CriteriaQuickView',
        Label : 'Description'
        
    },
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#ExtraQuickView',
        Label : 'Limits'
    },        
    ],
);

annotate service.SCInput with {
    @Common.SemanticObject:  'Criterion'
    CRITER_CRITER
}

annotate service.DNSHInput with {
    @Common.SemanticObject:  'Criterion'
    CRITER_CRITER
}

annotate service.MSInput with {
    @Common.SemanticObject:  'Criterion'
    CRITER_CRITER
}

annotate service.SCInput with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : CRITER,
    }

);

annotate service.SCInput with @(
    Capabilities.Updatable : true
);