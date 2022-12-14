sap.ui.define([
	"sap/m/MessageBox",
    "sap/ui/core/Fragment",
	"sap/ui/core/library",
	"sap/ui/model/odata/v4/ODataModel"
], function (MessageBox, Fragment, CoreLibrary, ODataModel) {
	"use strict";

    return  {
        
        handleOpenDialog: function (oEvent) {
            this.isWizardOpen = 0;

			if (!this._pDialog) {
				this._pDialog = this.loadFragment({
					name: "ns.corporatemd.view.ImportWizard",
				}).then(function(ioDialog) {
					ioDialog.attachAfterOpen(_afterOpen, this);
					return ioDialog;
				}.bind(this));
			}

			this._pDialog.then(function(ioDialog){
				ioDialog.open();
			});
		},


        onDialogBackButton: function () {	
			this._iSelectedStepIndex = this._oWizard.getSteps().indexOf(this._oSelectedStep);
			var oPreviousStep = this._oWizard.getSteps()[this._iSelectedStepIndex - 1];

			if (this._oSelectedStep) {
				this._oWizard.goToStep(oPreviousStep, true);
			} else {
				this._oWizard.previousStep();
			}

			this._iSelectedStepIndex--;
			this._oSelectedStep = oPreviousStep;
			_handleButtonsVisibility(this._iSelectedStepIndex);
		},


        onDialogNextButton: function () {
			if(this.isWizardOpen == 0){
				this.isWizardOpen = 1;
				this._oWizard = sap.ui.getCore().byId("CreateImportWizard");
				this._iSelectedStepIndex = 0;
				this._oSelectedStep = this._oWizard.getSteps()[this._iSelectedStepIndex];				
			}

			this._iSelectedStepIndex = this._oWizard.getSteps().indexOf(this._oSelectedStep);
			var oNextStep = this._oWizard.getSteps()[this._iSelectedStepIndex + 1];

			if (this._oSelectedStep && !this._oSelectedStep.bLast) {
				this._oWizard.goToStep(oNextStep, true);
			} else {
				this._oWizard.nextStep();
			}

			this._iSelectedStepIndex++;
			this._oSelectedStep = oNextStep;
			_handleButtonsVisibility(this._iSelectedStepIndex);
		},

        handleWizardCancel: function (oEvent) {
			_handleMessageBoxOpen("Are you sure you want to cancel your report?", "warning");
			this._pDialog.destroy();
		},

		handleWizardSubmit: function () {
			_handleMessageBoxOpen("Are you sure you want to submit your report?", "confirm");
			this._pDialog.close();
		},

		onFileChange: function(e){
			var file = e.getParameters("files").files[0];

			var reader = new FileReader();
			reader.onload = function (e) {
				var strCSV = e.target.result;
				var arrCSV = strCSV.match(/[\w .]+(?=,?)/g);
				var noOfCols = 6;

				// To ignore the first row which is header
				var hdrRow = arrCSV.splice(0, noOfCols);

				var data = [];
				while (arrCSV.length > 0) {
					var obj = {};
					// extract remaining rows one by one
					var row = arrCSV.splice(0, noOfCols)
					for (var i = 0; i < row.length; i++) {
						obj[hdrRow[i]] = row[i].trim()
					}
					// push row to an array
					data.push(obj)
				}
				
				//this.oModel = new sap.ui.model.json.JSONModel();
				//this.oModel.setData(data);
				//this.oTable = sap.ui.getCore().byId("idTable");
				//alert(this.oTable);
				//this.oTable.setModel(this.oModel);
				//this.oTable.bindRows("items");
				//oTable.refresh(true);
				
				
			}
			//alert("before read in of data");
			reader.readAsBinaryString(file);
			
			var nextBtn = sap.ui.getCore().byId("nextbtn");
			nextBtn.setVisible(true);

		}
    };

    function _afterOpen(){
		var previousBtn = sap.ui.getCore().byId("previousbtn");
		var nextBtn = sap.ui.getCore().byId("nextbtn");
		var reviewBtn = sap.ui.getCore().byId("reviewbtn");
		var finishBtn = sap.ui.getCore().byId("finishbtn");
		var cancelBtn = sap.ui.getCore().byId("cancelbtn");	

		previousBtn.setVisible(false);
		nextBtn.setVisible(false);
		reviewBtn.setVisible(false);
		finishBtn.setVisible(false);
		cancelBtn.setVisible(true);
	}


    function _handleButtonsVisibility(indexStep) {
		var previousBtn = sap.ui.getCore().byId("previousbtn");
		var nextBtn = sap.ui.getCore().byId("nextbtn");
		var reviewBtn = sap.ui.getCore().byId("reviewbtn");
		var finishBtn = sap.ui.getCore().byId("finishbtn");

		switch (indexStep){
			case 0:
				previousBtn.setVisible(false);
				nextBtn.setVisible(false);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
			case 1:
				previousBtn.setVisible(true);
				nextBtn.setVisible(false);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(true);
				break;
			default: break;
		}

	}

    function _handleMessageBoxOpen(sMessage, sMessageBoxType) {
		MessageBox[sMessageBoxType](sMessage, {
			actions: [MessageBox.Action.YES, MessageBox.Action.NO],
			onClose: function (oAction) {
				if (oAction === MessageBox.Action.YES) {
					sap.ui.getCore().byId("wizardImportDialog").close();
					
				}
			}
		});

		
	}


});