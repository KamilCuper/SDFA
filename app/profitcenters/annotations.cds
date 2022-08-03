using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.ProfitCenterObject with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PRCTR,
        },
        {
            $Type : 'UI.DataField',
            Value : DESCR,
        },
    ]
);
annotate service.ProfitCenterObject with @(
    UI.HeaderInfo : {
        TypeName : 'Profit Center',
        TypeNamePlural : 'Profit Centers',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Profit Centers Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : DESCR,
        },
    },
    UI.FieldGroup #PRCTRForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PRCTR,
            },{
                $Type : 'UI.DataField',
                Value : DESCR,
            }],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'PRCTRForm',
            Target : '@UI.FieldGroup#PRCTRForm',
        },]
);

annotate service.ProfitCenterObject with {
    PRCTR @Common.FieldControl : #Mandatory;
    DESCR @Common.FieldControl : #Optional;
};