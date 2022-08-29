sap.ui.define([
	"sap/m/MessageToast",
	"sap/ui/core/Fragment",
	"sap/ui/base/Event"
],
function (MessageToast, Fragment, Event){
    "use strict";
    return {
        dataImport: function(oEvent) {
			MessageToast.show("Controller extension based action handler invoked for object ");
              
            // create dialog lazily
			if (!this.pDialog) {
				this.pDialog = this.loadFragment({
					name: "ns.financialinput.view.View"
				});
			} 
			this.pDialog.then(function(oDialog) {
				oDialog.open();
			});
        },

		openQV: function(oEvent) {
			var oButton = oEvent.getSource().getBindingContext().getId();
			MessageToast.show("Inside QuickView function" + oButton);
			
			if (!this._pQuickView) {
				this._pQuickView = Fragment.load({
					id: oView.getId(),
					name: "ns.financialinput.view.QuickView",
					controller: this
				}).then(function (oQuickView) {
					oView.addDependent(oQuickView);
					return oQuickView;
				});
			}

			this._pQuickView.then(function (oQuickView){
				//oQuickView.setModel(oModel);
				oQuickView.openBy(oButton);
			});
		},


		openMapp: function(oEvent) {
			var oButton = oEvent.getSource().getBindingContext().getId();
			MessageToast.show("Inside QuickView function" + oButton);
			
			
			
		},

		onAfterRendering: function () {
			oButton = this.byId("openQuickViewButton");
			oButton.$().attr("aria-haspopup", true);
		}
    }
});
