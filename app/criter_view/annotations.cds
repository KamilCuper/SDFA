using DataService as service from '../../srv/services';
using from '../../srv/services';



annotate service.CriterView with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Sector,
            Label : 'Sector'
        },
        {
            $Type : 'UI.DataField',
            Value : EcoActivity,
            Label : 'Economic Activity'
        },
        {
            $Type : 'UI.DataField',
            Value : EUT_Eligible
        },
        {
            $Type : 'UI.DataField',
            Value : Criterion
        },
        {
            $Type : 'UI.DataField',
            Value : Contribution_Type
        },
    ],
    UI.SelectionFields : [Sector,EcoActivity,EUT_Eligible,Criterion,Contribution_Type],
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Sector,
            },
            {
                $Type : 'UI.DataField',
                Value : EcoActivity,
            },
            {
                $Type : 'UI.DataField',
                Value : EUT_Eligible,
            },
            {
                $Type : 'UI.DataField',
                Value : Criterion,
            },
            {
                $Type : 'UI.DataField',
                Value : Contribution_Type,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_L,
            },
             {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_U,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Technical Screening Criterion Details',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
annotate service.CriterView with {
    Sector @(
        Common: {
            Text : Sector,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
            Label : 'Sector',
            ValueList: {
                Label: 'Sectors',
                CollectionPath: 'SECTOR_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:Sector,
                    ValueListProperty: 'Description'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Comment'}
                ]
            }
        },
    );
    EcoActivity @(
        Common: {
            Text    : EcoActivity,
            TextArrangement : #TextOnly,
            Label   : 'Economic Activity',
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Economic Activity',
                CollectionPath: 'ECO_ACT_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:  EcoActivity,
                    ValueListProperty: 'Description'}
                ]
            }
        }
    );
    Criterion @(
        Common: {
            Text : Criterion,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
            Label : 'Criterion',
            ValueList: {
                Label: 'Screening Criteria',
                CollectionPath: 'SCREEN_CRITER_TEMPLT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:Criterion,
                    ValueListProperty: 'CRITER_DESC'},
                    //{$Type: 'Common.ValueListParameterDisplayOnly',
                    //ValueListProperty: 'CONT_MEAS'}
                ]
            }
        }
    )
};
annotate SCREEN_CRITER_TEMPLT with @(UI:{
    ConnectedFields #CritU : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{CritU} / {Unit}',
        Data : {
            CritU : {
                $Type : 'UI.DataField',
                Value : CRIT_U
            },
            Unit : {
                $Type : 'UI.DataField',
                Value : CRIT_UNIT
            },
            $Type : 'Core.Dictionary'//, <-Required? it was added automatically by intellisense 
        },
    },
    ConnectedFields #CritL : {
        $Type : 'UI.ConnectedFieldsType',
        Template : 'CritL / Unit',
        Data : {
            CritL : {
                $Type : 'UI.DataField',
                Value : CRIT_L
            },
            Unit : {
                $Type : 'UI.DataField',
                Value : CRIT_UNIT
            },
            $Type : 'Core.Dictionary', //<-Required? it was added automatically by intellisense 
        },
    },    
    FieldGroup #BrowserHint : {
        $Type : 'UI.FieldGroupType',
        Data:[
            {
                $Type: 'UI.DataField',
                Label: 'Criterion',
                Value: CRITER_DESC
            },
            {
                $Type: 'UI.DataFieldForAnnotation',
                Label: 'Upper Limit',
                Target: '@UI.ConnectedFields#CritU'
            },
            {
                $Type: 'UI.DataFieldForAnnotation',
                Label: 'Lower Limit',
                Target: '@UI.ConnectedFields#CritL'
            }
        ]
        
    },

    FieldGroup #CriteriaQuickView : {
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
    FieldGroup #ExtraQuickView : {
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
    QuickViewFacets  : [
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

}
);
annotate service.CriterView with {
    @Common.SemanticObject:  'Criterion'
    Criterion
};