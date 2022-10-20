using {
    managed,
    Currency,
    Country,
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



@UI.Identification : [{Value : Description}]
entity CorporateMD : managed {
    key RBUKRS      : CompanyCode;
    Description     : Description;
    LAND1           : Country;
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


entity ScreeningCriteriaTemplate : managed {
    CONT_MEAS       : ContributionMeasure;
    key CRITER      : Criterion;
    CRITER_DESCR    : Description @title : 'Screening Criterion Description';
    CRITER_SHORT_DESCR : ShDescription @title : 'Screening Criterion Short Description';
    CRIT_UNIT       : CriteriaUnit;
    CRIT_SC_U       : SCUpperLimit @title : 'Upper Limit for Substantial Contribution';
    CRIT_SC_L       : SCLowerLimit @title : 'Lower limit for Substantial Contribution';
    CRIT_DNSH_U     : DNSHUpperLimit @title: 'Upper limit for Do No Significant Harm Contribution';
    CRIT_DNSH_L     : DNSHLowerLimit @title : 'Lower limit for Do No Significant Harm Contribution';
    SC_FLAG         : SCFlag;
    DNSH_FLAG       : DNSHFlag;
    SUBST           : Substance;
    COND_GHGU       : GHGUpperLimit;
    COND_GHGL       : GHGLoweLimit;
    COND_UNIT       : ConditionUnit;
    ENGN_CATG       : EngineCategory;
    VEH_CATG        : VehicleCategory;
    VEH_SCATG       : VehicleSubCategory;
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
    OPH_L           : OperatedHoursLowerLimit;
    CALC_MEAS       : CalcMeasure;
    LADEN_L         : LowerMaxLadenMass;
    LADEN_U         : UpperMaxLadenMass;
    ENERGYV         : EnergyOfVevhicle;
    CRITICALITY     : Integer;
    HELP            : Help;
    HELP_I          : Help_I;
    HELP_P          : Help_P;
    
};

entity CriteriaApplicability : managed {
    key ID          : GUID;
    ECO_ACT         : Association to one ECO_ACT_OBJECT @title : 'Economic Activity';
    ENV_OB          : Association to one EnvObjectiveObject @title : 'Environmental Objective';
    CRITER          : Association to one ScreeningCriteriaTemplate @title: 'Screening Criterion';
    LVL1_VAR        : Lvl1_var;
    LVL1_VAL        : Lvl1_val;
    LVL2_VAR        : Lvl2_var;
    LVL2_VAL        : Lvl2_val;
    LVL3_VAR        : Lvl3_var;
    LVL3_VAL        : Lvl3_val;
    LVL4_VAR        : Lvl4_var;
    LVL4_VAL        : Lvl4_val;
    SUBST           : Substance

};

entity EnvObjectiveObject : managed {
    key ID          : EnvironmentalObjective;
    Description     : Description
};

entity ContributionTypeObject : managed {
    key ID          : ContributionTypeLong default 'MS';
    Description     : Description default 'Minimum Safeguards'
};

//type LAND1 : String @title : 'Country';

type EUT_ELIGIBLE : Boolean @title : 'EUT Eligible';
type EnablingActivity : Boolean @title : 'Enabling Activity';


type ContributionMeasure : String @title :'Contribution Measure';
type Criterion : String @title :'Screening Criterion';
type CriteriaUnit : String @title :'Screening Criteria Unit';
type SCUpperLimit : Decimal @title :'Substantial Contribution Upper Limit Screening Criteria';
type SCLowerLimit : Decimal @title :'Substantial Contribution Lower Limit Screening Criteria';
type DNSHUpperLimit : Decimal @title :' Do No Significant Harm Upper Limit Screening Criteria';
type DNSHLowerLimit : Decimal @title :'Do No Significant Harm Lower Limit Screening Criteria';
type Substance : String @title :'Substance/Parameter';
type GHGUpperLimit : Decimal @title :'Upper limit Condition for GHG emissions';
type GHGLoweLimit : Decimal @title :'Lower limit Condition for GHG emissions';
type ConditionUnit : String @title :'Condition Unit';
type EngineCategory : String @title :'Engine Category';
type VehicleCategory : String @title :'Vehicle Category';
type VehicleSubCategory : String @title : 'Vehicle Sub Category';
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
type LowerMaxLadenMass : String @title : 'Lower limit of Maximum laden mass';
type UpperMaxLadenMass : String @title : 'Upper limit of Maximum laden mass';
type EnergyOfVevhicle : String @title : 'Energy of Vehicle';


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
type ContributionTypeLong : String @title : 'Contribution Type';

type Help         : Boolean @title : 'Help';
type Help_I         : Boolean @title : 'Help_I';
type Help_P         : Boolean @title : 'Help_P';
type  ShDescription : String @title :'Screening Criterion Short';
type SCFlag : Boolean @title :'SC Flag';
type DNSHFlag : Boolean @title :'DNSH Flag';
type Lvl1_var : String @title : 'Level 1 variable';
type Lvl1_val : String @title : 'Level 1 value';
type Lvl2_var : String @title : 'Level 2 variable';
type Lvl2_val : String @title : 'Level 2 value';
type Lvl3_var : String @title : 'Level 3 variable';
type Lvl3_val : String @title : 'Level 3 value';
type Lvl4_var : String @title : 'Level 4 variable';
type Lvl4_val : String @title : 'Level 4 value';  