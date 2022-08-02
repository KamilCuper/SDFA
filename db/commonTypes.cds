type GUID : UUID @title : 'ID'  @odata.Type : 'Edm.String'  @UI.Hidden;
type Description : String @title : 'Description'  @mandatory  @assert.notNull; //  @Core.Immutable woud bring it up in creation popup as well
type Documentation : LargeString @title : 'Documentation'  @mandatory  @assert.notNull; //  @Core.Immutable woud bring it up in creation popup as well
type ProfitCenter :String @title : 'Profit Center';
type CostCenter :String @title : 'Cost Center';
type FiscalYear : String(4) @title : 'Fiscal Year'  @assert.format : '[0-9]{4}';
type CompanyCode : String @title : 'Company';
type GSCEN : String @title : 'Scenario for Reporting';
type Plant : String @title : 'Plant';
type Comment : String @title : 'Comment';
type Account : String @title : 'GL Account';
type GFIndicator : Boolean @title : 'Green Finance Indicator';


aspect myCodeList @(
    cds.odata.valuelist,
    cds.autoexpose,
    cds.persistence.skip : 'if-unused'
) {
    name  : String(255)     @title : '{i18n>Name}';
    descr : String(1000)    @title : '{i18n>Description}'
}

entity AcctTypeObject : myCodeList {
    key code : AccountType
};
type AccountType @(assert.range) : String @title : 'Account Type' enum {
    Capex = 'C';
    Opex = 'O';
    Turnover = 'T';
};