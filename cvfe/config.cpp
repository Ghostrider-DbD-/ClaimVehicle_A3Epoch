


class CfgPatches {
	class CVFE {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {
           // "epoch_server",
            //"a3_epoch_code"
        };
	};
};

class CfgBuild {
    class CVFE {
        build = 1;
        version = 0.1;
        date = "7-1-20";
    };
};

class CfgFunctions {
    class CVFE {
        class startUp {
            file="CVFE";
            class init {
                postInit = 1;
            };
        };
        class functions {
            file="CVFE";
            class claimVehicle_client {};
            class claimVehicle_server {};
        };
    };
};
