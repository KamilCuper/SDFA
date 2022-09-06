sap.ui.define([
	"sap/m/MessageBox",
	"sap/ui/core/Fragment"
],
function (MessageBox, Fragment){
    "use strict";
    return {
        dataImport: function(oEvent) {
        },

		selectEAs: function(oEvent) {
			if (!this.pDialog) {
				this.pDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.HelloDialog"
				});
			} 
			this.pDialog.then(function(oDialog) {
				oDialog.open();
			});
        },

		selectFRs: function(oEvent) {
//			MessageBox.alert("Allert on Financial Inputs.");
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
