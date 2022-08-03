using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.PlantObject with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : WERKS,
        },
        {
            $Type : 'UI.DataField',
            Value : DESCR,
        },
    ]
);
annotate service.PlantObject with @(
    UI.HeaderInfo : {
        TypeName : 'Plant',
        TypeNamePlural : 'Plants',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Plant Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : DESCR,
        },
    },
    UI.FieldGroup #PlantForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : WERKS,
            },{
                $Type : 'UI.DataField',
                Value : DESCR,
            }],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'PlantForm',
            Target : '@UI.FieldGroup#PlantForm',
        },]
);

annotate service.PlantObject with {
    WERKS @Common.FieldControl : #Mandatory;
    DESCR @Common.FieldControl : #Optional;
};