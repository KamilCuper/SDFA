sap.ui.define([
	"sap/m/MessageToast",
	"sap/ui/core/Fragment",
	"sap/ui/base/Event"
],
function (MessageToast, Fragment, Event){
    "use strict";
    return {
		insertInput: function(oEvent) {
			var oButton = oEvent.getSource().getBindingContext().getId();
			MessageToast.show("Inside QuickView function" + oButton);			
		},

		
    }
});
