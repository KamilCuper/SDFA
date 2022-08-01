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
type AccountType @(assert.range) : String @title : 'Account Type' enum {
    C = 'Capex';
    O = 'Opex';
    T = 'Turnover';
};
type GFIndicator : Boolean @title : 'Green Finance Indicator';