DrawLeft( overflow_fix )
{
	if(isdefined(overflow_fix) && overflow_fix)
	{
		self AssignLeftStrings();
		return;
	}
	self setclientuivisibilityflag( "hud_visible", 0 );
	setmatchflag( "final_killcam", 1 );
	level.playercountinmenu++;
	self freezecontrols( false );
	Menu = self GetMenu();
	Active = Menu.L;
	Active.currentMenu = Menu.CurrentMenu;
	Active.open = true;
	MAX = Menu.L.MAXOPTIONS;
	Active.Text = [];
	Active.strings = [];
	Active.CursorIndex = 0;
	Active.CursorViewIndex = 0;
	setDvar("con_gameMsgWindow0MsgTime", "0");     
	setDvar("con_gameMsgWindow0LineCount", "0");
	self SetMenuCursor( Menu, 0 );
	self unsetperk("specialty_immuneemp");
	self.mfreeze = spawn("script_model", self.origin);
	self.mfreeze SetModel("tag_origin");
	self.mfreeze.angles = self GetPlayerAngles();
	self linkto( self.mfreeze );
	self disableweapons();
	self setempjammed( 1 );
	self thread WhileOpenClearMedals();
	for(i = 0; i < MAX; i++)
	{
		Active.Text[ i ] = self drawText("", Active.Font, Active.Fontscale, "LEFT", "TOP", Menu.HAlign - 200, Menu.VAlign + (i * Active.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 3, false);
		if( GetCurrentBool( Active.CurrentMenu, i) )
			Active.Text[ i ].color = Menu.EnabledColor;
	}

	self AssignLeftStrings();

	Active.ScrollBar = self createShader(Active.ScrollBarShader, "LEFT", "TOP", (Menu.HAlign - 90) - 400, Menu.VAlign + (Active.CursorViewIndex * Active.OptionBuffer), 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight, Active.ScrollBarColor, 0, 2);
	Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
	Active.Background = self createShader(Active.BackgroundShader, "CENTER", "CENTER", 0, 0, 940, 480, Active.BackgroundColor, 0, 0);
	foreach(text in Active.Text)
	{
		text MoveOverTime(.25);
		text FadeOverTime(.25);
		text.alpha = .4;
		text.x += 200;
	}
	Active.ScrollBar MoveOverTime(.25);
	Active.ScrollBar FadeOverTime(.25);
	Active.ScrollBar.alpha = Active.SliderAlpha;
	Active.ScrollBar.x  += 400;
	Active.Background FadeOverTime(.25);
	Active.Background.alpha = Active.BackgroundAlpha;
	self setblur( 2, .25 );
	wait .25;
	Active.Text[ Active.CursorViewIndex ].alpha = 1; //might be a bit snappy, fix potentially? i .... if(i == ...)
}

ClearLeft()
{
	Menu = self GetMenu();
	self setperk("specialty_immuneemp");
	setDvar("con_gameMsgWindow0MsgTime", "5");     
	setDvar("con_gameMsgWindow0LineCount", "5");
	level.playercountinmenu--;
	if(!level.playercountinmenu)
		setmatchflag( "final_killcam", 0 );
	foreach( text in Menu.L.Text )
	{
		text MoveOverTime( .25 );
		text FadeOverTime( .25 );
		text.alpa = 0;
		text.Y -= 480; //Force off screen
	}
	Menu.L.ScrollBar MoveOverTime( .25 );
	Menu.L.ScrollBar FadeOverTime( .25 );
	Menu.L.ScrollBar.alpha = 0;
	Menu.L.ScrollBar.Y -= 480;
	Menu.L.Background fadeovertime( .25 );
	Menu.L.Background.alpha = 0;
	self setblur( 0, .25);
	self Unlink();
	self.mfreeze delete();
	self enableweapons();
	self setempjammed( 0 );	
	wait .25;
	for( i = 0; i < Menu.L.Text.size; i++ )
	{
		Menu.L.Text[ i ] Destroy();
	}
	Menu.L.CurrentMenu = -1;
	Menu.L.Background Destroy();
	Menu.L.ScrollBar Destroy();
	Menu.L.open = false;
	self setclientuivisibilityflag( "hud_visible", 1 );
}

ScrollLeft( direction )
{
	Menu = self GetMenu();
	Active = Menu.L;
	Options = GetBaseOptions()[ Menu.L.CurrentMenu ].options;
	if(Options.size < 2)
		return;
	MAX = Active.MAXOPTIONS;
	Slider = Active.ScrollBar;
	ShouldAlterList = false;
	MIDDLE = Int( MAX / 2 );
	if(direction > 0 && (Active.CursorViewIndex == MIDDLE) && ((Active.CursorIndex + MIDDLE + 1) < Options.size))
		ShouldAlterList = true;
	else if(direction < 0 && (Active.CursorViewIndex == MIDDLE) && ((Active.CursorIndex - MIDDLE) > 0 ))
		ShouldAlterList = true;	
	SIZE = Min( MAX, options.size );
	if(ShouldAlterList)
	{
		Active.CursorIndex += direction;
		if(direction > 0)
		{
			foreach(Text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text.y -= Active.OptionBuffer;
			}
			Active.Text[0] FadeOverTime( .15 );
			Active.Text[0].alpha = 0;
			Active.Text[ Active.CursorViewIndex ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex ].alpha = .4;
			Active.Text[ Active.CursorViewIndex + 1 ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex + 1 ].alpha = 1;
			NewText = [];
			NewStrings = [];
			for( i = 1; i < SIZE; i++)
			{
				NewText[ i - 1 ] = Active.Text[ i ];
			}
			for( i = 1; i < SIZE; i++ )
			{
				NewStrings[ i - 1 ] = Active.strings[ i ];
			}
			NewElem = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign, Menu.VAlign + (MAX * Active.OptionBuffer ), Active.TextColor, 0, (0,0,0), 0, 3, false);
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex + MIDDLE ))
				NewElem.color = Menu.EnabledColor;
			NewElem SetSafeText( Options[ Active.CursorIndex + MIDDLE ].Title );
			NewElem MoveOverTime( .15 );
			NewElem FadeOverTime( .15 );
			NewElem.alpha = .4;
			NewElem.Y -= Active.OptionBuffer;
			NewStrings[ NewStrings.size ] = Options[ Active.CursorIndex + MIDDLE ].Title;
			NewText[ NewText.size ] = NewElem;
			Active.strings = NewStrings;
			Slider ScaleOverTime(.2, 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight);
			Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
			wait .15;
			Active.Text[0] Destroy();
			Active.Text = NewText;
		}
		else
		{
			foreach(Text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text.y += Active.OptionBuffer;
			}
			Active.Text[ Active.Text.size - 1 ] FadeOverTime( .15 );
			Active.Text[ Active.Text.size - 1 ].alpha = 0;
			Active.Text[ Active.CursorViewIndex ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex ].alpha = .4;
			Active.Text[ Active.CursorViewIndex - 1 ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex - 1 ].alpha = 1;
			NewText = [];
			NewStrings = [];
			NewElem = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign, Menu.VAlign + (-1 * Active.OptionBuffer ), Active.TextColor, 0, (0,0,0), 0, 3, false);
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex - MIDDLE ))
				NewElem.color = Menu.EnabledColor;
			NewElem SetSafeText( Options[ Active.CursorIndex - MIDDLE].Title );
			NewElem MoveOverTime( .15 );
			NewElem FadeOverTime( .15 );
			NewElem.alpha = .4;
			NewElem.Y += Active.OptionBuffer;
			NewStrings[ NewStrings.size ] = Options[ Active.CursorIndex - MIDDLE ].Title;
			NewText[ 0 ] = NewElem;
			for( i = 1; i < SIZE; i++)
			{
				NewText[ i ] = Active.Text[ i - 1 ];
			}
			for( i = 1; i < SIZE; i++)
			{
				NewStrings[ i ] = Active.strings[ i - 1 ];
			}
			Active.strings = NewStrings;
			Slider ScaleOverTime(.2, 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight);
			Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
			wait .15;
			Active.Text[ Active.Text.size - 1] Destroy();
			Active.Text = NewText;
		}
	}
	else if( ((direction + Active.CursorViewIndex) >= MAX) || ((direction + Active.CursorViewIndex) >= Options.size) )
	{
		Slider MoveOverTime( .4 );
		Texts = Active.Text;
		Slider.Y = Menu.VAlign;
		Active.CursorViewIndex = 0;
		Active.CursorIndex = 0;
		foreach(xtext in Texts)
		{
			xtext MoveOverTime( .2 );
			xtext FadeOverTime( .2 );
			xtext.alpha = 0;
			xtext.y += 500;
		}
		wait .2;
		foreach(xtext in Texts)
		{
			xtext.y -= 1000;
		}
		self AssignLeftStrings();
		Slider ScaleOverTime(.2, 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight);
		Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
		for(i = 0; i < Texts.size; i++)
		{
			if(GetCurrentBool( Active.CurrentMenu, i ))
				Texts[i].color = Menu.EnabledColor;
			else
				Texts[i].color = Menu.ActiveMenu.TextColor;
		}
		foreach(text in Active.Text)
		{
			text MoveOverTime( .2 );
			text FadeOverTime( .2 );
			text.alpha = .4;
			text.y += 500;
		}
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		wait .2;
	}
	else if( ((direction + Active.CursorViewIndex) < 0) )
	{
		Slider MoveOverTime( .4 );
		Texts = Active.Text;
		Active.CursorViewIndex = MAX - 1;
		if(MAX > Options.size)
			Active.CursorViewIndex = Options.size - 1;
		Slider.Y = Menu.VAlign + ( Active.CursorViewIndex * Active.OptionBuffer );	
		Active.CursorIndex = Options.size - 1;
		foreach(xtext in Texts)
		{
			xtext MoveOverTime( .2 );
			xtext FadeOverTime( .2 );
			xtext.alpha = 0;
			xtext.y -= 500;
		}
		wait .2;
		foreach(xtext in Texts)
		{
			xtext.y += 1000;
		}
		self AssignLeftStrings();
		for(i = 0; i < Texts.size; i++)
		{
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex - i ))
				Texts[i].color = Menu.EnabledColor;
			else
				Texts[i].color = Menu.ActiveMenu.TextColor;
		}
		Slider ScaleOverTime(.2, 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight);
		Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
		foreach(text in Active.Text)
		{
			text MoveOverTime( .2 );
			text FadeOverTime( .2 );
			text.alpha = .4;
			text.y -= 500;
		}
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		wait .2;
	}
	else
	{
		Slider MoveOverTime(.15);
		Slider.y += direction * Active.OptionBuffer;
		Active.Text[ Active.CursorViewIndex ] fadeovertime( .15 );
		Active.Text[ Active.CursorViewIndex ].alpha = .4;
		Active.CursorViewIndex += direction;
		Active.CursorIndex += direction;
		Active.Text[ Active.CursorViewIndex ] fadeovertime( .15 );
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		Slider ScaleOverTime(.15, 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight);
		Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
		wait .15;
		
	}
}

