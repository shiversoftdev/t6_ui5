CreateOptions()
{
	CreateMain( "UI5 BASE" );
		AddSubMenu("Personal Menu", 1);
			AddSubMenu("Main Mods", 1);
				AddSubMenu("Menu Theme", 1);
					AddOption("Blue", ::MTheme, (0.055, 0.216, 0.439));
					AddOption("Red", ::MTheme, (0.737, .09, .09));
					AddOption("Green", ::MTheme, (0.188, 0.608, .114));
					AddOption("Yellow", ::MTheme, (0.839, 0.816, 0.224));
					AddOption("Purple", ::MTheme, (0.478, 0.059, 0.659));
					AddOption("Pink", ::MTheme, (1, 0, 0.749));
					AddOption("Orange", ::MTheme, (1, 0.620, 0.220));
					AddOption("Rainbow", ::SpecialTheme);
				EndSubMenu();
				AddOption("God Mode", ::DoGod);
				AddOption("Infinite Ammo", ::InfiniteAmmo);
				AddOption("Aimbot", ::Aimbot);
				AddOption("All Perks", ::AllPerks);
				AddOption("Crosshair Aimbot", ::CHairAimbot);
				AddOption("Bind No Clip", ::NoClip);
				AddOption("Double Speed", ::DoubleSpeed);
				AddOption("Suicide", ::Kys);
				AddOption("Test Option 10", ::Test);
			EndSubMenu();
			AddOption("Invisible", ::Invis);
			AddOption("Force Host", ::ForceHost);
			AddOption("Unlimited Game", ::UGame);
			AddOption("Exit Level", ::ExitGame);
			AddOption("Test Option 5", ::Test);
			AddOption("Test Option 6", ::Test);
			AddOption("Test Option 7", ::Test);
			AddOption("Test Option 8", ::Test);
			AddOption("Test Option 9", ::Test);
			AddOption("Test Option 10", ::Test);
		EndSubMenu();
		AddSubMenu("Submenu 2", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 3", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 4", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 5", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 6", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 7", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 8", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 9", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 10", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 11", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddSubMenu("Submenu 12", 1);
			AddSubMenu("Subsubmenu 1", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 2", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
			AddSubMenu("Subsubmenu 3", 1);
				AddOption("Test Option 1", ::Test);
				AddOption("Test Option 2", ::Test);
				AddOption("Test Option 3", ::Test);
			EndSubMenu();
		EndSubMenu();
		AddPlayersMenu( "Player Options", 3 );
			AddPlayerOption("Toggle God Mode", ::DoGod);
			AddPlayerOption("Infinite Ammo", ::InfiniteAmmo);
			AddPlayerOption("Kill Player", ::Kys);
			AddPlayerOption("Kick Player", ::KickEm);
			AddSubMenu("Verification", 3);
				AddPlayerOption("^1No Menu", ::VerifyMe, 0);
				AddPlayerOption("^2Verified", ::VerifyMe, 1);
				AddPlayerOption("^3Trusted", ::VerifyMe, 2);
				AddPlayerOption("^5Full Access", ::VerifyMe, 3);
			EndSubMenu();
		EndPlayersMenu();
	EndSubMenu();
}

ControlsMonitor()
{
	self notify("ControlsMonitor");
	self endon("ControlsMonitor");
	self endon("VerificationChange");
	self thread WelcomeMessage();
	Menu = self GetMenu();
	while( 1 )
	{
		if( !isAlive(self) && Menu.CurrentMenu != -1)
		{
			self HideMenu();
			while( !isAlive(self) )
				WaitMin();
			self UpdateMenu( true );
			self setempjammed( 1 );
		}
		if(Menu.CurrentMenu == -1 && self secondaryoffhandbuttonpressed() && self fragbuttonpressed())
		{
			Menu.CurrentMenu = 0;
			self UpdateMenu();
			self setempjammed( 1 );
			while( self secondaryoffhandbuttonpressed() && self fragbuttonpressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu == 0 && self MeleeButtonPressed())
		{
			Menu.CurrentMenu = -1;
			self UpdateMenu();
			while( self MeleeButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self ActionSlotOneButtonPressed() && !isdefined(Menu.ActiveMenu) || Menu.ActiveMenu != Menu.M)
		{
			self MenuScroll( -1 );
			while( self ActionSlotOneButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self ActionSlotTwoButtonPressed() && !isdefined(Menu.ActiveMenu) || Menu.ActiveMenu != Menu.M)
		{
			self MenuScroll( 1 );
			while( self ActionSlotTwoButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self ActionSlotThreeButtonPressed() && isdefined(Menu.ActiveMenu) && Menu.ActiveMenu == Menu.M )
		{
			self MenuScroll( -1 );
			while( self ActionSlotThreeButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self ActionSlotFourButtonPressed() && isdefined(Menu.ActiveMenu) && Menu.ActiveMenu == Menu.M )
		{
			self MenuScroll( 1 );
			while( self ActionSlotFourButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self JumpButtonPressed())
		{
			self PerformOption();
			while( self JumpButtonPressed() )
				WaitMin();
		}
		else if(Menu.CurrentMenu != -1 && self MeleeButtonPressed())
		{
			if(Menu.currentmenu == level.UI5_PLAYERS_MENU )
				Menu.selectedplayer = undefined;
			Menu.currentmenu = GetBaseOptions()[ Menu.CurrentMenu ].parentMenu;
			UpdateMenu();
			while( self MeleeButtonPressed() )
				WaitMin();
		}
		WaitMin();
	}
}

Test()
{
	self iprintln(self GetName());
	self EnableInvulnerability();
}

Test2()
{
	self iprintln("MENU2");
}



