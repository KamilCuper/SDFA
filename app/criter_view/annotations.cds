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
            Value : ContributionType
        },
    ],
    UI.SelectionFields : [Sector,EcoActivity,EUT_Eligible,Criterion,ContributionType],
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
                Value : ContributionType,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.COMB_UNIT,
            },
            {
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_L,
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
            ValueList: {
                Label: 'Sectors',
                CollectionPath: 'SECTOR_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:Sector,
                    ValueListProperty: 'SECTOR'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Comment'}
                ]
            }
        },
    );
    Criterion @(
        Common: {
            Text : Criterion,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Screening Criteria',
                CollectionPath: 'SCREEN_CRITER_TEMPLT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:Criterion,
                    ValueListProperty: 'CRITER_DESC'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'CONT_MEAS'}
                ]
            }
        }
    )
};