using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/ReferenceData';



annotate service.CorporateMD with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS,
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : LAND1_code,
        },
    ]
);
annotate service.CorporateMD with @(
    UI.HeaderInfo : {
        TypeName : 'Company Information',
        TypeNamePlural : 'Companies',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Company Code Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
    UI.FieldGroup #CompanyForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : RBUKRS,
            },{
                $Type : 'UI.DataField',
                Value : Description,
            },{
                $Type : 'UI.DataField',
                Value : LAND1_code,
            }],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'CompanyForm',
            Target : '@UI.FieldGroup#CompanyForm',
        },]
);

annotate service.CorporateMD with {
    RBUKRS @Common.FieldControl : #Mandatory;
    Description @Common.FieldControl : #Mandatory;
    LAND1 @Common.FieldControl : #Optional;
};

/*annotate service.CorporateMD with @(UI : {
QuickViewFacets             : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Address',
        Target : '@UI.FieldGroup#SoldToQuickView'
    }
],
FieldGroup #SoldToQuickView : {Data : [
    {
        $Type : 'UI.DataField',
        Value : Description
    },
    {
        $Type : 'UI.DataField',
        Value : LAND1
    }
]}
});*/

