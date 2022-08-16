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
            Criticality : CRITICALITY,
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
        },
        {
            $Type : 'UI.DataField',
            Value : KEY_FIGURE,
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
                Criticality : CRITICALITY,
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
            },
            {
                $Type : 'UI.DataField',
                Value : KEY_FIGURE,
                @UI.Hidden : HELP,
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
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CALC_MEAS,
            },
            {
               $Type : 'UI.DataField',
                Value : CRITER.TYP_PLANT, 
            }, 
            {
               $Type : 'UI.DataField',
                Value : HELP_P, 
            }, 
            {
               $Type : 'UI.DataField',
                Value : HELP_X, 
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
           Label : 'Additional Information',
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
