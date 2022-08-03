using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.SECTOR_OBJECT with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : SECTOR,
            Label : 'Sector ID'
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : Comment,
        },
    ]
);
annotate service.SECTOR_OBJECT with @(
    UI.HeaderInfo : {
        TypeName : 'Sector',
        TypeNamePlural : 'Sectors',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Sector Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
    UI.FieldGroup #SectorForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : SECTOR,
            },{
                $Type : 'UI.DataField',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Value : Comment,
            }],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'SectorForm',
            Target : '@UI.FieldGroup#SectorForm',
        },]
);

annotate service.SECTOR_OBJECT with {
    SECTOR      @Common.FieldControl : #Mandatory;
    Description @Common.FieldControl : #Mandatory;
    Comment     @Common.FieldControl : #Optional;
};