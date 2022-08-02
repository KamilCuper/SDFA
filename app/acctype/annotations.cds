using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/Mappings';



annotate service.ACC_TYPE_MAPPING with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Company_RBUKRS,
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT,
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code,
        },
        {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR,
        },
        {
            $Type : 'UI.DataField',
            Value : Comment,
        },
    ]
);
annotate service.ACC_TYPE_MAPPING with {
    Company @(
        Common: {
            Text: Company.Description,
            //TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Companies',
                CollectionPath: 'CorporateMD',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:Company_RBUKRS,
                    ValueListProperty: 'RBUKRS'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'}
                ]
            }
        }
    );
    RACCT_TYPE @(
        Common: {
            Text: RACCT_TYPE.name,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Account Types',
                CollectionPath: 'AcctTypeObject',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:RACCT_TYPE_code,
                    ValueListProperty: 'code'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'}
                ]
            }
        }
    );
};

annotate service.ACC_TYPE_MAPPING with @(
    UI.HeaderInfo : {
        TypeName : 'Account Type Mapping',
        TypeNamePlural : 'Account Type Mappings',
        Title :{
            $Type : 'UI.DataField',
            Value : 'Account Type Mapping'
        },
        Description : {
            $Type : 'UI.DataField',
            Value : ''
        }
    }
);
annotate service.ACC_TYPE_MAPPING with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Account Type Mapping',
            ID : 'AcctTypeForm',
            Target : '@UI.FieldGroup#AcctTypeForm',
        },]
);
annotate service.ACC_TYPE_MAPPING with @(
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : Company_RBUKRS,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    }
);
annotate service.ACC_TYPE_MAPPING with @(
    UI.FieldGroup #AcctTypeForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Company_RBUKRS,
            },{
                $Type : 'UI.DataField',
                Value : RACCT,
            },{
                $Type : 'UI.DataField',
                Value : RACCT_TYPE_code,
            },{
                $Type : 'UI.DataField',
                Value : GF_INDICATOR,
            },{
                $Type : 'UI.DataField',
                Value : Comment,
            },],
    }
);
annotate service.ACC_TYPE_MAPPING with {
    Company         @Common.FieldControl : #Mandatory;
    RACCT           @Common.FieldControl : #Mandatory;
    GF_INDICATOR    @Common.FieldControl : #Optional;
    Comment         @UI.MultiLineText    : true;
    Comment         @Common.FieldControl : #Optional;
    RACCT_TYPE      @Common.FieldControl : #Mandatory
};