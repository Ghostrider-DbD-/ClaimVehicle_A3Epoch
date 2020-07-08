/*
	CVFE_fnc_claimVehicle_server
	Copyright 2020
	By Ghostrider-GRG-
*/

params["_vehicle","_player"];

private _missingItems = [];
try {
	if (EPOCH_VehicleSlots isEqualTo []) throw 1;  // no free permenant vehicle slots available
	private _hasSlot = _vehicle getVariable["VEHICLE_SLOT", "ABORT"];
	if !(_hasSlot isEqualTo "ABORT") throw 2;

	private _requiredItems = getArray(missionConfigFile >> "CfgCVFE" >> "requiredClaimComponents");
	private _mags = magazines _player;
	
	/* remove required items from player inventory */
	{
		_x params["_cn","_count"];
		for "_i" from 0 to _count do 
		{
			player removeMagazine _cn;
		};
	} forEach _requiredItems;

	/* Deduct cost in crypto */
	private _claimCost = getNumber(missionConfigFile >> "CfgCVFE" >> "claimCost");
	[_player,(_claimCost * -1)] call EPOCH_server_effectCrypto;

	/* store the vehicle from the hive */
	/* code adapted from EPOCH Server scripts to load/save vehicles */
	/*
		https://github.com/EpochModTeam/Epoch
	*/
	// identify lock owner
	private _lockOwner = getPlayerUID _player;
	private _playerGroup = _player getVariable["GROUP", ""];
	if !(_playerGroup isEqualTo "") then {
		_lockOwner = _playerGroup;
	};

	private _slot = EPOCH_VehicleSlots deleteAt 0;
	missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];	

	// Set slot used by vehicle
	_vehicle setVariable["VEHICLE_SLOT", _slot, true];

	// SAVE VEHICLE
	_vehicle call EPOCH_server_save_vehicle;

	// Event Handlers
	_vehicle call EPOCH_server_vehicleInit;

	// save lock state information to the HIVE	
	private _lockState = locked _vehicle;
	private _locked = _lockState in [1,2,3];
	if (_locked && _lockOwner != "") then {
		private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
		["VehicleLock", _vehLockHiveKey, EPOCH_vehicleLockTime, [_lockOwner]] call EPOCH_fnc_server_hiveSETEX;
	} else {
		private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
		["VehicleLock", _vehLockHiveKey] call EPOCH_fnc_server_hiveDEL;
	};

	// Add to A3 remains collector
	addToRemainsCollector[_vehicle];	

	_vehicle allowDamage true;

	// new Dynamicsimulation
	if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
	{
		_vehicle enableSimulationGlobal false; // turn it off until activated by dynamicSim
		_vehicle enableDynamicSimulation true;
	};		

	/* Notify Player the Claim operation was successful */
	private _displayName = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
	private _m = format["%1 has been claimed",_displayName];
	diag_log format["CVFE: Vehicle %1 has been clamed by player %2 for a cost of %3",_vehicle,_player,_claimCost];
	[_m] remoteExec["systemChat",owner _player];
	[_m,5] remoteExec["EPOCH_Message",owner _player];	
	diag_log _m;	
}

catch {
	switch (_exception) do {
		case 1: {  // Insufficient free vehicle slots in EPOCH
			private _error = format["ERROR: Insufficient free vehicle slots to claim the vehicle: contact your server owner",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")];
			[_error] remoteExec["systemChat",(owner _player)];
			[_error,5] remoteExec["EPOCH_Message",(owner _player)];
			[_error] remoteExec["diag_log",(owner _player)];
		};
		case 2: {  // Already a permenant EPOCH vehicle.
			private _error = format["ERROR: This %1 is already a permenant vehicle",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")];
			[_error] remoteExec["systemChat",(owner _player)];
			[_error,5] remoteExec["EPOCH_Message",(owner _player)];
			[_error] remoteExec["diag_log",(owner _player)];
		};
	}
};
