using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/EUTObject';
using from '../../db/ReferenceData';
using from '../worklist/annotations';
//using from '../../srv/services.js';


   
annotate service.EUT_SCREENING_INPUT with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : EUT_ACTIVITIES.EA_Object.Description,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,            
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
        },
        
        {
            $Type : 'UI.DataField',
            Value : GSCEN,
        },
        {
            $Type : 'UI.DataField',
            Value : INDICATOR_IV,
            Criticality : CRITICALITY
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
            Criticality : CRITICALITY
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_L,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_U,
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRIT_UNIT,
        },
        
    ]
  
);


annotate service.EUT_SCREENING_INPUT with @(
    UI.SelectionVariant #All : {
        Text : 'EUT Screening Inputs - all records',
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : INDICATOR_IV,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #NE,
                        Low : 'N',
                    }
                ]
            }
        ],
        
    }
);


annotate service.EUT_SCREENING_INPUT with @(
    UI.SelectionVariant #With : {
        Text : 'Records with EUT Input Values',
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
                    }
                ]
            }
        ],
        
    }
);

annotate service.EUT_SCREENING_INPUT with @(
    UI.SelectionVariant #Without : {
        Text : 'Records without EUT Input Values',
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
                    }
                ]
            }
        ],
        
    }
);


annotate service.EUT_SCREENING_INPUT with @(
    UI.PresentationVariant #Pre : {
        $Type : 'UI.PresentationVariant',
        GroupBy: [
            CRITER_CRITER
        ],
        Total : [
            KEY_FIGURE
        ],
        Visualizations : [
            '@UI.LineItem',
        ]
        
    }
);



annotate service.EUT_SCREENING_INPUT with @(
        UI.HeaderInfo : {
        TypeName : 'EUT Screening Input',
        TypeNamePlural : 'EUT Screening Inputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'EUT Screening Input Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
        },
    },

     UI.FieldGroup #CriteriaForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : EUT_ACTIVITIES.EA_Object.Description,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRITER_DESC,
            },          
            {
                $Type : 'UI.DataField',
                Value : GJAHR,
            },           
            {
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
                @UI.Hidden : HELP_I,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : KEY_FIGURE,
                @UI.Hidden : HELP,
                Criticality : CRITICALITY
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            },
            ],
    },

 UI.FieldGroup #CriteriaForm2 : {
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

    UI.FieldGroup #ExtraForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CRITER.COMB_UNIT,
                @UI.Hidden : HELP_P,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CALC_MEAS,
                @UI.Hidden : HELP_P,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.TYP_PLANT, 
                @UI.Hidden : HELP_P,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.COMBP_L, 
                @UI.Hidden : HELP_P,
            }, 
            {
               $Type : 'UI.DataField',
                Value : CRITER.COMBP_U, 
                @UI.Hidden : HELP_P,
            }, 
            {
               $Type : 'UI.DataField',
                Value : CRITER.OPH_L, 
                @UI.Hidden : HELP_P,
            },              
            ],

    },

   UI.Facets : [
       {
           $Type : 'UI.ReferenceFacet',
           Label : 'EUT Input Form',
           ID : 'EUTIputForm',
           Target : '@UI.FieldGroup#CriteriaForm',
       },
       {
           $Type : 'UI.ReferenceFacet',
           Label : 'Details',
           ID : 'DetailsForm',
           Target : '@UI.FieldGroup#CriteriaForm2',
       },
       {
           $Type : 'UI.ReferenceFacet',
           Label : '',
           ID : 'ExtraForm',
           Target : '@UI.FieldGroup#ExtraForm',    
       },
       
  ] 
);

annotate service.SCREEN_CRITER_TEMPLT with {
    CRIT_U @Common.FieldControl : #ReadOnly
    
};
annotate service.SCREEN_CRITER_TEMPLT with {
    CRIT_L @Common.FieldControl : #ReadOnly
};
annotate service.SCREEN_CRITER_TEMPLT with {
    SUBST @Common.FieldControl : #ReadOnly
};
annotate service.EUT_SCREENING_INPUT with @(
    UI.SelectionFields : [
        GJAHR,
        CRITER_CRITER,
    ]
);
annotate service.EUT_SCREENING_INPUT with @(
    UI.FieldGroup #EUTSCForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.EUT_SCREENING_INPUT with @(
    UI.FieldGroup #EUTForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : EUT_ACTIVITIES_ID,
                Label : 'EUT_ACTIVITIES_ID',
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRITER_DESC,
            },],
    }
);
annotate service.EUT_SCREENING_INPUT with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : CRITER_CRITER,
    }
);

annotate service.EUT_SCREENING_INPUT with @(
    UI.FieldGroup #AAA : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.SCREEN_CRITER_TEMPLT with {
    CRITER_DESC @Common.FieldControl : #ReadOnly
};
annotate service.EUT_SCREENING_INPUT with {
    GJAHR @Common.FieldControl : #ReadOnly
};
annotate service.SCREEN_CRITER_TEMPLT with {
    CRIT_UNIT @Common.FieldControl : #ReadOnly
};

annotate service.EUT_SCREENING_INPUT.GJAHR with {
    @Common.SemanticObject : 'GJAHR'
    YY
};

annotate service.SCREEN_CRITER_TEMPLT with @(
 UI.QuickViewFacets : [
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#YearQuickView'
    }
 ],
 UI.FieldGroup #YearQuickView : {
    Data : [
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : CRITER
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : CRITER_DESC
        },
    ]
 }
);

annotate service.EUT_SCREENING_INPUT with {
    @Common.SemanticObject:  'Semantic Year'
    GJAHR
}