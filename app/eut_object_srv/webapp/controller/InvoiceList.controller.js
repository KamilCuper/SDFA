sap.ui.define([
    "sap/fe/core/PageController",
    "sap/fe/core/AppComponent"
], function (PageController, Component) {
	"use strict";

	return PageController.extend("eut.eutobjectsrv.controller.InvoiceList", {
		onInit: function () {
			//make sure to call prototype onInit before adding custom code here
			PageController.prototype.onInit.apply(this);
			//custom code added here
		}
	});
});
