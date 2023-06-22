DrawRight( overflow_fix )
{
	if(isdefined(overflow_fix) && overflow_fix)
	{
		self AssignRightStrings();
		return;
	}
	Menu = self GetMenu();
	self setempjammed( 1 );
	Active = Menu.R;
	Menu.R.open = true;
	Active.CursorIndex = 0;
	Active.currentMenu = Menu.CurrentMenu;
	Menu.L.Text[ Menu.L.CursorViewIndex ] fadeovertime( .25 );
	Menu.L.Text[ Menu.L.CursorViewIndex ].color = Active.ScrollBarColor;
	Menu.L.ScrollBar fadeovertime( .15 );
	Menu.L.ScrollBar.alpha = 1;
	Active.Text = [];
	Active.ScrollBar = self createShader(Active.ScrollBarShader, "LEFT", "TOP", (Menu.HAlign - 90), Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer), 1, Active.ScrollBarHeight, Active.ScrollBarColor, Active.BackgroundAlpha, 1);
	
	for( i = 0; i < Active.MAXOPTIONS; i++)
	{
		Active.Text[ i ] = drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 2, false);
		if(GetCurrentBool(Active.CurrentMenu, i))
			Active.Text[ i ].color = Menu.EnabledColor;
	}
	
	self AssignRightStrings();
	Active.ScrollBar ScaleOverTime( .25, (90 + Menu.L.NextMenuAlign + GetStringSize(Active.strings[ Active.CursorIndex ], Active.Fontscale) + 15), Active.ScrollBarHeight);
	
	for( i = 0; i < Active.MAXOPTIONS; i++ )
	{
		Active.Text[ i ] MoveOverTime( .25 );
		Active.Text[ i ] fadeovertime( .25 );
		Active.Text[ i ].alpha = .3;
		Active.Text[ i ].y += (Active.OptionBuffer * i);
	}
	wait .25;
	Active.Text[ 0 ].alpha = 1;
}

ClearRight()
{
	Menu = self GetMenu();
	Active = Menu.R;
	Menu.R.open = false;
	for( i = 1; i < Active.Text.size; i++ )
	{
		Active.Text[ i ] fadeovertime( .15 );
		Active.Text[ i ] moveovertime( .2 );
		Active.Text[ i ].y -= (i * Active.OptionBuffer);
		Active.Text[ i ].alpha = 0;
	}
	wait .2;
	Active.ScrollBar ScaleOverTime( .1, 0, Active.ScrollBarHeight );
	Menu.L.Text[ Menu.L.CursorViewIndex ] fadeovertime( .2 );
	Menu.L.Text[ Menu.L.CursorViewIndex ].color = Menu.L.TextColor;
	Menu.L.ScrollBar fadeovertime( .1 );
	Menu.L.ScrollBar.alpha = Menu.L.SliderAlpha;
	wait .1;
	Active.Text[ 0 ] moveovertime( .1 );
	Active.Text[ 0 ].x -= 300;
	foreach(Text in Active.Text)
	{
		Text Destroy();
	}
	Active.ScrollBar Destroy();
	Active.CurrentMenu = -1;
	Menu.ActiveMenu = Menu.L;
}

