/*
	CVFE_fnc_init 

	Purpose: Initialize the mod including adding an event handler to broadcast code when players join a server.

	By Ghostrider-GRG- 
*/


/* set up the onPlayerConnected EH here */
onPlayerConnected {}; // seems this is needed or addMissionEventHandler "PlayerConnected" does not work. as of A3 1.60
addMissionEventHandler ["PlayerConnected", 
{
    params["_id","_uid","_name","_jip","_owner"];
	_owner publicVariableClient "CVFE_fnc_claimVehicle_client";
	diag_log format["broadcasting variable CVFE_fnc_claimVehicle_client to player %1",_name];
}];

private _build = getText(configFile >> "CfgBuild" >> "CVFE" >> "build");
private _ver = getText(configFile >> "CfgBuild" >> "CVFE" >> "version");
private _builddate = getText(configFile >> "CfgBuild" >> "CVFE" >> "date");

diag_log format["CVFE: Claim Vehicles for Epoch Version %1 Build %2 Build Date %3 Loaded",_ver,_build,_builddate];
