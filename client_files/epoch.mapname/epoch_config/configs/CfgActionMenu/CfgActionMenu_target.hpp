

class CVFE_claimVehicle 
{
	condition = "dyna_isVehicle && !dyna_inVehicle && !dyna_locked && (local dyna_cursorTarget) && (dyna_cursorTarget getVariable['VEHICLE_SLOT','ABORT'] isEqualTo 'ABORT')";
	action = "[dyna_cursorTarget] call CVFE_fnc_claimVehicle_client";
	icon =  "\A3\EditorPreviews_F_oldman\Data\CfgVehicles\Land_Key_01_F.jpg";
	toolTip = "Claim Vehicle";
};