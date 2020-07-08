
SERVER
1. Pack @CVFE\addons\cvfe
2. Copy @CVFE to the root folder for your arma 3 server (where @epochhive is also located) and add @cvfe to "-servermod="  OR copy @CVFE\addons\cvfe.pbo into your @epoochhive\addons folder.
3. Merge the contents of remoteExec.txt with \SC\battleye\remoteExec.txt 

CLIENT
1. Unpack your mission.pbo, named epoch.Altis or the analogous name for your map.
2. copy the addons folder from the client_files folder into the epoch.Altis folder. If one already exists, this will automatically merge the contents of the two folders.
3. Merge the contents of CfgRemoteExec.hpp into epoch_config\configs\CfgRemoteExec.hpp in you epoch.Altis folder.
4. Merge the contents of description.ext in the client_files folder with description.ext in your epoch.Altis folder.
5. Merge the contents of epoch_config\configs\CfgActionMenu\CfgActionMenu_target.hpp with the corresponding file in your missio folder.
6. Edit the parameters in addons\CVFE\CfgCVFE.hpp to suit your desires.
7. Repbo the mission folder, add it to your server and you should be good to go.

