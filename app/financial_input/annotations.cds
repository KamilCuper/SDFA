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
            
        },
        {
            $Type : 'UI.DataField',
            Label : 'Plant',
            Value : WERKS_WERKS,
            
        },
        {
            $Type : 'UI.DataField',
            Value : RCNTR,
            
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT,
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : KSL,
             
        },
        {
            $Type : 'UI.DataField',
            Value : RACCT_TYPE_code,
            Label : 'Account Type',
            Criticality: criticality
        },
        {
            $Type : 'UI.DataField',
            Value : GF_INDICATOR,
            
        },
        {
            $Type : 'UI.DataField',
            Value : EUT_ACTIVITIES.EA_Object.Description,
            
        },
    ],
    }   
);


annotate service.FINANCIAL_INPUT with {
    @Common.SemanticObject : 'SemanticCostCenter'
    RBUKRS
};






annotate service.FINANCIAL_INPUT with @(
    UI.SelectionFields : [
        RBUKRS_RBUKRS,
    ]
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

annotate service.CorporateMD with @(UI : {
    QuickViewFacets             : [
        {
            $Type  : 'UI.ReferenceFacet',
            //Label  : 'Details',
            Target : '@UI.FieldGroup#SoldToQuickView'
        },
        
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



