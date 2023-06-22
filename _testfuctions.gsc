DoGod()
{
	self.god = Toggle( self.god );
	if(self.god)
	{
		self EnableInvulnerability();
	}
	else
	{
		self DisableInvulnerability();
	}
	return self.god;
}

VerifyMe( verification )
{
	self iprintln("^3Your verification level has been set to ^5" + verification);
	self notify("VerificationChange", verification);
}

InfiniteAmmo()
{
	self.iammo = Toggle( self.iammo );
	self thread AmmoThread();
	return self.iammo;
}

AmmoThread()
{
	while(self.iammo)
	{
		weapon = self getcurrentweapon();
		if(weapon != "none")
		{
			self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
			self giveMaxAmmo(weapon);
		}
		if(self getCurrentOffHand() != "none")
			self giveMaxAmmo(self getCurrentOffHand());
		self waittill_any("weapon_fired", "grenade_fire", "missile_fire");
	}
}

Aimbot()
{
	self.aimbot = Toggle( self.aimbot );
	self thread AimbotThread();
	return self.aimbot;
}

AimbotThread()
{
	aimat = undefined;
	while( self.aimbot )
	{
		while( !isAlive( self  ) )
			wait 1;
		while( self adsButtonPressed() )
		{
			aimAt = undefined;
			foreach(player in level.players)
			{
				if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
					continue;
				if(isDefined(aimAt))
				{
					if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
						aimAt = player;
				}
				else aimAt = player; 
			}
			if(isDefined(aimAt)) 
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
				if(self attackbuttonpressed())
					aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
			}
			WaitMin();
		}
		WaitMin();
	}
}

CHairAimbot()
{
	self.chairaimbot = Toggle( self.chairaimbot );
	self thread CHairAimbotThread();
	return self.chairaimbot;
}

CHairAimbotThread()
{
	while( self.chairaimbot )
	{
		self waittill("weapon_fired", weapon);
		if(!self.chairaimbot)
			return;
		enemy = undefined;
		ValidTargets = array_copy( level.players );
		arrayremovevalue(ValidTargets, self);
		foreach( player in level.players )
		{
			if( level.teambased && player.pers["team"] == self.pers["team"] )
				arrayremovevalue(ValidTargets, player );
			if( player == self )
				continue;
			if( !SightTracePassed( self GetEye(), player gettagorigin("j_head"), 0, self ) || !isAlive( player ) )
				arrayremovevalue(ValidTargets, player );
			angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
			if( angles > 17.5 && angles >= 0 )
				arrayremovevalue(ValidTargets, player );
			if( angles < -17.5 )
				arrayremovevalue(ValidTargets, player );
		}
		angles = undefined;
		if( ValidTargets.size < 1 )
			continue;
		foreach( target in ValidTargets )
		{
			if( !IsDefined(angles) )
			{
				enemy = target;
				angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
				continue;
			}
			if( Abs( angles ) > Abs((VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1]) ) )
			{
				enemy = target;
				angles = VectorToAngles( (player Getorigin()) - (self Getorigin()) )[1] - (self GetPlayerAngles())[1];
			}
		}
		ValidTargets = [];
		magicbullet( weapon, self GetEye(), enemy gettagorigin("j_head"), self );
	}
}