ScrollRight( direction )
{
	Menu = self GetMenu();
	Active = Menu.R;
	Options = GetBaseOptions()[ Menu.R.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	Slider = Active.ScrollBar;
	if( Options.size < 2 )
		return;
	if( Menu.R.CurrentMenu == level.UI5_PLAYERS_MENU && level.players.size < 2 )
		return;
	if(direction < 0)
	{
		if((Active.CursorIndex + direction) < 0)
		{
			if(Menu.R.CurrentMenu != level.UI5_PLAYERS_MENU)
			{
				Active.CursorIndex = Options.size - 1;
				NewText = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer) - Active.OptionBuffer, Active.TextColor, 0, (0,0,0), 0, 2, false);
				if(GetCurrentBool(Active.CurrentMenu, Active.CursorIndex))
					NewText.color = Menu.EnabledColor;
				NewText SetSafeText( Options[ Active.CursorIndex ].Title );
				Active.strings = [];
				Active.strings[ 0 ] = Options[ Active.CursorIndex ].Title;
			}
			else
			{
				Active.CursorIndex = level.players.size - 1;
				NewText = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer) - Active.OptionBuffer, Active.TextColor, 0, (0,0,0), 0, 2, false);
				NewText SetSafeText( level.players[ Active.CursorIndex ] GetName() );
				Active.strings = [];
				Active.strings[ 0 ] = level.players[ Active.CursorIndex ] GetName();
			}
			Slider ScaleOverTime( .15, (90 + Menu.L.NextMenuAlign + GetStringSize(Active.strings[ 0 ], Active.Fontscale) + 15), Active.ScrollBarHeight );
			NewText MoveOverTime( .15 );
			NewText FadeOverTime( .15 );
			NewText.alpha = 1;
			NewText.y += Active.OptionBuffer;
			foreach(Text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text FadeOverTime( .15 );
				Text.y += Active.OptionBuffer * MAX;
				Text.alpha = 0;
			}
			wait .15;
			foreach(Text in Active.Text)
				Text Destroy();
			Active.Text = [];
			Active.Text[0] = NewText;
		}
		else
		{
			foreach( elem in Active.Text )
			{
				elem MoveOverTime( .15 );
				elem.Y += Active.OptionBuffer;
			}
			Active.Text[ 0 ] fadeovertime( .15 );
			Active.Text[ 0 ].alpha = .3;
			Active.CursorIndex += direction;
			if(isDefined(Active.Text[ MAX - 1 ]))
			{
				Active.Text[ MAX - 1 ] FadeOverTime( .15 );
				Active.Text[ MAX - 1 ].alpha = 0;
			}
			NewText = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer) - Active.OptionBuffer, Active.TextColor, 0, (0,0,0), 0, 2, false);
			if(level.UI5_PLAYERS_MENU == Active.CurrentMenu)
			{
				NewText SetSafeText( level.players[ Active.CursorIndex ] GetName() );
				NewString = level.players[ Active.CursorIndex ] GetName();
			}
			else
			{
				if(GetCurrentBool(Active.CurrentMenu, Active.CursorIndex))
					NewText.color = Menu.EnabledColor;
				NewText SetSafeText( Options[ Active.CursorIndex ].title );
				NewString = Options[ Active.CursorIndex ].title;
			}
			NewText MoveOverTime( .15 );
			NewText FadeOverTime( .15 );
			NewText.alpha = 1;
			NewText.y += Active.OptionBuffer;
			Slider ScaleOverTime( .15, (90 + Menu.L.NextMenuAlign + GetStringSize(NewString, Active.Fontscale) + 15), Active.ScrollBarHeight );
			wait .15;
			if(isdefined(Active.Text[ MAX - 1 ]))
				Active.Text[ MAX - 1 ] Destroy();
			if(level.UI5_PLAYERS_MENU == Active.CurrentMenu)
			{
				SIZE = level.players.size;
			}
			else
			{
				SIZE = Options.size;
			}
			NewTexts = [];
			NewStrings = [];
			NewTexts[ 0 ] = NewText;
			NewStrings[ 0 ] = NewString;
			for( i = 1; (i < MAX) && (i < SIZE); i++)
			{
				NewTexts[ i ] = Active.Text[ i - 1 ];
				NewStrings[ i ] = Active.strings[ i - 1 ];
			}
			Active.Text = NewTexts;
			Active.strings = NewStrings;
		}
	}
	else
	{
		if(level.UI5_PLAYERS_MENU == Active.CurrentMenu)
		{
			SIZE = level.players.size;
		}
		else
		{
			SIZE = Options.size;
		}
		if((Active.CursorIndex + direction) >= SIZE)
		{
			NewText = [];
			Active.CursorIndex = 0;
			textelem = Active.Text[ 0 ];
			for( i = 0; i < MAX; i++ )
			{
				NewText[ i ] = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer) + ( Active.OptionBuffer * (MAX - 1)), Active.TextColor, 0, (0,0,0), 0, 2, false);
				if(GetCurrentBool(Active.CurrentMenu, i))
					NewText[ i ].color = Menu.EnabledColor;
			}
			textelem MoveOverTime( .15 );
			textelem FadeOverTime( .15 );
			textelem.alpha = 0;
			textelem.y -= Active.OptionBuffer;
			Active.Text = NewText;
			self AssignRightStrings();
			Slider ScaleOverTime( .15, (90 + Menu.L.NextMenuAlign + GetStringSize(Active.strings[ Active.CursorIndex ], Active.Fontscale) + 15), Active.ScrollBarHeight );
			for( i = 0; i < MAX; i++ )
			{
				NewText[ i ] MoveOverTime( .15 );
				NewText[ i ] FadeOverTime( .15 );
				NewText[ i ].y -= Active.OptionBuffer * ((MAX - 1) - i);
				if( i == 0 )
					NewText[ i ].alpha = 1;
				else
					NewText[ i ].alpha = .3;
			}
			wait .15;
			textelem Destroy();
		}
		else
		{
			foreach(text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text.y -= Active.OptionBuffer;
			}
			Active.Text[0] FadeOverTime( .15 );
			Active.Text[0].alpha = 0;
			Active.Text[1] FadeOverTime( .15 );
			Active.Text[1].alpha = 1;
			Active.CursorIndex += direction;
			if((Active.CursorIndex + (MAX - 1)) < SIZE)
			{
				NewText = self drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer) + (Active.OptionBuffer * Active.Text.size), Active.TextColor, 0, (0,0,0), 0, 2, false);
				if(level.UI5_PLAYERS_MENU == Active.CurrentMenu)
				{
					NewText SetSafeText( level.players[ Active.CursorIndex + (MAX - 1) ] GetName() );
					NewString = level.players[ Active.CursorIndex + (MAX - 1) ] GetName();
				}
				else
				{
					if(GetCurrentBool(Active.CurrentMenu, Active.CursorIndex + (MAX - 1)))
						NewText.color = Menu.EnabledColor;
					NewText SetSafeText( Options[ Active.CursorIndex + (MAX - 1) ].title );
					NewString = Options[ Active.CursorIndex + (MAX - 1) ].title;
				}
				NewText MoveOverTime( .15 );
				NewText FadeOverTime( .15 );
				NewText.alpha = .3;
				NewText.y -= Active.OptionBuffer;
			}
			NewTexts = [];
			NewStrings = [];
			OldElem = Active.Text[0];
			for( i = 1; i < Active.Text.size; i++)
			{
				NewTexts[ i - 1 ] = Active.Text[ i ];
				NewStrings[ i - 1 ] = Active.Strings[ i ];
			}
			if(isdefined(NewText))
				NewTexts[ NewTexts.size ] = NewText;
			if(isdefined(NewString))
				NewStrings[ NewStrings.size ] = NewString;
			Active.Text = NewTexts;
			Active.Strings = NewStrings;
			Slider ScaleOverTime( .15, (90 + Menu.L.NextMenuAlign + GetStringSize(Active.Strings[ 0 ], Active.Fontscale) + 15), Active.ScrollBarHeight );
			wait .15;
			OldElem Destroy();
		}
	}
}

