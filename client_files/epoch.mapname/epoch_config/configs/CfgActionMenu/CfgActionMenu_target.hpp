

class CVFE_claimVehicle 
{
	condition = "dyna_isVehicle && !dyna_inVehicle && !dyna_locked && (local dyna_cursorTarget) && (dyna_cursorTarget getVariable['VEHICLE_SLOT','ABORT'] isEqualTo 'ABORT')";
	action = "[dyna_cursorTarget] call CVFE_fnc_claimVehicle_client";
	icon ="\x\addons\a3_epoch_assets_1\pictures\equip_key_CA_yellow.paa";
	toolTip = "Claim Vehicle";
};