AllPerks()
{
	self.allperks = Toggle( self.allperks );
	perks = strtok("specialty_additionalprimaryweapon,specialty_armorpiercing,specialty_armorvest,specialty_bulletaccuracy,specialty_bulletdamage,specialty_bulletflinch,specialty_bulletpenetration,specialty_deadshot,specialty_delayexplosive,specialty_detectexplosive,specialty_disarmexplosive,specialty_earnmoremomentum,specialty_explosivedamage,specialty_extraammo,specialty_fallheight,specialty_fastads,specialty_fastequipmentuse,specialty_fastladderclimb,specialty_fastmantle,specialty_fastmeleerecovery,specialty_fastreload,specialty_fasttoss,specialty_fastweaponswitch,specialty_finalstand,specialty_fireproof,specialty_flakjacket,specialty_flashprotection,specialty_gpsjammer,specialty_grenadepulldeath,specialty_healthregen,specialty_holdbreath,specialty_immunecounteruav,specialty_immuneemp,specialty_immunemms,specialty_immunenvthermal,specialty_immunerangefinder,specialty_killstreak,specialty_longersprint,specialty_loudenemies,specialty_marksman,specialty_movefaster,specialty_nomotionsensor,specialty_noname,specialty_nottargetedbyairsupport,specialty_nokillstreakreticle,specialty_nottargettedbysentry,specialty_pin_back,specialty_pistoldeath,specialty_proximityprotection,specialty_quickrevive,specialty_quieter,specialty_reconnaissance,specialty_rof,specialty_scavenger,specialty_showenemyequipment,specialty_stunprotection,specialty_shellshock,specialty_sprintrecovery,specialty_showonradar,specialty_stalker,specialty_twogrenades,specialty_twoprimaries,specialty_unlimitedsprint", ",");
	foreach( perk in perks )
		if( self.allperks )
			self setperk( perk );
		else
			self unsetperk( perk );
	return self.allperks;
}

NoClip()
{
	self.noclip = Toggle(self.noclip);
	self thread NCThread();
	return self.noclip;
}

NCThread()
{
	self iprintlnbold("^5Press [{+frag}] ^3to ^5Toggle No Clip");
	normalized = undefined;
	scaled = undefined;
	originpos = undefined;
	self unlink();
	self.originObj delete();
	while( self.noclip )
	{
		if( self fragbuttonpressed())
		{
			self.originObj = spawn( "script_origin", self.origin, 1 );
    		self.originObj.angles = self.angles;
			self playerlinkto( self.originObj, undefined );
			while( self fragbuttonpressed() )
				wait .1;
			self iprintlnbold("No Clip Enabled");
			self enableweapons();
			while( self.noclip )
			{
				if( self fragbuttonpressed() )
					break;
				if( self SprintButtonPressed() )
				{
					normalized = anglesToForward( self getPlayerAngles() );
					scaled = vectorScale( normalized, 60 );
					originpos = self.origin + scaled;
					self.originObj.origin = originpos;
				}
				wait .05;
			}
			self unlink();
			self.originObj delete();
			self iprintlnbold("No Clip Disabled");
			while( self fragbuttonpressed() )
				wait .1;
		}
		wait .1;
	}
}

DoubleSpeed()
{
	self.doublespeed = Toggle( self.doublespeed );
	self setMoveSpeedScale( 1 + self.doublespeed );
	return self.doublespeed;
}

Kys()
{
	self DisableInvulnerability();
	self suicide();
	self iprintlnbold("^6Mistakes were made!");
}

ExitGame()
{
	Exitlevel(1);
}

KickEm()
{
	kick(self GetEntityNumber());
}

Invis()
{
	self.invis = Toggle( self.invis );
	if(self.invis)
		self hide();
	else
		self show();
	return self.invis;
}

ForceHost()
{
	self.fh = toggle(self.fh);
	if( self.fh )
	{
		setDvar("party_connectToOthers" , "0");
		setDvar("partyMigrate_disabled" , "1");
		setDvar("party_mergingEnabled" , "0");
	}
	else
	{
		setDvar("party_connectToOthers" , "1");
		setDvar("partyMigrate_disabled" , "0");
		setDvar("party_mergingEnabled" , "1");
	}
	return self.fh;
}

UGame()
{
	self.ugame = toggle(self.ugame);
	if( self.ugame  )
	{
		maps\mp\gametypes\_globallogic_utils::pausetimer();
		setDvar("scr_" + level.gametype + "_scorelimit",0);
		setDvar("scr_" + level.gametype + "_numlives",0);
		setDvar("scr_player_forcerespawn",1);
	}
	else
	{
		maps\mp\gametypes\_globallogic_utils::resumetimer();
		setDvar("scr_" + level.gametype + "_scorelimit",100);
		if( level.gametype == "sd" )
			setDvar("scr_" + level.gametype + "_numlives",1);
		setDvar("scr_player_forcerespawn",1);
	}
	return self.ugame;
}
