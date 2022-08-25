using DataService as service from '../../srv/services';
using from '../../srv/services';
using from '../../db/EUTObject';

annotate service.FINANCIAL_INPUT with @(
    UI.LineItem : {
        $value : [
        {
            $Type : 'UI.DataField',
            Value : RBUKRS_RBUKRS,
            Criticality: criticality        
        },
        {
            $Type : 'UI.DataField',
            Value : GJAHR,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Label : 'Plant',
            Value : WERKS_WERKS,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : KSL,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR,
            Criticality: criticality
        }
    ],
    }   
);


annotate service.FINANCIAL_INPUT with {
    @Common.SemanticObject : 'SemanticCostCenter'
    RBURKS
};

annotate service.FINANCIAL_INPUT with @(
    UI.SelectionFields : [
        RBUKRS_RBUKRS,
    ]
);

annotate service.FINANCIAL_INPUT with @(
    UI.PresentationVariant : {
        GroupBy : [
            WERKS_WERKS
        ],
        Total : [
            HSL
        ],
        Visualizations : [
            '@UI.LineItem'
        ]
    }
);

annotate service.FINANCIAL_INPUT with {
    RBUKRS @(
        Common : {
            Text  : RBUKRS.Description,
            TextArrangement : #TextFirst,
            /*ValueListWithFixedValues : true,
            ValueList : {
                CollectionPath : 'CorporateMD',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : RBUKRS_RBUKRS,
                        ValueListProperty : 'RBUKRS',
                    },
                    {
                        $Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'LAND1'
                    }
                ],
        }*/
        }
)};
annotate service.CorporateMD with {
    RBUKRS @Common.Text : {
        $value : Description,
        ![@UI.TextArrangement] : #TextFirst,
    }
};

annotate service.PlantObject with {
    WERKS @Common.Text : {
        $value : DESCR,
        ![@UI.TextArrangement] : #TextFirst,
    }
};

annotate service.CorporateMD with @(UI : {
    QuickViewFacets             : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Details',
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
});

annotate service.FINANCIAL_INPUT with {
    KSL @Measures.ISOCurrency : RKCUR_code
};

annotate service.FINANCIAL_INPUT with {
    RACCT_TYPE @Common.Text : {
            $value : RACCT_TYPE.descr,
            ![@UI.TextArrangement] : #TextFirst,
        }
};

annotate service.FINANCIAL_INPUT with @(
    UI.SelectionVariant #Good : {
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : EUT_ACTIVITIES_ID,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #BT,
                        Low : '1',
                        High : '2',
                        Sign : #I
                    }
                ]
            }
        ],
        Text : 'Records with EUT Link'
    },
);

annotate service.FINANCIAL_INPUT with @(
    UI.SelectionVariant #NotSoGood : {
        $Type : 'UI.SelectionVariantType',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : EUT_ACTIVITIES_ID,
                Ranges : [
                    {
                        $Type : 'UI.SelectionRangeType',
                        Option : #NB,
                        Low : '1',
                        High : '2',
                        Sign : #I
                    }
                ]
            }
        ],
        Text : 'Records without EUT Link'
    }
);

annotate service.FINANCIAL_INPUT with @(
    UI.SelectionPresentationVariant #OpenSPVWithPVPath : {
        $Type : 'UI.SelectionPresentationVariantType',
        Text                : 'Open',
        SelectionVariant    : {
                Text          : 'Open',
                SelectOptions : []
            },
            PresentationVariant : ![@UI.PresentationVariant#PVPath]
        },

    UI.PresentationVariant #PVPath : {
        MaxItems       : 10,
        SortOrder      : [{Property : ID}],
        GroupBy : [WERKS_WERKS],
        Visualizations : ['@UI.LineItem']
    }
);



