sap.ui.define([
    "sap/ui/core/mvc/Controller",
	"sap/m/MessageToast",
	"sap/ui/core/Fragment"
],
function (Controller, MessageToast, Fragment){
    "use strict";
    return {
        DataImport: function(oEvent) {
			MessageToast.show("Controller extension based action handler invoked for object '");
              
            // create dialog lazily
			/*if (!this.pDialog) {
				this.pDialog = this.loadFragment({
					name: "ns.financialinput.view.View"
				});
			} 
			this.pDialog.then(function(oDialog) {
				oDialog.open();
			});*/
        },

		onCloseDialog : function () {
			MessageToast.show("Second message '");
			// note: We don't need to chain to the pDialog promise, since this event-handler
			// is only called from within the loaded dialog itself.
			this.byId("helloDialog").close();
		}
    }

});
