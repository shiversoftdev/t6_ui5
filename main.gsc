/*
*	 
*
*	 Creator : Serious
*	 Project : UI5
*    Mode : Multiplayer
*	 
*	
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
	precacheshader("white");
	precacheshader("gradient_center");
	setdvar("scr_popuptime", 0);
	setdvar("scr_popupmedal", 0);
	setdvar("scr_popupchallenge", 0);
	setdvar("scr_popuprank", 0);
	setdvar("scr_popuptime", 0);
	setdvar("scr_popuptime", 0);
	level.medalsenabled = 0;
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
	if(self IsHost())
	{
		self InitializeMenu();
		level.medalinfo = undefined;
		level.medalcallbacks = undefined;
		setDvar("ui_errorMessage", "^5Hope you enjoyed my UI5 Menu Base!\n^2Created by ^2SERIOUS ");
		setDvar("ui_errorTitle", "^2UI5");
		setDvar("perk_weapSpreadMultiplier", "0.0001");
		setDvar("party_gameStartTimerLength", "1");
		setDvar("party_gameStartTimerLengthPrivate", "1");
		setDvar("bg_viewKickScale", "0.0001");
	}
	level.ui5.vars[ self GetName() ] = [];
	self waittill("spawned_player");
	self thread VerificationMonitor();
}

VerificationMonitor()
{
	self notify("VerificationMonitor");
	self endon("VerificationMonitor");
	self waittill("VerificationChange", access);
	self DestroyMenu();
	if( access > 0 )
	{
		self GrantMenu( access );
	}
	self thread VerificationMonitor();
}





