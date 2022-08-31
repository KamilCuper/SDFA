using {
    managed,
    Currency,
    temporal,
    cuid,
    extensible,
    sap.common.CodeList
} from '@sap/cds/common';

using {
    GUID,
    Description,
    Comment,
    CompanyCode,
    ProfitCenter,
    Plant
} from './commonTypes';
using {EA_MAPPING,ACC_TYPE_MAPPING} from './Mappings';

using {EUTObject,EUT_SCREENING_INPUT} from './EUTObject';


@UI.Identification : [{Value : Description}]
entity CorporateMD : managed {
    key RBUKRS      : CompanyCode;
    Description     : Description;
    LAND1           : LAND1;
};

@UI.Identification : [{Value : DESCR}]
entity ProfitCenterObject : managed {
    key PRCTR           : ProfitCenter @title : 'Profit Center';
    DESCR               : Description
};

entity PlantObject : managed {
    key WERKS           : Plant;
    DESCR               : Description
}

//@UI.Identification : [{Value : Description}]
entity SECTOR_OBJECT : managed {
    key SECTOR      : GUID;
    Description     : Description;
    Comment         : Comment;
};

@UI.Identification : [{Value : Description}]
entity ECO_ACT_OBJECT : managed {
    key ECO_ACT     : GUID;
    Description     : Description;
    EUT_Eligible    : EUT_ELIGIBLE;
    SECTOR          : Association to one SECTOR_OBJECT @title : 'Sector';
    ENB_ACT         : EnablingActivity;
    Comment         : Comment;
};

@UI.Identification : [{Value : CRITER_DESC}]
entity SCREEN_CRITER_TEMPLT : managed {
    CONT_MEAS       : ContributionMeasure;
    key CRITER      : Criterion;
    CRITER_DESC     : Description @title : 'Screening Criterion Description';
    CRIT_UNIT       : CriteriaUnit;
    CRIT_U          : UpperLimit;
    CRIT_L          : LowerLimit;
    SUBST           : Substance;
    COND_GHGU       : GHGUpperLimit;
    COND_GHGL       : GHGLoweLimit;
    COND_UNIT       : ConditionUnit;
    ENGN_CATG       : EngineCategory;
    VEH_CATG        : VehicleCategory;
    POWER_L         : PowerLowerLimit;
    POWER_U         : PowerUpperLimit;
    IGN_TYP         : IgnitionType;
    EMS_STG         : EmissionStage;
    TYR_CLASS       : TyreClass;
    ENGF_CLASS      : EnergyEfficiencyClass;
    VERF_EPREL      : EnergyLabeling;
    RM              : ReferenceMassClass;
    RM_L            : ReferenceMassLowerLimit;
    RM_U            : ReferenceMassUpperLimit;
    COMBP_L         : CombustionLowerLimit;
    COMBP_U         : CombustionUpperLimit;
    OPH_L           : OperatedHoursLowerLimit;
    TYP_COMB        : CombustionType;
    COMB_UNIT       : CombustionUnit;
    CALC_MEAS       : CalcMeasure;
    TYP_PLANT       : PlantType;
    CRITICALITY     : Integer;
    SCREEN_INPUT    : Association to many EUT_SCREENING_INPUT 
                        on SCREEN_INPUT.CRITER = $self @title : 'Screening Input'; //not required
    /*EA_APPL         : Association to many ECON_CRITER_APPL
                        on EA_APPL.CRITER =$self @title : 'Applicability'*/ //not required
    HELP : Help;
    HELP_I : Help_I;
    HELP_P : Help_P;
};

entity ECON_CRITER_APPL : managed {
    key ID          : GUID ;
    EcoActivity     : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    CRITER          : Association to one SCREEN_CRITER_TEMPLT @title: 'Screening Criterion';
    TYP_CONT        : Association to one ContributionTypeObject @title : 'Contribution Type';
    CCA             : ClimateAdaptation;
    CCM             : ClimateMitigation;
    WAT             : Water;
    CEC             : CircularEconomy;
    PPV             : PollutionPrevention;
    BIO             : Biodiversity;

};

entity EnvObjectiveObject : managed {
    key ID          : EnvironmentalObjective;
    Description     : Description
};

entity ContributionTypeObject : managed {
    key ID          : ContributionTypeLong;
    Description     : Description
};

type LAND1 : String @title : 'Country';

type EUT_ELIGIBLE : Boolean @title : 'EUT Eligible';
type EnablingActivity : Boolean @title : 'Enabling Activity';


type ContributionMeasure : String @title :'Contribution Measure';
type Criterion : String @title :'Screening Criterion';
type CriteriaUnit : String @title :'Screening Criteria Unit';
type UpperLimit : Decimal @title :'Upper Limit Screening Criteria';
type LowerLimit : Decimal @title :'Lower Limit Screening Criteria';
type Substance : String @title :'Substance/Parameter';
type GHGUpperLimit : Decimal @title :'Upper limit Condition for GHG emissions';
type GHGLoweLimit : Decimal @title :'Lower limit Condition for GHG emissions';
type ConditionUnit : String @title :'Condition Unit';
type EngineCategory : String @title :'Engine Category';
type VehicleCategory : String @title :'Vehicle Category';
type PowerLowerLimit : Decimal @title :'Lower limit Power kW';
type PowerUpperLimit : Decimal @title :'Upper limit Power kW';
type IgnitionType : String @title :'Ignition Type';
type EmissionStage : String @title :'Emission Stage';
type TyreClass : String @title :'Tyre Class';
type EnergyEfficiencyClass : String @title :'Energy Efficiency Class';
type EnergyLabeling : String @title :'Verification European Product Registry for Energy Labeling';
type ReferenceMassClass : String @title :'Reference Mass Class';
type ReferenceMassLowerLimit : Decimal @title :'Lower limit Reference Mass, kg';
type ReferenceMassUpperLimit : Decimal @title :'Upper limit Reference Mass, kg';
type CombustionLowerLimit : Decimal @title :'Lower limit Combustion pant total rated thermal input MWth';
type CombustionUpperLimit : Decimal @title :'Upper limit Combustion pant total rated thermal input MWth';
type OperatedHoursLowerLimit : Decimal @title :'Lower limit Operated hours for plant, h/yr';
type CombustionType : String @title :'Type of Combustion';
type CombustionUnit : String @title :'Type of combustion unit';
type CalcMeasure : String @title :'Calculation Measurement';
type PlantType : String @title :'Type of Plant';


type ContributionType @(assert.range) : String @title : 'Contribution Type' enum {
    DNSH        = 'Do Not Significant Harm';
    MS          = 'Minimal Social Safeguard';
    SC          = 'Substantial Contribution';
};
type ClimateAdaptation : Boolean @title :'Climate Adaptation';
type ClimateMitigation : Boolean @title :'Climate Mitigation';
type Water : Boolean @title :'Water';
type CircularEconomy : Boolean @title :'Circular Economy';
type PollutionPrevention : Boolean @title :'Pollution Prevention';
type Biodiversity : Boolean @title :'Biodiversity';
type EnvironmentalObjective : String @title : 'Environmental Objective';
type ContributionTypeLong : String @title : 'Environmental Objective';

type Help         : Boolean @title : 'Help';
type Help_I         : Boolean @title : 'Help_I';
type Help_P         : Boolean @title : 'Help_P';