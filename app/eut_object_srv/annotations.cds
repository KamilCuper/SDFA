using EUTObjectService as service from '../../srv/services';


/*************************************************************************************************/
//               Annotations for External Entities fields display
/*************************************************************************************************/
annotate service.EUTObject with {
  ID @UI.Hidden;
};

annotate service.CorporateMD with {
    RBUKRS @Common.Text : {
        $value : Description,
        UI.TextArrangement : #TextFirst,
    }
};

annotate service.ProfitCenterObject with {
    PRCTR @Common.Text : {
        $value : DESCR,
        UI.TextArrangement : #TextFirst,
    }
};

annotate service.PlantObject with {
    WERKS @Common.Text : {
        $value : DESCR,
        UI.TextArrangement: #TextFirst,
    }
};

annotate service.EUT_Activities with {
    EA_Object @(
        Common: {
            Text : EA_Object.Description,
            TextArrangement : #TextOnly,
            ValueList: {
                Label: 'Economic Activities',
                CollectionPath: 'ECO_ACT_OBJECT',
                Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty:EA_Object_ECO_ACT,
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


/*************************************************************************************************/
//               Selection Fields, Selection Variant and Presentation Variant
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.SelectionFields : [
        RBUKRS_RBUKRS,
        GJAHR,
        PRCTR_PRCTR,
        WERKS_WERKS
    ]
);

/*************************************************************************************************/
//               Annotations for EUTObject fields display and Value Help lists
/*************************************************************************************************/
annotate service.EUTObject with {
    RBUKRS @(
        Common : {
            Text  : RBUKRS.Description,
            TextArrangement : #TextFirst,
            ValueListWithFixedValues : true
        }
    );
    GJAHR @(
        Common: {
            ValueListWithFixedValues : true,
            ValueList: {
                Label: 'Years',
                CollectionPath: 'YearsListView',
                Parameters: [
                    { 
                        $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty: GJAHR,
                        ValueListProperty: 'FiscalYear'
                    }
                ]
            }
        }
    );
    PRCTR @(
        Common: {
            Text: PRCTR.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
    WERKS @(
        Common: {
            Text: WERKS.DESCR,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true
        }
    );
};


/*************************************************************************************************/
//                      Annotations for LIST REPORT Page
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.LineItem: {
        $value:[
            {
                $Type : 'UI.DataField',
                Label : 'Company Code',
                Value : RBUKRS_RBUKRS,
                ![@UI.Importance] : #High
            },
            {
                $Type : 'UI.DataField',
                Label: 'Year',
                Value : GJAHR
            },
            {
                $Type : 'UI.DataField',
                Label: 'Profit Center',
                Value : PRCTR_PRCTR
            },
            {
                $Type : 'UI.DataField',
                Label: 'Plant',
                Value : WERKS_WERKS,
                ![@UI.Importance] : #High
            },
            {
                $Type : 'UI.DataField',
                Label: 'Scenario',
                Value : Activities.Scenario
            },
          //  {
          //      $Type : 'UI.DataField',
          //      Value : Activities.ID,
          //      Label : 'Assigned EUT Activities'
          //  }
        ]
    }
);


/*************************************************************************************************/
//                      Annotations for EUT OBJECT Page - Header & Content
/*************************************************************************************************/
annotate service.EUTObject with @(
    UI.DataPoint #Company :{
        Value : RBUKRS_RBUKRS ,
        Title : 'Company'
    },
    UI.DataPoint #Year :{
        Value : GJAHR ,
        Title : 'Fiscal Year'
    },
    UI.DataPoint #ProfitCenter :{
        Value : PRCTR_PRCTR,
        Title : 'Profit Center'
    },
    UI.DataPoint #Plant :{
        Value : WERKS_WERKS ,
        Title : 'Plant'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Company'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#ProfitCenter'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Plant'
        },
    ],
    UI.LineItem #ContentGroup2: [
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object_ECO_ACT,
                Label : 'Assigned Economic Activities',
                //Target: Activities
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.EUT_Eligible
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.ENB_ACT
            },
            {
                $Type : 'UI.DataField',
                Value : Activities.EA_Object.Comment
            }
        ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details on Economic Activities',
            Target: 'Activities/@UI.LineItem#Activities'
        }
    ]
    
);


/*************************************************************************************************/
//                    Annotations for EUT Activity OBJECT Page - Header
/*************************************************************************************************/
annotate service.EUT_Activities with @(
    UI.DataPoint #Company :{
        Value : EUT_Object.RBUKRS.Description ,
        Title : 'Company'
    },
    UI.DataPoint #Year :{
        Value : EUT_Object.GJAHR ,
        Title : 'Fiscal Year'
    },
    UI.DataPoint #Scenario :{
        Value : Scenario ,
        Title : 'Scenario'
    },
    UI.DataPoint #Activity :{
        Value : EA_Object_ECO_ACT ,
        Title : 'Economic Activity'
    },
    UI.DataPoint #Plant:{
        Value : EUT_Object.WERKS,
        Title : 'Economic Activity'
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Activity'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Company'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Plant'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Year'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Scenario'
        },
    ]
);

/*************************************************************************************************/
//                    Annotations for EUT Activity OBJECT Page - Content
/*************************************************************************************************/
annotate service.EUT_Activities with @(
    UI.LineItem #Activities: [
        {
            $Type : 'UI.DataField',
            Value : EA_Object_ECO_ACT
            
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.EUT_Eligible,
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.ENB_ACT,
        },
        {
            $Type : 'UI.DataField',
            Value : EA_Object.Comment,
        }
    ],
    
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Economic Activities Overview',
            ID    : 'EAoverview',
            Target: 'EA_Object/@UI.FieldGroup#EAObjectGroup1'
        }
        
    ]
);

/*************************************************************************************************/
//                    Annotations for Economic Activity OBJECT Page - Header
/*************************************************************************************************/
annotate service.ECO_ACT_OBJECT with @(
    UI.FieldGroup #EAObjectGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Description
            },
            {
                $Type : 'UI.DataField',
                Value : EUT_ELIGIBLE
            },
            {
                $Type : 'UI.DataField',
                Value : EnablingActivity
            },
            {
                $Type : 'UI.DataField',
                Value : Comment
            },
        ],
    }

);