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
            Value : EUT_ACTIVITIES.EA_Object.Description
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,            
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
    UI.PresentationVariant : {
        Text : 'EUT Screening Inputs - all records',
        GroupBy: [
             CRITER_CRIT_UNIT          
        ],
      //  Total : [
       //     KEY_FIGURE
      //  ],
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
              // @UI.Hidden : HELP_P,
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CALC_MEAS,
              //  @UI.Hidden : HELP_P,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.TYP_PLANT, 
              //  @UI.Hidden : HELP_P,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.COMBP_L, 
             //   @UI.Hidden : HELP_P,
            }, 
            {
               $Type : 'UI.DataField',
                Value : CRITER.COMBP_U, 
               // @UI.Hidden : HELP_P,
            }, 
            {
               $Type : 'UI.DataField',
                Value : CRITER.OPH_L, 
             //  @UI.Hidden : HELP_P,
            },  
            {
               $Type : 'UI.DataField',
                Value : CRITER.COND_GHGU, 
             //  @UI.Hidden : HELP_P,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.ENGN_CATG,
                Label : 'Engine Category' 
             //  @UI.Hidden : HELP_P,
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
    UI.DataPoint #Year :{
        Value : GJAHR,
        Title : 'Fiscal Year'
    },
        UI.DataPoint #Scenario :{
        Value : GSCEN,
        Title : 'Scenario'
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
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Scenario'
        },
    ],







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
           ![@UI.Hidden] : false
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



annotate service.SCREEN_CRITER_TEMPLT with {
    CRITER_DESC @Common.FieldControl : #ReadOnly
};
annotate service.EUT_SCREENING_INPUT with {
    GJAHR @Common.FieldControl : #ReadOnly
};
annotate service.SCREEN_CRITER_TEMPLT with {
    CRIT_UNIT @Common.FieldControl : #ReadOnly
};





annotate service.EUT_SCREENING_INPUT with @(
    Communication.Contact #contact : {
        $Type : 'Communication.ContactType',
        fn : CRITER_CRITER,
    }
);

annotate service.SCREEN_CRITER_TEMPLT with @(
 UI.QuickViewFacets : [
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#CriteriaQuickView',
        
    },
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#ExtraQuickView',
        ![@UI.Hidden] : false
    },
 ],
 UI.FieldGroup #CriteriaQuickView : {
    Data : [
        {
            $Type : 'UI.DataField',
            Value : CRITER_DESC,
            
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
      
    ]
 }
);

annotate service.EUT_SCREENING_INPUT with {
    @Common.SemanticObject:  'Screening Criterion'
    CRITER_CRITER
};






















