using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.ECON_CRITER_APPL with @(
    UI.LineItem : [
        /*{
            $Type : 'UI.DataField',
            Value : EcoActivity.SECTOR.Description,
            Label : 'Sector'
        },*/
        {
            $Type : 'UI.DataField',
            Value : EcoActivity_ECO_ACT,
            Label : 'Economic Activity'
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_CRITER,
        },
        {
            $Type : 'UI.DataField',
            Value : TYP_CONT,
        },
        {
            $Type : 'UI.DataField',
            Value : CCA,
        },
        {
            $Type : 'UI.DataField',
            Value : CCM,
        },
        {
            $Type : 'UI.DataField',
            Value : WAT,
        },
    ]
);
annotate service.ECON_CRITER_APPL with {
    EcoActivity @(
        Common: {
            Text: EcoActivity.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'EcoActivity',
                CollectionPath: 'ECO_ACT_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:EcoActivity_ECO_ACT,
                    ValueListProperty: 'Description'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'}
                ]
            }
        }
    );
    CRITER @(
        Common: {
            Text : CRITER.CRITER_DESC,
            TextArrangement : #TextOnly,
        }
    );
};

annotate service.SCREEN_CRITER_TEMPLT with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : CRITER
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER_DESC
        }
    ]
);
