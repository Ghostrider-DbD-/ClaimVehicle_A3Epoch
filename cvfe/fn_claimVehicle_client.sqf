/*
	CVFE_fnc_claimVehicle_client 

	Purpose: establish if vehicle can be claimed and if so do the claim 

	Parameters 
		_vehicle - the vehicle to be handled

	Returns
		None 

	By Ghostrider-GRG-
*/


params["_vehicle"];
private _missingItems = [];
try 
{
	/* Check if player has enough crypto */ 
	private _cost = getNumber(missionConfigFile >> "CfgCVFE" >> "claimCost");
	if (_cost > EPOCH_playerCrypto) throw 1;
	
	/* Check if this is a permenant vehicle */
	private _slot = _vehicle getVariable["VEHICLE_SLOT","ABORT"];
	if !(_slot isEqualTo "ABORT") throw 2;

	private _requiredItems = getArray(missionConfigFile >> "CfgCVFE" >> "requiredClaimComponents");
	diag_log format["_requiredItems = %1",_requiredItems];

	/* check for missing items */
	private _mags = magazines player;
	{
		_x params["_cn","_requiredCount"];
		private _avail = (magazines player) select {_x isEqualTo _cn};	
		private _availCount = count _avail;
		if (_availCount < _requiredCount) then 
		{
			_missingItems pushback[_cn,_requiredCount - _availCount];
		};
	} forEach _requiredItems;

	private _mi = format["_missingItems = %1",_missingItems];
	diag_log _mi;
	systemChat _mi;
	if !(_missingItems isEqualTo []) throw 3;

	[_vehicle,player] remoteExec ["CVFE_fnc_claimVehicle_server",2];
}

catch 
{
	switch (_exception) do 
	{
		case 1: {  //  Insufficient funds
			private _m = format["Insufficient Funds: %1 more crypto needed to store the vehicle",_cost - EPOCH_playerCrypto];
			systemChat _m;
			[_m, 5] call EPOCH_message;
		};
		case 2: {  // Already stored in the HIVE
			private _m = format["%1 is already a permenant vehicle",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")];
			systemChat _m;
			[_m, 5] call EPOCH_message;			
		};
		case 3: { // Lacking one or more required items
			private _error = "";
			{
				_x params["_cn","_count"];
				if (_error isEqualTo "") then 
				{
					_error = format["Missing Items Need to Claim Vehicle: %1 %2",_count,getText(configFile >> "CfgMagazines" >> _cn >> "displayName")];
				} else {
					_error = _error + format[", %1 %2",_count,getText(configFile >> "CfgMagazines" >> _cn >> "displayName")];
				};
			} forEach _missingItems;
			[_error,10] call EPOCH_message;
			systemChat _error;
		};
	};
};
