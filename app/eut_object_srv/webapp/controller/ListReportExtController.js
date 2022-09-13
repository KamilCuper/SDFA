sap.ui.define([
	"sap/m/MessageBox",
	"sap/m/MessageToast"
], function (MessageBox, MessageToast){
    "use strict";
    
	return  {
        dataImport: function(oContext) {
			MessageToast.show("Placeholder for data import");

		},


		selectEAs: function(oEvent) {
			//this.showSideContent("Activities");

			if (!this.rDialog) {
				this.rDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.HelloDialog"
				});
			} 
			this.rDialog.then(function(oDialog) {
				oDialog.open();
			});

        },

		selectFRs: function(oEvent) {
			if (!this.rDialog) {
				this.rDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.SelectFinances"
				});
			} 
			this.rDialog.then(function(oDialog) {
				oDialog.open();
			});
		}
    }
});
