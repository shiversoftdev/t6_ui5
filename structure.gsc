InitializeMenu()
{
	level.UI5 = spawnstruct();
	level.UI5.options = [];
	level.UI5.menus = [];
	level.UI5.vars = [];
	level.UI5_CURRENT_MENU = 0;
	level.UI5_NEXT_MENU = 0;
	level.UI5_PLAYERS_MENU = -2;
	level.UI5_PREVIOUS_MENUS = [];
	level.playercountinmenu = 0;
	CreateOptions();
	GetHost() GrantMenu( 4 );
}

SetCurrentBool( value, current, index, player )
{
	val = "";
	if(isdefined(player))
		val = (player GetName());
	level.ui5.vars[ self GetName() ][ val + "&" + current + "&" + index ] = value;
	self [[ (self GetMenu()).ActiveMenu.UpdateCurrentOption ]]( value );
}

GetCurrentBool( menu, index )
{
	val = "";
	if(isdefined( (self GetMenu()).selectedplayer ))
		val = ((self GetMenu()).selectedplayer GetName());
	return isdefined(level.ui5.vars[ self GetName() ][ val + "&" + menu + "&" + index ]) && level.ui5.vars[ self GetName() ][ val + "&" + menu + "&" + index ];
}

GetBase()
{
	return level.UI5;
}

GetOptions()
{
	return self.options;
}

GetBaseOptions()
{
	return level.UI5.options;
}

GetHost()
{
	foreach( player in level.players )
	{
		if(player IsHost())
			return player;
	}
	return undefined;
}

GrantMenu( access )
{
	if(isdefined( self GetMenu() ))
	{
		self DestroyMenu();
	}
	level.UI5.menus[ self getName() ] = self CreateMenu();
	(self GetMenu()).access = access;
	self thread ControlsMonitor();
}

GetMenu()
{
	return level.UI5.menus[ self getName() ];
}

DestroyMenu()
{
	self CloseMenu();
	(self GetMenu()) Delete();
}

CreateMenu()
{
	struct = spawnstruct();
	struct.access = -1;
	struct.currentmenu = -1;
	struct.selectedplayer = undefined;
	struct = CreateDefaultHUD( struct );
	return struct;
}

AddOption(title, function, arg1, arg2, arg3, arg4, arg5)
{
	parent = level.UI5.options[level.UI5_CURRENT_MENU];
	option = spawnstruct();
	option.function = function;
	option.title = title;
	option.arg1 = arg1;
	option.arg2 = arg2;
	option.arg3 = arg3;
	option.arg4 = arg4;
	option.arg5 = arg5;
	parent.options[ parent.options.size ] = option;
}

CreateMain( title )
{
	struct = spawnstruct();
	struct.options = [];
	struct.title = title;
	struct.parentmenu = -1;
	level.UI5.options[0] = struct;
}

AddSubMenu(title, access)
{
	level.UI5_NEXT_MENU++;
	
	level.UI5_PREVIOUS_MENUS[ level.UI5_PREVIOUS_MENUS.size ] = level.UI5_CURRENT_MENU;
	parent = level.UI5.options[level.UI5_CURRENT_MENU];
	option = spawnstruct();
	option.function = ::submenu;
	option.title = title;
	option.arg1 = level.UI5_NEXT_MENU;
	option.arg2 = access;
	parent.options[ parent.options.size ] = option;
	
	struct = spawnstruct();
	struct.options = [];
	struct.title = title;
	struct.parentmenu = level.UI5_CURRENT_MENU;
	level.UI5.options[ level.UI5_NEXT_MENU ] = struct;
	level.UI5_CURRENT_MENU = level.UI5_NEXT_MENU;
}

Submenu(child, access)
{
	Menu = self GetMenu();
	if(Menu.access < access)
		return;
	Menu.CursorIndexes[ Menu.CurrentMenu ] = Menu.ActiveMenu.CursorIndex;
	Menu.CursorViewPositions[ Menu.CurrentMenu ] = Menu.ActiveMenu.CursorViewIndex;
	
	Menu.currentMenu = child;
	Menu.ActiveMenu = Menu.ActiveMenu.NextMenu;
	
	if(Menu.currentMenu == level.UI5_PLAYERS_MENU)
		Menu.selectedPlayer = level.players[ self GetMenuCursor( Menu ) ];
	UpdateMenu();
}

EndSubMenu()
{
	if(level.UI5_PREVIOUS_MENUS.size < 1)
		return;
	level.UI5_CURRENT_MENU = level.UI5_PREVIOUS_MENUS[ level.UI5_PREVIOUS_MENUS.size - 1 ];
	level.UI5_PREVIOUS_MENUS[ level.UI5_PREVIOUS_MENUS.size - 1 ] = undefined;
}

EndPlayersSubMenu()
{
	level.UI5_NEXT_MENU--;
	EndSubMenu();
}

EndPlayersMenu()
{
	EndSubMenu();
	EndSubMenu();
}

AddPlayersMenu( title, access )
{
	AddSubMenu( title, access );
	level.UI5_PLAYERS_MENU = level.UI5_CURRENT_MENU;
	for(i=0;i<17;i++)
	{
		AddSubMenu("NULL", access);
		EndPlayersSubMenu();
	}
	AddSubMenu("PLAYER", access);
}

AddPlayerOption( title, function, arg1, arg2, arg3, arg4)
{
	AddOption(title, ::playerwrapperfunction, function, arg1, arg2, arg3, arg4);
}

PlayerWrapperFunction( function, arg1, arg2, arg3, arg4)
{
	Men = self getMenu();
	index = Men.activemenu.CursorIndex;
	current = Men.ActiveMenu.CurrentMenu;
	player = Men.selectedplayer;
	val = (player [[ function ]]( arg1, arg2, arg3, arg4));
	if(!isdefined(val))
	{
		self iprintlnbold("^5Success!");
	}
	else
	{
		SetCurrentBool( val, current, index, player );
	}
}

PerformOption()
{
	Men = self GetMenu();
	UIMenu = level.UI5.options[ Men.currentmenu ];
	if( Men.currentmenu == level.UI5_PLAYERS_MENU)
		Men.selectedplayer = level.players[ GetMenuCursor( Men ) ];
	UI_menu = UIMenu.options[ GetMenuCursor( Men ) ];
	if( !isdefined(UI_menu.function) )
		return;
	if(UI_menu.function == ::submenu)
	{
		self [[ UI_menu.function ]]( UI_menu.arg1, UI_menu.arg2, UI_menu.arg3, UI_menu.arg4, UI_menu.arg5 );
	}
	else
	{
		self thread PerformAndCapture(UI_menu.function, UI_menu.arg1, UI_menu.arg2, UI_menu.arg3, UI_menu.arg4, UI_menu.arg5 );
	}
}

PerformAndCapture( func, arg1, arg2, arg3, arg4, arg5 )
{
	index = (self GetMenu()).activemenu.CursorIndex;
	current = (self GetMenu()).ActiveMenu.CurrentMenu;
	val = self [[ func ]]( arg1, arg2, arg3, arg4, arg5 );
	if(isdefined(val))
	{
		SetCurrentBool( val, current, index );
	}
}


