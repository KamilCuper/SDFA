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
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
