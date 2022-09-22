using DataService as service from '../../srv/services';

annotate service.MSInput with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS,
            Label : 'Company Name',
            ![@UI.Importance] : #High,
            ![@HTML5.CssDefaults] : {width : '25rem'}
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
            ![@HTML5.CssDefaults] : {width : '8rem'}
        },
        {
            $Type : 'UI.DataField',
            Value : CRITER.CRITER_DESCR,
            ![@UI.Importance] : #High,
            ![@HTML5.CssDefaults] : {width : '30rem'}
        }
    ]
);


annotate service.MSInput with @(
    UI.SelectionPresentationVariant #MSInputsPresentation : {
        Text                : 'MSInputs Selection Presentation Variant',
        SelectionVariant    : {
            Text          : 'MSInputs Selection Variant',
            SelectOptions : [
                {
                    PropertyName : CRITER_CRITER,
                    Ranges : [
                        {
                            Sign : #I,
                            Option : #GT,
                            Low : 0,
                        }
                    ]
                }
            ]
        },
        PresentationVariant : ![@UI.PresentationVariant]
    },

    UI.PresentationVariant : {
        MaxItems       : 10,
        GroupBy: [
            RBUKRS_RBUKRS         
        ],
        Visualizations : ['@UI.LineItem']        
    }
);

annotate service.MSInput with @(
    UI.HeaderInfo : {
        TypeName : 'MS Criteria Info',
        TypeNamePlural : 'MSInputs',
        Description : {
            $Type : 'UI.DataField',
            Value : 'Minimum Safeguard Criteria Details',
        },
        Title : {
            $Type : 'UI.DataField',
            Value : RBUKRS.Description,
        },
    },
    UI.FieldGroup #MSInputsForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
               $Type : 'UI.DataField',
                Label : 'Company Name',
                Value : RBUKRS_RBUKRS
            },{
                $Type : 'UI.DataField',
                Value : CRITER_CRITER,
            },{
                $Type : 'UI.DataField',
                Value : GJAHR,
            },{
                $Type : 'UI.DataField',
                Label : 'Contribution type',
                Value : TYP_CONT.Description,
            },{
                $Type : 'UI.DataField',
                Value : INDICATOR_IV,
                Criticality : CRITICALITY
            },{
                $Type : 'UI.DataField',
                Value : CRITER.CRIT_UNIT,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Minimum Safeguard Form',
            ID : 'MSForm',
            Target : '@UI.FieldGroup#MSInputsForm',
        }
    ]
);

annotate service.MSInput with {
  ID @UI.Hidden;
};

annotate service.ScreeningCriteriaTemplate with {
    CRIT_UNIT @Common.FieldControl : #ReadOnly;
}

annotate service.ContributionTypeObject with {
    Description @Common.FieldControl : #ReadOnly;
}

annotate service.MSInput with {
    RBUKRS @Common.FieldControl : #Mandatory;
    CRITER @Common.FieldControl : #Mandatory;
    GJAHR @Common.FieldControl : #Mandatory;


};

annotate service.MSInput with {
    CRITER @(
        Common: {
            Text: CRITER.CRITER_DESCR,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'MSInputCriteria',
                Parameters: [
                    { 
                        $Type: 'Common.ValueListParameterInOut',
                        ValueListProperty: 'Criteria',
                        LocalDataProperty: CRITER_CRITER
                    },{
                        $Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'CriteriaDescription',
                    }/*,{
                        $Type : 'Common.ValueListParameterFilterOnly',
                        ValueListProperty : 'CRITER_DESCR',
                    },{
                        $Type : 'Common.ValueListParameterIn', //Input parameter used for filtering
                        LocalDataProperty : CRITER.CRITER_DESCR,
                        ValueListProperty : 'CRITER_DESCR',
                    }*/
                ]
            }
        }
    );

    RBUKRS @(
        Common: {
            Text: RBUKRS.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Criteria',
                CollectionPath: 'CorporateMD',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:RBUKRS_RBUKRS,
                    ValueListProperty: 'RBUKRS'},
                    {$Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'}
                ]
            }
        }
    );


    /*GJAHR @(
        Common: {
            ValueList: {
                Label: 'Years',
                CollectionPath: 'EUT_Activities',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:GJAHR,
                    ValueListProperty: 'GJAHR'}
                ]
            }
        }
    );*/



}