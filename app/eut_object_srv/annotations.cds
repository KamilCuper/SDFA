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
                ![@HTML5.CssDefaults] : {width : '16rem'}
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
            Label : 'Economic Activities',
            ID    : 'Activities',
            Target: 'Activities/@UI.LineItem#Activities'
        },
                {
            $Type : 'UI.ReferenceFacet',
            Label : 'Minimum Social Safeguard',
            ID    : 'MS_Inputs',
            Target: 'MSInput/@UI.LineItem#MSInput'
        },
    ]
);

/*************************************************************************************************/
//                    Annotations for EUT Activity OBJECT Page - Header
/*************************************************************************************************/
annotate service.EUT_Activities with @(
    UI.DataPoint #Data :{
    Value : 'Env Obj Input Values',
    },
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

     /*   {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Data'
        },  */
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
            ![@HTML5.CssDefaults] : {width : '16rem'}
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
            Label : 'Climate Mitigation',
            ID    : 'CCM_Inputs',
            Target: 'CCM_Input/@UI.LineItem#CCMInputs'
        },
         {
            $Type : 'UI.ReferenceFacet',
            Label : 'Climate Adaptation',
            ID    : 'CCA_Inputs',
            Target: 'CCA_Input/@UI.LineItem#CCAInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Pollution',
            ID    : 'POL_Inputs',
            Target: 'POL_Input/@UI.LineItem#POLInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Biodiversity',
            ID    : 'BIO_Inputs',
            Target: 'BIO_Input/@UI.LineItem#BIOInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Water',
            ID    : 'WAT_Inputs',
            Target: 'WAT_Input/@UI.LineItem#WATInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Circular Economy',
            ID    : 'CEC_Inputs',
            Target: 'CEC_Input/@UI.LineItem#CECInput'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Financial Inputs',
            ID    : 'FinInputs',
            Target: 'Financial_Input/@UI.LineItem#FinInputs'
            //Target: 'Financial_Input/@UI.SelectionPresentationVariant#OpenSPVWithPVPath'
        },
        
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
  /*  UI.HeaderInfo : {
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
    }, */
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


annotate service.MSInput with @(
    UI.HeaderInfo : {
        TypeName : 'Miniumum Social Safeguard Input',
        TypeNamePlural : 'Miniumum Social Safeguard Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Miniumum Social Safeguard Input',
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
                Value : TYP_CONT.Description,
                Label : 'Criteria Type',
            },
            {
                $Type : 'UI.DataField',
                Value : RBUKRS.Description,
                Label : 'Company'
            },
            {
                $Type : 'UI.DataField',
                Value : GJAHR,
                Label : 'Year'
            },
           {
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
                @UI.Hidden : CRITER.HELP_I,
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
        Value : RBUKRS.Description,
        Title : 'Company'
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

/*annotate service.MSInput with {
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
}*/

annotate service.MSInput with @(
    UI.LineItem #MSInput : [
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : RBUKRS.Description,
            Label : 'Company',
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
            Label : 'Year',
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            ![@HTML5.CssDefaults] : {width : '15rem'},
        },
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '10rem'},
        },
        {
            $Type: 'UI.DataFieldForIntentBasedNavigation',
            Label: 'Minimum Safeguard Inputs Details',
            SemanticObject: 'MSInputs',
            Action: 'manage'
        },
    ]);
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





annotate service.ScreeningCriteriaTemplate with @(
 UI.FieldGroup #CriteriaQuickView : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER_DESCR
            },
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
                Value : CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRIT_DNSH_L,
            },{
                $Type : 'UI.DataField',
                Value : CRIT_DNSH_U,
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


annotate service.MSInput with {
    @Common.SemanticObject:  'Criterion'
    CRITER_CRITER
}

annotate service.CCM_Input with @(
    UI.LineItem #CCMInputs: [     
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ],
);

annotate service.CCM_Input with @(
    UI.FieldGroup #CCMGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [    
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
        {
                $Type : 'UI.DataField',
                Value : CRITER.SC_FLAG,
                Label : 'Substantial Contribution Flag'
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.DNSH_FLAG,
                Label : 'Do No Significant Harm Flag'
            },
        ],
    },
     UI.FieldGroup #CCMGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
            },   
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
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
   

    UI.HeaderFacets : [     
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Parameters',
            Target : '@UI.FieldGroup#CCMGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#CCMGroup2'
        },

    ],
 /*   UI.HeaderInfo : {
        TypeName : 'CCM Input',
        TypeNamePlural : 'Climate Mitigation Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'CRITER_CRITER',
        },
    }, */
);






annotate service.CCA_Input with @(
    UI.LineItem #CCAInput: [    
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ]
);

annotate service.CCA_Input with @(
    UI.FieldGroup #CCAGroup : {
        $Type : 'UI.FieldGroupType',
         Data : [     
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
         {
                $Type : 'UI.DataField',
                Value : CRITER.SC_FLAG,
                Label : 'Substantial Contribution Flag'
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.DNSH_FLAG,
                Label : 'Do No Significant Harm Flag'
            },
        ],
    },
    UI.FieldGroup #CCAGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
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

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Parameters',
            Target : '@UI.FieldGroup#CCAGroup'
        },
         {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#CCAGroup2'
        },
    ],
 /*   UI.HeaderInfo : {
        TypeName : 'CCA Input',
        TypeNamePlural : 'Climate Adaptation Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'CRITER_CRITER',
        },
    }, */
);


annotate service.POL_Input with @(
    UI.LineItem #POLInput: [     
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ]
);

