using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/Mappings';



annotate service.EA_MAPPING with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Company_RBUKRS,
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
        },
        {
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR,
            Label : 'Profit Center'
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
            Label : 'Plant'
        },       
        {
            $Type : 'UI.DataField',
            Value : ECO_ACT_ECO_ACT,
        }
    ],
);
annotate service.EA_MAPPING with @(
        UI.HeaderInfo : {
        TypeName : 'Economic Activity Mapping',
        TypeNamePlural : 'Economic Activity Mappings',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Mapping Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : 'Economic Activity',
        },
    },
    UI.FieldGroup #EcoMapForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value : ID,
        },
            {
            $Type : 'UI.DataField',
            Value : Company_RBUKRS,
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
        },
        {
            $Type : 'UI.DataField',
            Value : PRCTR_PRCTR,
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS_WERKS
        },
        {
            $Type : 'UI.DataField',
            Value : ECO_ACT_ECO_ACT,
        },],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            //Label : 'Company Form',
            ID : 'EcoMapForm',
            Target : '@UI.FieldGroup#EcoMapForm',
        },
    ]
);

annotate service.EA_MAPPING with {
    ID              @Common.FieldControl : #Mandatory;
    GJAHR           @Common.FieldControl : #Mandatory;
    Company @(
            Common: {
                Text: Company.Description,
                FieldControl : #Mandatory,
                ValueList: {
                    Label: 'Companies',
                    CollectionPath: 'CorporateMD',
                    Parameters: [
                        { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty:  Company_RBUKRS,
                        ValueListProperty: 'RBUKRS'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'Description'}
                    ]
                }
            }
    );
    PRCTR @(
            Common: {
                Text: PRCTR.DESCR,
                FieldControl : #Optional,
                ValueList: {
                    Label: 'Profit Centers',
                    CollectionPath: 'ProfitCenterObject',
                    Parameters: [
                        { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty:  PRCTR_PRCTR,
                        ValueListProperty: 'PRCTR'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'DESCR'}
                    ]
                }
            }
    );
    WERKS @(
            Common: {
                Text: WERKS.DESCR,
                FieldControl : #Optional,
                ValueList: {
                    Label: 'Plants',
                    CollectionPath: 'PlantObject',
                    Parameters: [
                        { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty:  WERKS_WERKS,
                        ValueListProperty: 'WERKS'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'DESCR'}
                    ]
                }
            }
    );
    ECO_ACT @(
            Common: {
                Text: ECO_ACT.Description,
                TextArrangement : #TextOnly,
                FieldControl : #Mandatory,
                ValueList: {
                    Label: 'Economic Activities',
                    CollectionPath: 'ECO_ACT_OBJECT',
                    Parameters: [
                        { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty:  ECO_ACT_ECO_ACT,
                        ValueListProperty: 'ECO_ACT'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'Description'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'EUT_Eligible'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'ENB_ACT'},
                        {$Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'Comment'}
                    ]
                }
            }
    );
};