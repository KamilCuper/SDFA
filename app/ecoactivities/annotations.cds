using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.ECO_ACT_OBJECT with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : EUT_Eligible,
        },
        {
            $Type : 'UI.DataField',
            Value : SECTOR_SECTOR
        },
        {
            $Type : 'UI.DataField',
            Value : ENB_ACT,
        },
        {
            $Type : 'UI.DataField',
            Value : Comment,
        },
    ]
);
annotate service.ECO_ACT_OBJECT with @(
    UI.HeaderInfo : {
        TypeName : 'Economic Activity',
        TypeNamePlural : 'Economic Activities',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Economic Activity Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
    UI.FieldGroup #EcoActForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value : ECO_ACT,
        },
            {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : EUT_Eligible,
        },
        {
            $Type : 'UI.DataField',
            Value : SECTOR_SECTOR
        },
        {
            $Type : 'UI.DataField',
            Value : ENB_ACT,
        },
        {
            $Type : 'UI.DataField',
            Value : Comment,
        },],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'EcoActForm',
            Target : '@UI.FieldGroup#EcoActForm',
        },]
);

annotate service.ECO_ACT_OBJECT with {
    ECO_ACT         @Common.FieldControl : #Mandatory;
    Description     @Common.FieldControl : #Mandatory;
    Comment         @Common.FieldControl : #Optional;
    EUT_Eligible    @Common.FieldControl : #Optional;
    ENB_ACT         @Common.FieldControl : #Optional;
    SECTOR @(
            Common: {
                Text: SECTOR.Description,
                TextArrangement : #TextOnly,
                FieldControl : #Optional,
                ValueList: {
                    Label: 'Sectors',
                    CollectionPath: 'SECTOR_OBJECT',
                    Parameters: [
                        { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty:  SECTOR_SECTOR,
                        ValueListProperty: 'SECTOR'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'Description'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'Comment'}
                    ]
                }
            }
        );
};