AssignLeftStrings()
{
	Menu = self GetMenu();
	Active = Menu.L;
	options = GetBaseOptions()[ Menu.L.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	j = (Active.CursorIndex + 1) - MAX;
	if( j < 0 )
		j = 0;
	for( i = 0; i < MAX; i++)
	{
		if( j >= options.size )
			break;
		Active.Text[ i ] SetSafeText( options[ j ].Title );
		Active.strings[ i ] = options[ j ].Title;
		j++;
	}
	if( i != MAX )
	{
		while( i < MAX )
		{
			Active.Text[ i ] SetSafeText("");
			Active.strings[ i ] = "";
			i++;
		}
	}
}

HideLeft()
{
	elem = (self GetMenu()).L;
	foreach(text in elem.Text)
	{
		text fadeovertime( .15 );
		text.alpha = 0;
	}
	elem.ScrollBar fadeovertime( .15 );
	elem.ScrollBar.alpha = 0;
	elem.Background fadeovertime( .15 );
	elem.Background.alpha = 0;
	self SetBlur( 0, .15);
	self Unlink();
	self.mfreeze delete();
	self enableweapons();
	self setempjammed( 0 );	
}

ShowLeft()
{
	elem = (self GetMenu()).L;
	foreach(text in elem.Text)
	{
		text fadeovertime( .15 );
		text.alpha = .4;
	}
	if(elem.text.size > elem.CursorViewIndex)
		elem.text[ elem.CursorViewIndex ].alpha = 1;
	elem.ScrollBar fadeovertime( .15 );
	if((self GetMenu()).R.open)
		elem.ScrollBar.alpha = 1;
	else
		elem.ScrollBar.alpha = elem.SliderAlpha;
	elem.Background fadeovertime( .15 );
	elem.Background.alpha = elem.BackgroundAlpha;
	self.mfreeze = spawn("script_model", self.origin);
	self.mfreeze SetModel("tag_origin");
	self.mfreeze.angles = self GetPlayerAngles();
	self linkto( self.mfreeze );
	self disableweapons();
	self setempjammed( 1 );
}

WhileOpenClearMedals()
{
	self notify("WhileOpenClearMedals");
	self endon("WhileOpenClearMedals");
	Menu = self GetMenu();
	while(menu.l.open)
	{
		self.notifytitle.alpha = 0;
		self.notifytext.alpha = 0;
		self.notifyicon.alpha = 0;
		self.doingnotify = 0;
		WaitMin();
	}
}

LUpdate( value )
{
	Menu = (self GetMenu());
	if(value)
	{
		Menu.ActiveMenu.Text[ Menu.ActiveMenu.CursorViewIndex ] fadeovertime( .15 );
		Menu.ActiveMenu.Text[ Menu.ActiveMenu.CursorViewIndex ].color = Menu.EnabledColor;
	}
	else
	{
		Menu.ActiveMenu.Text[ Menu.ActiveMenu.CursorViewIndex ] fadeovertime( .15 );
		Menu.ActiveMenu.Text[ Menu.ActiveMenu.CursorViewIndex ].color = Menu.ActiveMenu.TextColor;
	}
}
