/*
	CVFE_fnc_init
	Copyright 2020
	By Ghostrider-GRG-
*/

/* set up the onPlayerConnected EH here */
onPlayerConnected {}; // seems this is needed or addMissionEventHandler "PlayerConnected" does not work. as of A3 1.60
addMissionEventHandler ["PlayerConnected", 
{
    params["_id","_uid","_name","_jip","_owner"];
	_owner publicVariableClient "CVFE_fnc_claimVehicle_client";
}];

private _build = getText(configFile >> "CfgBuild" >> "CVFE" >> "build");
private _ver = getText(configFile >> "CfgBuild" >> "CVFE" >> "version");
private _builddate = getText(configFile >> "CfgBuild" >> "CVFE" >> "date");

diag_log format["CVFE: Claim Vehicles for Epoch Version %1 Build %2 Build Date %3 Loaded",_ver,_build,_builddate];
