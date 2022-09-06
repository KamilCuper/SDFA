sap.ui.define([
	"sap/ui/core/mvc/XMLView",
	"sap/ui/core/mvc/Controller",
	"sap/ui/core/Fragment"
],
function (XMLView, Controller, Fragment){
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
			this.pDialog.then(function(sDialog) {
				sDialog.open();
			});
			
			/*XMLView.create({
				viewName: "eut.eutobjectsrv.view.InvoiceList"
			}).then(function (oView) {
				oView.placeAt("content");
			});*/


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
