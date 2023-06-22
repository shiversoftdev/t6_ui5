GetMenuCursor( menu )
{
	return Menu.ActiveMenu.CursorIndex;
}

SetMenuCursor( menu, value )
{
	Menu.ActiveMenu.CursorIndex = value;
	Menu.CursorIndexes[ Menu.CurrentMenu ] = value;
}

CreateDefaultHUD( struct )
{
	struct.L = spawnstruct();
	struct.R = spawnstruct();
	struct.M = spawnstruct();
	struct.L.MAXOPTIONS = 7; //Maybe change to 9 if possible
	struct.R.MAXOPTIONS = 5;
	struct.M.MAXOPTIONS = 5;
	struct.HAlign = -340;
	struct.VAlign = 10;
	struct.L.CursorIndex = 0;
	struct.R.CursorIndex = 0;
	struct.M.CursorIndex = 0;
	struct.L.open = false;
	struct.M.open = false;
	struct.R.open = false;
	struct.L.CursorViewIndex = 0;
	struct.M.CursorViewIndex = 0;
	struct.L.CurrentMenu = -1;
	struct.M.CurrentMenu = -1;
	struct.R.CurrentMenu = -1;
	
	struct.L.Font = "big";
	struct.L.Fontscale = 2;
	struct.L.OptionBuffer = 50;
	struct.L.ScrollBarShader = "white";
	struct.L.BackgroundShader = "gradient_center";
	struct.L.ScrollBarHeight = 30;
	struct.L.ScrollBarColor = (0,0,0);
	struct.L.TextColor = (1,1,1);
	struct.L.BackgroundColor = (0.055, 0.216, 0.439);
	struct.L.NextMenuAlign = 0;
	struct.L.BackgroundAlpha = .35;
	struct.L.SliderAlpha = .75;
	
	struct.R.Font = "default";
	struct.R.Fontscale = 1.5;
	struct.R.OptionBuffer = 25;
	struct.R.ScrollBarHeight = 32;
	struct.R.ScrollBarShader = "white";
	struct.R.ScrollBarColor = (0.055, 0.216, 0.439);
	struct.R.TextColor = (1,1,1);
	struct.R.BackgroundAlpha = 1;
	
	struct.M.Font = "default";
	struct.M.Fontscale = 1.5;
	struct.M.OptionBuffer = -1;
	struct.M.OptionBuffer = 30;
	struct.M.TitleColor = (1,1,1);
	struct.M.TextColor = (1,1,1);
	struct.M.ScrollBarColor = (0.055, 0.216, 0.439);
	struct.M.HStartAlign = 0;
	
	struct.L.NextMenu = struct.R;
	struct.R.NextMenu = struct.M;
	struct.M.NextMenu = struct.M;
	
	struct.M.MHistory = [];
	
	struct.ActiveMenu = struct.L;
	struct.L.EnterMenu = ::DrawLeft;
	struct.L.ExitMenu = ::ClearLeft;
	struct.L.Scroll = ::ScrollLeft;
	struct.R.EnterMenu = ::DrawRight;
	struct.R.ExitMenu = ::ClearRight;
	struct.R.Scroll = ::ScrollRight;
	struct.M.EnterMenu = ::DrawMiddle;
	struct.M.ExitMenu = ::ClearMiddle;
	struct.M.Scroll = ::ScrollMiddle;
	struct.CursorViewPositions = [];
	struct.CursorIndexes = [];
	struct.EnabledColor = (0,1,0);
	struct.L.UpdateCurrentOption = ::LUpdate;
	struct.R.UpdateCurrentOption = ::RUpdate;
	struct.M.UpdateCurrentOption = ::MUpdate;
	return struct;
}

CloseMenu()
{
	self HideMenu();
	Menu = self GetMenu();
	if(Menu.M.Open)
	{
		foreach(Text in Menu.M.Text)
		{
			text Destroy();
		}
		Menu.M.secretblack destroy();
		Menu.M.Open = false;
		Menu.M.CurrentMenu = -1;
	}
	if(Menu.R.Open)
	{
		foreach(Text in Menu.R.Text)
		{
			Text destroy();
		}
		Menu.R.ScrollBar destroy();
		Menu.R.Open = false;
		Menu.R.CurrentMenu = -1;
	}
	if(Menu.L.Open)
	{
		Menu.L.Open = false;
		foreach(Text in Menu.L.Text)
		{
			Text destroy();
		}
		Menu.L.ScrollBar destroy();
		Menu.L.background destroy();
		Menu.L.CurrentMenu = -1;
	}
	Menu.ActiveMenu = undefined;
}

HideMenu()
{
	Menu = self GetMenu();
	if(Menu.L.open)
	{
		self thread HideLeft();
	}
	if(Menu.R.open)
	{
		self thread HideRight();
	}
	if(Menu.M.open)
	{
		self thread HideMiddle();
	}
}

UpdateMenu( from_closed, overflow_fix )
{
	if( !isdefined(from_closed) )
		from_closed = false;
	Menu = self GetMenu();
	if(from_closed)
	{
		if(Menu.L.open)
		{
			self thread ShowLeft();
		}
		if(Menu.R.open)
		{
			self thread ShowRight();
		}
		if(Menu.M.open)
		{
			self thread ShowMiddle();
		}
		return;
	}
	if(!isdefined(Menu.ActiveMenu))
	{
		Menu.ActiveMenu = Menu.L;
	}
	if(Menu.ActiveMenu.CurrentMenu != -1 && Menu.CurrentMenu == GetBaseOptions()[ Menu.ActiveMenu.CurrentMenu ].ParentMenu)
	{
		self [[ Menu.ActiveMenu.ExitMenu ]]();
	}
	else
	{
		self [[ Menu.ActiveMenu.EnterMenu ]]();
	}
}

MenuScroll( direction )
{
	Menu = self GetMenu();
	if(!isdefined(Menu.ActiveMenu))
		Menu.ActiveMenu = Menu.L;
	self [[ Menu.ActiveMenu.Scroll ]]( direction );
}

WelcomeMessage()
{
	self iprintln("^2Welcome to the UI5 Menu Base");
}

