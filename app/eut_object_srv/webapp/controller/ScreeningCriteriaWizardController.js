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

			if (!this.rDialog) {
				this.rDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.ScreeningCriteriaWizard",
				}).then(function(oDialog) {
					oDialog.attachAfterOpen(_afterOpen, this);
					return oDialog;
				}.bind(this));
			}

			this.rDialog.then(function(oDialog){
				oDialog.open();
			});


		},

        handleWizardCancel: function () {
			_handleMessageBoxOpen("Are you sure you want to cancel your report?", "warning");
		},

		handleWizardSubmit: function () {
			_handleMessageBoxOpen("Are you sure you want to submit your report?", "confirm");
		},

		handleAdditionCriter: function () {
			this.sCriteriaForm = sap.ui.getCore().byId("PollutionPreventionForm");
			this.sCriteriaForm.setVisible(true);

			//this.sCriteriaTable = sap.ui.getCore().byId("idPOLTable");
			//this.sCriteriaTable.setVisible(true);
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
				this._oWizard = sap.ui.getCore().byId("CreateSCWizard");
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

        editStepOne: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[0], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

		editStepTwo: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[1], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

		editStepThree: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[2], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

		editStepFour: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[3], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

        editStepFive: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[4], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

        editStepSix: function () {
			this.rDialog.then(function(oDialog){
				oDialog.open();
				this._oWizard.goToStep(this._oWizard.getSteps()[5], true);
			}.bind(this));

            _handleButtonsVisibility(this._iSelectedStepIndex);
		},

//------------------------------------------------------------------
//		Functions for Value Help Dialog of indicators criteria
//------------------------------------------------------------------
		onValueHelpRequest: function (oEvent) {
			var sInputValue = oEvent.getSource().getValue();
			this.eventSource = oEvent.getSource();
			
			
			if (!this._pValueHelpDialog) {
				this._pValueHelpDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.ValueHelpDialog",
				}).then(function(vhDialog) {
					return vhDialog;
				});
			}

			this._pValueHelpDialog.then(function(vhDialog) {
				vhDialog.open(sInputValue);
			});
		},

		onValueHelpSearch: function (oEvent) {
			var sValue = oEvent.getParameter("value");
			var oFilter = new sap.ui.model.Filter("", FilterOperator.Contains, sValue);

			//alert(oEvent.getSource());
			//oEvent.getSource().getBinding("items").filter([oFilter]);
			
		},

		onValueHelpClose: function (oEvent) {
			var oSelectedItem = oEvent.getParameter("selectedItem");
			if (!oSelectedItem) {
				return;
			}
			this.eventSource.setValue(oSelectedItem.getTitle());
		},

//------------------------------------------------------------------
//		Functions for Value Help Dialog of Combution Type
//------------------------------------------------------------------

		onCTValueHelpRequest: function (oEvent) {	
			var sInputValue = oEvent.getSource().getValue();
			this.eventSource = oEvent.getSource();

			if (!this._pCTValueHelpDialog) {
				this._pCTValueHelpDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.CTValueHelpDialog",
				}).then(function(ctDialog) {
					return ctDialog;
				}.bind(this));
			}

			this._pCTValueHelpDialog.then(function(ctDialog) {
				//ctDialog.getBinding("items").filter([new sap.ui.model.Filter("VAL_DESCR", FilterOperator.Contains, "Lignite")]);
				ctDialog.open(sInputValue);
			});
		},

		onCTValueHelpSearch: function (oEvent) {
			var sCTValue = oEvent.getParameter("value");
			var oCTFilter = new sap.ui.model.Filter("VAL_DESCR", FilterOperator.EQ, sCTValue);

			//oEvent.getSource().getBinding("items").filter([oCTFilter]);
			
			
			/*var a = [];
			var b = [];
			this.sCTValueHelp = sap.ui.getCore().byId("selectCTDialog");
			var colItems = this.sCTValueHelp.getItems();
			colItems.splice(0, colItems.length);
			this.sCTValueHelp.destroyItems();
			var oList = this.getModel().bindList("/ScreeningCriteriaTemplate");
			oList.requestContexts(0, Infinity).then(function (aContexts) {
				aContexts.forEach(function (oContext) {
					var combutionType = oContext.getProperty("TYP_COMB");
					if (combutionType) {
						//alert("Before: "+combutionType);
						if(a.indexOf(combutionType) === -1) {
							a.push(combutionType);
						}
					}
				});
				alert("A.length: "+a.length);
				this.getModel().setProperty("/Countries", b);
				var listitem1 = new sap.ui.core.ListItem().bindProperty("text","Country");
				this.sCTValueHelp.bindList(a);
			});*/

		},

		onCTValueHelpClose: function (oEvent) {
			var oSelectedItem = oEvent.getParameter("selectedItem");
			if (!oSelectedItem) {
				return;
			}
			this.eventSource.setValue(oSelectedItem.getTitle());
		},