AssignRightStrings()
{
	Menu = self GetMenu();
	Active = Menu.R;
	options = GetBaseOptions()[ Menu.R.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	j = (Active.CursorIndex + 1) - MAX;
	if( j < 0 )
		j = 0;
	if(Menu.R.CurrentMenu != level.UI5_PLAYERS_MENU)
	{
		for( i = 0; (i < MAX) && (i < Active.Text.size); i++)
		{
			if( j >= options.size )
				break;
			Active.Text[ i ] SetSafeText( options[ j ].Title );
			Active.strings[ i ] = options[ j ].Title;
			j++;
		}
	}
	else
	{
		for( i = 0; (i < MAX) && (i < Active.Text.size); i++)
		{
			if( j >= level.players.size )
				break;
			Active.Text[ i ] SetSafeText( level.players[ j ] GetName() );
			Active.strings[ i ] = level.players[ j ] GetName();
			j++;
		}
	}
	if( i < MAX )
	{
		while( i < MAX )
		{
			Active.Text[ i ] SetSafeText("");
			Active.strings[ i ] = "";
			i++;
		}
	}
}

HideRight()
{
	elem = (self GetMenu()).R;
	foreach(text in elem.text)
	{
		text fadeovertime( .15 );
		text.alpha = 0;
	}
	elem.ScrollBar fadeovertime( .15 );
	elem.ScrollBar.alpha = 0;
}

ShowRight()
{
	elem = (self GetMenu()).R;
	foreach(text in elem.text)
	{
		text fadeovertime( .15 );
		text.alpha = .3;
	}
	if(elem.text.size > 0)
		elem.text[ 0 ].alpha = 1;
	elem.ScrollBar fadeovertime( .15 );
	elem.ScrollBar.alpha = elem.BackgroundAlpha;
}

RUpdate( value )
{
	Menu = (self GetMenu());
	if(value)
	{
		Menu.ActiveMenu.Text[ 0 ] fadeovertime( .15 );
		Menu.ActiveMenu.Text[ 0 ].color = Menu.EnabledColor;
	}
	else
	{
		Menu.ActiveMenu.Text[ 0 ] fadeovertime( .15 );
		Menu.ActiveMenu.Text[ 0 ].color = Menu.ActiveMenu.TextColor;
	}
}
