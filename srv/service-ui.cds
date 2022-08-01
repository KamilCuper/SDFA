using DataService from './services';

annotate DataService.EUTObject with {
    ID          @title : 'ID';
    RBUKRS      @title : 'Company';
    PRCTR       @title : 'Profit Center';
    GJAHR       @title : 'Fiscal Year';
    WERKS       @title : 'Plant';
    Activities  @title : 'Activities';
} ;
annotate DataService.EUT_ACTIVITIES with {
    ID                  @title : 'ID';
    Scenario            @title : 'Scenario';
    EUT_Object          @title : 'EUT Reporting Object';
    EA_Object           @title : 'Economic Activity';
    Financial_Input     @title : 'Financial Input Items';
    Screening_Input     @title : 'EUT Screening Input Items'
}