annotate service.POL_Input with @(
    UI.FieldGroup #POLGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [     
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
        {
                $Type : 'UI.DataField',
                Value : CRITER.SC_FLAG,
                Label : 'Substantial Contribution Flag'
        },
        {
                $Type : 'UI.DataField',
                Value : CRITER.DNSH_FLAG,
                Label : 'Do No Significant Harm Flag'
        },
        ],
    },

    UI.FieldGroup #POLGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
            },            
            ],

    },
     UI.FieldGroup #POLGroup3 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value :  APPL.LVL1_VAL.VAL_DESCR,
                Label : 'Combustion type'
            },
            {
                $Type : 'UI.DataField',
                Value :  APPL.LVL2_VAL.VAL_DESCR,
                Label : 'Combustion unit'
            },
            {
                $Type : 'UI.DataField',
                Value :  APPL.LVL3_VAL.VAL_DESCR,
                Label : 'Type of plant'
            },
            {
                $Type : 'UI.DataField',
                Value :  APPL.LVL4_VAL.VAL_DESCR,
                Label : 'Combustion range'
            },
            {
                $Type : 'UI.DataField',
                Value :  APPL.SUBST.VAL_DESCR,
                Label : 'Substance'
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

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacetPol',
            Label : 'Pollution Details',
            Target : '@UI.FieldGroup#POLGroup'
        },
         {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#POLGroup2'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet3',
            Label : 'Additional parameters',
            Target : '@UI.FieldGroup#POLGroup3'
        },
    ],
 /*   UI.HeaderInfo : {
        TypeName : 'POL Input',
        TypeNamePlural : 'Pollution Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
        },
    }, */
);


annotate service.BIO_Input with @(
    UI.LineItem #BIOInput: [    
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ]
);

annotate service.BIO_Input with @(
    UI.FieldGroup #BIOGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [     
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
         {
                $Type : 'UI.DataField',
                Value : CRITER.SC_FLAG,
                Label : 'Substantial Contribution Flag'
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.DNSH_FLAG,
                Label : 'Do No Significant Harm Flag'
            },
        ],
    },

    UI.FieldGroup #BIOGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
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

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacetBio',
            Label : 'Biodiversity Details',
            Target : '@UI.FieldGroup#BIOGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#BIOGroup2'
        },
    ],
 /*   UI.HeaderInfo : {
        TypeName : 'BIO Input',
        TypeNamePlural : 'Biodiversity Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'CRITER_CRITER',
        },
    }, */
);


annotate service.WAT_Input with @(
    UI.LineItem #WATInput: [     
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ]
);

annotate service.WAT_Input with @(
    UI.FieldGroup #WATGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [     
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag'
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag'
        },
        ],
    },
     UI.FieldGroup #WATGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
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

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacetWat',
            Label : 'Water Details',
            Target : '@UI.FieldGroup#WATGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#WATGroup2'
        },
    ],
  /*  UI.HeaderInfo : {
        TypeName : 'WAT Input',
        TypeNamePlural : 'Water Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'CRITER_CRITER',
        },
    }, */
);


annotate service.CEC_Input with @(
    UI.LineItem #CECInput: [    
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
            ![@HTML5.CssDefaults] : {width : '16%'},
        },
        {          
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITER.CRITICALITY,
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
            Label : 'Screening Criteria Unit',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.SC_FLAG,
            Label : 'Substantial Contribution Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.DNSH_FLAG,
            Label : 'Do No Significant Harm Flag',
            ![@HTML5.CssDefaults] : {width : '15%'},
        },

    ]
);

annotate service.CEC_Input with @(
    UI.FieldGroup #CECGroup : {
       $Type : 'UI.FieldGroupType',
        Data : [     
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
        },
        {          
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
         {
                $Type : 'UI.DataField',
                Value : CRITER.SC_FLAG,
                Label : 'Substantial Contribution Flag'
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.DNSH_FLAG,
                Label : 'Do No Significant Harm Flag'
            },
        ],
    },
    UI.FieldGroup #CECGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_SC_U,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_L,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_DNSH_U,
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

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Criteria'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#EcoActivity'
        },
      
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacetCet',
            Label : 'Circular Economy Details',
            Target : '@UI.FieldGroup#CECGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'Limits',
            Target : '@UI.FieldGroup#CECGroup2'
        },
    ],
  /*  UI.HeaderInfo : {
        TypeName : 'CEC Input',
        TypeNamePlural : 'Circular economy Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'CRITER_CRITER',
        },
    }, */
);

 annotate service.CCM_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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

 annotate service.CCA_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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

annotate service.POL_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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

annotate service.BIO_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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

annotate service.WAT_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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

annotate service.CEC_Input with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_SHORT_DESCR,
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


annotate service.CCM_Input with {
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

annotate service.CCA_Input with {
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

annotate service.POL_Input with {
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

annotate service.BIO_Input with {
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

annotate service.WAT_Input with {
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

annotate service.CEC_Input with {
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

annotate service.CCM_Input with @(
    UI.SelectionVariant #CCMWith : {
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

annotate service.CCM_Input with @(
    UI.SelectionVariant #CCMWithout : {
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
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.CCA_Input with @(
    UI.SelectionVariant #CCAWith : {
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

annotate service.CCA_Input with @(
    UI.SelectionVariant #CCAWithout : {
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
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.POL_Input with @(
    UI.SelectionVariant #POLWith : {
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

annotate service.POL_Input with @(
    UI.SelectionVariant #POLWithout : {
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
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.WAT_Input with @(
    UI.SelectionVariant #WATWith : {
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

annotate service.WAT_Input with @(
    UI.SelectionVariant #WATWithout : {
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
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);

annotate service.BIO_Input with @(
    UI.SelectionVariant #BIOWith : {
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

annotate service.BIO_Input with @(
    UI.SelectionVariant #BIOWithout : {
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
                        Low : 'NA',
                        Sign : #I
                    }
                ]
            }
        ],
        
    }
);