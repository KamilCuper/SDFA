sap.ui.define(
    ["sap/fe/core/AppComponent",
    'sap/m/MessageToast',
    'sap/ui/core/mvc/Controller'],
    function (Component, MessageToast, Controller) {
        "use strict";

        return Component.extend("ns.financialinput.Component", {
            metadata: {
                manifest: "json"
            }
        });
    }
);