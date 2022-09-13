sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/ui/model/resource/ResourceModel"
], function (Controller, JSONModel, ResourceModel) {
	"use strict";

	return Controller.extend("eut.eutobjectsrv.controller.App", {

		onInit : function () {
			// set data model on view
			var oData = {
				recipient : {
					name : "World"
				}
			};
			var oModel = new JSONModel(oData);
			this.getView().setModel(oModel);

			// set i18n model on view
			var i18nModel = new ResourceModel({
				bundleName: "eut.eutobjectsrv.i18n.i18n"
			});
			this.getView().setModel(i18nModel, "i18n");
		}
        
	});

});