//------------------------------------------------------------------
//		Functions for Value Help Dialog of Combution Unit
//------------------------------------------------------------------

		onCUValueHelpRequest: function (oEvent) {	
			var sInputValue = oEvent.getSource().getValue();
			this.eventSource = oEvent.getSource();

			if (!this._pCUValueHelpDialog) {
				this._pCUValueHelpDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.CUValueHelpDialog",
				}).then(function(cuDialog) {
					return cuDialog;
				}.bind(this));
			}

			this._pCUValueHelpDialog.then(function(cuDialog) {
				cuDialog.open(sInputValue);
			});
		},

		onCUValueHelpSearch: function (oEvent) {
			var sCUValue = oEvent.getParameter("value");
			var oCUFilter = new sap.ui.model.Filter("VAL_DESCR", FilterOperator.EQ, sCUValue);

		},

		onCUValueHelpClose: function (oEvent) {
			var oSelectedItem = oEvent.getParameter("selectedItem");
			if (!oSelectedItem) {
				return;
			}
			this.eventSource.setValue(oSelectedItem.getTitle());
		},

//------------------------------------------------------------------
//		Functions for Value Help Dialog of plant type
//------------------------------------------------------------------

		onPNValueHelpRequest: function (oEvent) {	
			var sInputValue = oEvent.getSource().getValue();
			this.eventSource = oEvent.getSource();

			if (!this._pPNValueHelpDialog) {
				this._pPNValueHelpDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.PNValueHelpDialog",
				}).then(function(pnDialog) {
					return pnDialog;
				}.bind(this));
			}

			this._pPNValueHelpDialog.then(function(pnDialog) {
				pnDialog.open(sInputValue);
			});
		},

		onPNValueHelpSearch: function (oEvent) {
			var sPNValue = oEvent.getParameter("value");
			var oPNFilter = new sap.ui.model.Filter("VAL_DESCR", FilterOperator.EQ, sPNValue);

		},

		onPNValueHelpClose: function (oEvent) {
			var oSelectedItem = oEvent.getParameter("selectedItem");
			if (!oSelectedItem) {
				return;
			}
			this.eventSource.setValue(oSelectedItem.getTitle());
		},

//------------------------------------------------------------------
//		Functions for Value Help Dialog of combation range
//------------------------------------------------------------------

		onLCValueHelpRequest: function (oEvent) {	
			var sInputValue = oEvent.getSource().getValue();
			this.eventSource = oEvent.getSource();

			if (!this._pLCValueHelpDialog) {
				this._pLCValueHelpDialog = this.loadFragment({
					name: "eut.eutobjectsrv.view.LCValueHelpDialog",
				}).then(function(lcDialog) {
					return lcDialog;
				}.bind(this));
			}

			this._pLCValueHelpDialog.then(function(lcDialog) {
				lcDialog.open(sInputValue);
			});
		},

		onPNValueHelpSearch: function (oEvent) {
			var sLCValue = oEvent.getParameter("value");
			var oLCFilter = new sap.ui.model.Filter("VAL_DESCR", FilterOperator.EQ, sLCValue);

		},

		onLCValueHelpClose: function (oEvent) {
			var oSelectedItem = oEvent.getParameter("selectedItem");
			if (!oSelectedItem) {
				return;
			}
			this.eventSource.setValue(oSelectedItem.getTitle());

			this.sCriteriaTable = sap.ui.getCore().byId("idPOLTable");
			this.sCriteriaTable.setVisible(true);
		},

    }

    function _afterOpen(){
		var previousBtn = sap.ui.getCore().byId("previousbtn");
		var nextBtn = sap.ui.getCore().byId("nextbtn");
		var reviewBtn = sap.ui.getCore().byId("reviewbtn");
		var finishBtn = sap.ui.getCore().byId("finishbtn");
		var cancelBtn = sap.ui.getCore().byId("cancelbtn");	

		previousBtn.setVisible(false);
		nextBtn.setVisible(true);
		reviewBtn.setVisible(false);
		finishBtn.setVisible(false);
		cancelBtn.setVisible(true);

		/*this.oTable = sap.ui.getCore().byId("idCMTable");
		this.oFilter = new sap.ui.model.Filter("EUT_ACTIVITIES", sap.ui.model.FilterOperator.EQ, "2");
		this.oTable.getBinding("items").filter([this.oFilter]);*/

		this.sCriteriaForm = sap.ui.getCore().byId("PollutionPreventionForm");
		this.sCriteriaForm.setVisible(false);

		this.sCriteriaTable = sap.ui.getCore().byId("idPOLTable");
		this.sCriteriaTable.setVisible(false);
	}


    function _handleButtonsVisibility(indexStep) {
		var previousBtn = sap.ui.getCore().byId("previousbtn");
		var nextBtn = sap.ui.getCore().byId("nextbtn");
		var reviewBtn = sap.ui.getCore().byId("reviewbtn");
		var finishBtn = sap.ui.getCore().byId("finishbtn");

		switch (indexStep){
			case 0:
				previousBtn.setVisible(false);
				nextBtn.setVisible(true);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
			case 1:
				previousBtn.setVisible(true);
				nextBtn.setVisible(true);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
			case 2:
				previousBtn.setVisible(true);
				nextBtn.setVisible(true);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
			case 3:
				previousBtn.setVisible(true);
				nextBtn.setVisible(true);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
			case 4:
				previousBtn.setVisible(true);
				nextBtn.setVisible(true);
				reviewBtn.setVisible(false);
				finishBtn.setVisible(false);
				break;
            case 5:
                previousBtn.setVisible(true);
                nextBtn.setVisible(false);
                reviewBtn.setVisible(true);
                finishBtn.setVisible(false);
                break;
            case 6:
                previousBtn.setVisible(false);
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
					sap.ui.getCore().byId("wizardSCDialog").close();
				}
			}
		});
	}

})