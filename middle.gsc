DrawMiddle( overflow_fix )
{
	Menu = self GetMenu();
	self setempjammed( 1 );
	Left = Menu.L;
	Right = Menu.R;
	Active = Menu.M;
	if(isdefined(overflow_fix) && overflow_fix)
	{
		self AssignMiddleStrings();
		Left.Text[ Left.CursorViewIndex ] SetSafeText( Right.strings[ 0 ] );
		return;
	}
	Active.MHistory[ Active.MHistory.size ] = Menu.CurrentMenu;
	Menu.M.open = true;
	Active.CursorIndex = 0;
	Active.CursorViewIndex = 0;
	Active.currentMenu = Menu.CurrentMenu;
	Options = GetBaseOptions()[ Menu.M.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	SIZE = Options.size;
	for( i = 0; i < Left.Text.size; i++ )
	{
		if(i != Left.CursorViewIndex )
		{
			Left.Text[ i ] MoveOverTime( .15 );
			Left.Text[ i ].sort = 1;
			Left.Text[ i ].y -= (Left.Text[ i ].y - Left.Text[ Left.CursorViewIndex ].y);
		}
	}
	for( i = 0; i < Right.Text.size; i++ )
	{
		Right.Text[ i ] MoveOverTime( .15 );
		Right.Text[ i ].sort = 0;
		Right.Text[ i ].y -= (Right.Text[ i ].y - Right.Text[ 0 ].y);
	}
	Left.Text[ Left.CursorViewIndex ] fadeovertime( .15 );
	Left.Text[ Left.CursorViewIndex ].alpha = 0;
	Active.HStartAlign = 25 + GetStringSize(Right.strings[ 0 ], Left.Fontscale) + Menu.HAlign;
	Active.OptionBuffer = ((-1 * Active.HStartAlign) + 380) / Active.MAXOPTIONS;
	Active.ItemShaderWidth = Active.OptionBuffer - 8;
	Left.ScrollBar ScaleOverTime( .15, 900, Left.ScrollBarHeight );
	Right.ScrollBar ScaleOverTime( .15, 900, Right.ScrollBarHeight );
	wait .15;
	Left.Text[ Left.CursorViewIndex ] SetSafeText( Right.strings[ 0 ] );
	Left.Text[ Left.CursorViewIndex ].sort = 6;
	Left.Text[ Left.CursorViewIndex ] fadeovertime( .15 );
	Left.Text[ Left.CursorViewIndex ].alpha = 1;
	for( i = 0; i < Left.Text.size; i++ )
	{
		if(i != Left.CursorViewIndex )
			Left.Text[ i ] Destroy();
	}
	for( i = 0; i < Right.Text.size; i++ )
	{
		Right.Text[ i ] Destroy();
	}
	Middle = Active;
	Middle.Title = Left.Text[ Left.CursorViewIndex ];
	Middle.SecretBlack = self createShader("white", "LEFT", "TOP", (Menu.HAlign - 90), Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), 25 + GetStringSize(GetBaseOptions()[ Menu.M.CurrentMenu ].Title, Left.Fontscale) + 90, Left.ScrollBarHeight, Left.ScrollBarColor, 1, 5);
	Middle.Text = [];
	for( i = 0; (i < MAX) && (i < SIZE); i++ )
	{
		Middle.Text[ i ] = self drawText("", Active.Font, Active.FontScale, "CENTER", "TOP", Active.HStartAlign + (Active.OptionBuffer * (i + .5)), Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 4, false);
		if( GetCurrentBool( Middle.CurrentMenu, i) )
			Middle.Text[ i ].color = Menu.EnabledColor;
	}
	self AssignMiddleStrings();
	for( i = 0; (i < MAX) && (i < SIZE); i++ )
	{
		Middle.Text[ i ] fadeovertime( .05 * i );
		if(i==0)
			Middle.Text[ i ].alpha = 1;
		else
			Middle.Text[ i ].alpha = .4;
	}
	Middle.entermenu = ::DrawMiddleFromMiddle;
}

DrawMiddleFromMiddle( overflow_fix )
{
	Menu = self GetMenu();
	Left = Menu.L;
	Right = Menu.R;
	Active = Menu.M;
	Active.currentMenu = Menu.CurrentMenu;
	if(isdefined(overflow_fix) && overflow_fix)
	{
		self AssignMiddleStrings();
		Left.Text[ Left.CursorViewIndex ] SetSafeText( GetBaseOptions()[ Menu.M.CurrentMenu ].Title );
		return;
	}
	Active.CursorIndex = 0;
	Active.CursorViewIndex = 0;
	foreach(text in Active.Text)
	{
		text MoveOverTime( .15 );
		text.x -= 500;
	}
	wait .15;
	foreach(text in Active.Text)
		text Destroy();
	DrawMiddleTextElems();
}

ClearMiddle()
{
	Menu = self GetMenu();
	Active = Menu.M;
	arrayremovevalue( Active.MHistory, Active.CurrentMenu );
	if(Active.MHistory.size < 1)
	{
		Active.CurrentMenu = -1;
		Active.entermenu = ::DrawMiddle;
		Menu.M.open = false;
		foreach(Text in Active.Text)
		{
			Text MoveOverTime( .15 );
			Text.x += 480;
		}
		Active.Title FadeOverTime( .15 );
		Active.Title.alpha = 0;
		Menu.L.ScrollBar MoveOverTime( .15 );
		Menu.R.ScrollBar MoveOverTime( .15 );
		Menu.L.ScrollBar.x += 900;
		Menu.R.ScrollBar.x -= 900;
		wait .15;
		foreach(Text in Active.Text)
		{
			Text Destroy();
		}
		Active.Title Destroy();
		Active.SecretBlack Destroy();
		Menu.L.ScrollBar Destroy();
		Menu.R.ScrollBar Destroy();
		self RedrawLeft();
		self RedrawRight();
		Menu.ActiveMenu = Menu.R;
	}
	else
	{
		Active.CurrentMenu = Active.MHistory[ Active.MHistory.size - 1];
		Active.CursorIndex = 0;
		Active.CursorViewIndex = 0;
		foreach(text in Active.Text)
		{
			text MoveOverTime( .15 );
			text.x -= 500;
		}
		wait .15;
		foreach(text in Active.Text)
			text Destroy();
		DrawMiddleTextElems();
	}
}

DrawMiddleTextElems()
{
	Menu = self GetMenu();
	Left = Menu.L;
	Right = Menu.R;
	Middle = Menu.M;
	Middle.CursorIndex = 0;
	Middle.CursorViewIndex = 0;
	Options = GetBaseOptions()[ Menu.M.CurrentMenu ].options;
	MAX = Middle.MAXOPTIONS;
	SIZE = Options.size;
	Middle.Title fadeovertime( .15 );
	Middle.Title.alpha = 0;
	Middle.HStartAlign = 25 + GetStringSize(GetBaseOptions()[ Menu.M.CurrentMenu ].Title, Left.Fontscale) + Menu.HAlign;
	Middle.OptionBuffer = ((-1 * Middle.HStartAlign) + 380) / Middle.MAXOPTIONS;
	Middle.ItemShaderWidth = Middle.OptionBuffer - 8;
	wait .15;
	Middle.Title SetSafeText( GetBaseOptions()[ Menu.M.CurrentMenu ].Title );
	Middle.Title.sort = 6;
	Middle.Title fadeovertime( .15 );
	Middle.Title.alpha = 1;
	Middle.Title = Left.Text[ Left.CursorViewIndex ];
	Middle.SecretBlack Destroy();
	Middle.SecretBlack = self createShader("white", "LEFT", "TOP", (Menu.HAlign - 90), Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), 25 + GetStringSize(GetBaseOptions()[ Menu.M.CurrentMenu ].Title, Left.Fontscale) + 90, Left.ScrollBarHeight, Left.ScrollBarColor, 1, 5);
	Middle.Text = [];
	for( i = 0; (i < MAX) && (i < SIZE); i++ )
	{
		Middle.Text[ i ] = self drawText("", Middle.Font, Middle.FontScale, "CENTER", "TOP", Middle.HStartAlign + (Middle.OptionBuffer * (i + .5)), Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), Middle.TextColor, 0, (0,0,0), 0, 4, false);
		if( GetCurrentBool( Middle.CurrentMenu, i) )
			Middle.Text[ i ].color = Menu.EnabledColor;
	}
	self AssignMiddleStrings();
	for( i = 0; (i < MAX) && (i < SIZE); i++ )
	{
		Middle.Text[ i ] fadeovertime( .05 * i );
		if(i==0)
			Middle.Text[ i ].alpha = 1;
		else
			Middle.Text[ i ].alpha = .4;
	}
}

ScrollMiddle( direction )
{
	Menu = self GetMenu();
	Active = Menu.M;
	Options = GetBaseOptions()[ Menu.M.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	Left = Menu.L;
	ShouldAlterList = false;
	MIDDLE = Int( MAX / 2 );
	if(direction > 0 && (Active.CursorViewIndex == MIDDLE) && ((Active.CursorIndex + MIDDLE + 1) < Options.size))
		ShouldAlterList = true;
	else if(direction < 0 && (Active.CursorViewIndex == MIDDLE) && ((Active.CursorIndex - MIDDLE) > 0 ))
		ShouldAlterList = true;
	if(MAX > Options.size)
		ShouldAlterList = false;
	if(Options.size < 2)
		return;
	SIZE = Min( MAX, options.size );
	if(ShouldAlterList)
	{
		Active.CursorIndex += direction;
		if(direction > 0)
		{
			foreach(Text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text.x -= Active.OptionBuffer;
			}
			Active.Text[0] FadeOverTime( .15 );
			Active.Text[0].alpha = 0;
			Active.Text[ Active.CursorViewIndex ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex ].alpha = .4;
			Active.Text[ Active.CursorViewIndex + 1 ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex + 1 ].alpha = 1;
			NewText = [];
			for( i = 1; i < SIZE; i++)
			{
				NewText[ i - 1 ] = Active.Text[ i ];
			}
			NewElem = self drawText("", Active.Font, Active.FontScale, "CENTER", "TOP", Active.HStartAlign + (Active.OptionBuffer * (SIZE + .5)) + 8, Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 4, false);
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex + MIDDLE ))
				NewElem.color = Menu.EnabledColor;
			NewElem SetSafeText( Options[ Active.CursorIndex + MIDDLE ].Title );
			NewElem MoveOverTime( .15 );
			NewElem FadeOverTime( .15 );
			NewElem.alpha = .4;
			NewElem.x -= Active.OptionBuffer;
			NewText[ NewText.size ] = NewElem;
			wait .15;
			Active.Text[0] Destroy();
			Active.Text = NewText;
		}
		else
		{
			foreach(Text in Active.Text)
			{
				Text MoveOverTime( .15 );
				Text.x += Active.OptionBuffer;
			}
			Active.Text[ Active.Text.size - 1 ] FadeOverTime( .15 );
			Active.Text[ Active.Text.size - 1 ].alpha = 0;
			Active.Text[ Active.CursorViewIndex ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex ].alpha = .4;
			Active.Text[ Active.CursorViewIndex - 1 ] FadeOverTime( .15 );
			Active.Text[ Active.CursorViewIndex - 1 ].alpha = 1;
			NewText = [];
			NewStrings = [];
			NewElem = self drawText("", Active.Font, Active.FontScale, "CENTER", "TOP", Active.HStartAlign + (Active.OptionBuffer * -0.5) + 8, Menu.VAlign + (Left.CursorViewIndex * Left.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 4, false);
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex - MIDDLE ))
				NewElem.color = Menu.EnabledColor;
			NewElem SetSafeText( Options[ Active.CursorIndex - MIDDLE].Title );
			NewElem MoveOverTime( .15 );
			NewElem FadeOverTime( .15 );
			NewElem.alpha = .4;
			NewElem.x += Active.OptionBuffer;
			NewText[ 0 ] = NewElem;
			for( i = 1; i < SIZE; i++)
			{
				NewText[ i ] = Active.Text[ i - 1 ];
			}
			wait .15;
			Active.Text[ Active.Text.size - 1 ] Destroy();
			Active.Text = NewText;
		}
	}
	else if( ((direction + Active.CursorViewIndex) >= MAX) || ((direction + Active.CursorViewIndex) >= Options.size) )
	{
		Active.CursorViewIndex = 0;
		Texts = Active.Text;
		Active.CursorIndex = 0;
		foreach(xtext in Texts)
		{
			xtext MoveOverTime( .2 );
			xtext FadeOverTime( .2 );
			xtext.alpha = 0;
			xtext.x += 500;
		}
		wait .2;
		foreach(xtext in Texts)
		{
			xtext.x -= 1000;
		}
		self AssignMiddleStrings();
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
			text.x += 500;
		}
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		wait .2;
	}
	else if( ((direction + Active.CursorViewIndex) < 0) )
	{
		if(Options.size < Active.MAXOPTIONS)
			Active.CursorViewIndex = Options.size - 1;
		else
			Active.CursorViewIndex = MAX - 1;
		Texts = Active.Text;
		Active.CursorIndex = Options.size - 1;
		foreach(xtext in Texts)
		{
			xtext MoveOverTime( .2 );
			xtext FadeOverTime( .2 );
			xtext.alpha = 0;
			xtext.x -= 500;
		}
		wait .2;
		foreach(xtext in Texts)
		{
			xtext.x += 1000;
		}
		self AssignMiddleStrings();
		for(i = 0; i < Texts.size; i++)
		{
			if(GetCurrentBool( Active.CurrentMenu, Active.CursorIndex - i ))
				Texts[i].color = Menu.EnabledColor;
			else
				Texts[i].color = Menu.ActiveMenu.TextColor;
		}
		foreach(text in Active.Text)
		{
			text MoveOverTime( .2 );
			text FadeOverTime( .2 );
			text.alpha = .4;
			text.x -= 500;
		}
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		wait .2;
	}
	else
	{
		Active.Text[ Active.CursorViewIndex ] fadeovertime( .15 );
		Active.Text[ Active.CursorViewIndex ].alpha = .4;
		Active.CursorViewIndex += direction;
		Active.CursorIndex += direction;
		Active.Text[ Active.CursorViewIndex ] fadeovertime( .15 );
		Active.Text[ Active.CursorViewIndex ].alpha = 1;
		wait .15;
	}
}

AssignMiddleStrings()
{
	Menu = self GetMenu();
	Active = Menu.M;
	options = GetBaseOptions()[ Menu.M.CurrentMenu ].options;
	MAX = Active.MAXOPTIONS;
	j = (Active.CursorIndex + 1) - MAX;
	if( j < 0 )
		j = 0;
	for( i = 0; (i < MAX) && (i < Active.Text.size); i++)
	{
		if( j >= options.size )
			break;
		Active.Text[ i ] SetSafeText( options[ j ].Title );
		j++;
	}
	if( i < MAX )
	{
		while( i < MAX )
		{
			Active.Text[ i ] SetSafeText("");
			i++;
		}
	}
}

HideMiddle()
{
	Men = self GetMenu();
	middle = Men.M;
	middle.SecretBlack.alpha = 0;
	foreach(Text in middle.text)
	{
		text fadeovertime( .15 );
		text.alpha = 0;
	}
}

ShowMiddle()
{
	Men = self GetMenu();
	middle = Men.M;
	for( i = 0; i < middle.Text.size; i++ )
	{
		middle.Text[ i ] fadeovertime( .15 );
		if( i == middle.CursorViewIndex )
			middle.Text[ i ].alpha = 1;
		else
			middle.Text[ i ].alpha = .4;
	}
	middle.SecretBlack.alpha = 1;
}

RedrawLeft()
{
	Menu = self GetMenu();
	Active = Menu.L;
	Active.Text = [];
	Active.strings = [];
	MAX = Menu.L.MAXOPTIONS;
	for(i = 0; i < MAX; i++)
	{
		xtext = self drawText("", Active.Font, Active.Fontscale, "LEFT", "TOP", Menu.HAlign - 200, Menu.VAlign + (i * Active.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 3, false);
		if( GetCurrentBool( Active.CurrentMenu, i) )
			xtext.color = Menu.EnabledColor;
		Active.Text[ i ] = xtext;
	}
	self AssignLeftStrings();
	Active.ScrollBar = self createShader(Active.ScrollBarShader, "LEFT", "TOP", (Menu.HAlign - 90) - 400, Menu.VAlign + (Active.CursorViewIndex * Active.OptionBuffer), 90 + (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 25, Active.ScrollBarHeight, Active.ScrollBarColor, 0, 2);
	Active.NextMenuAlign = (GetStringSize(Active.strings[ Active.CursorViewIndex ], Active.Fontscale)) + 35;
	foreach(text in Active.Text)
	{
		text MoveOverTime(.15);
		text FadeOverTime(.15);
		text.alpha = .4;
		text.x += 200;
	}
	Active.ScrollBar MoveOverTime(.15);
	Active.ScrollBar FadeOverTime(.15);
	Active.ScrollBar.alpha = Active.SliderAlpha;
	Active.ScrollBar.x  += 400;
	wait .15;
	Active.Text[ Active.CursorViewIndex ].alpha = 1;
}

RedrawRight()
{
	Menu = self GetMenu();
	Active = Menu.R;
	Menu.L.Text[ Menu.L.CursorViewIndex ] fadeovertime( .15 );
	Menu.L.Text[ Menu.L.CursorViewIndex ].color = Active.ScrollBarColor;
	Menu.L.ScrollBar fadeovertime( .15 );
	Menu.L.ScrollBar.alpha = 1;
	Active.Text = [];
	Active.ScrollBar = self createShader(Active.ScrollBarShader, "LEFT", "TOP", (Menu.HAlign - 90), Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer), 1, Active.ScrollBarHeight, Active.ScrollBarColor, Active.BackgroundAlpha, 1);
	for( i = 0; i < Active.MAXOPTIONS; i++)
	{
		xtxt = drawText("", Active.Font, Active.FontScale, "LEFT", "TOP", Menu.HAlign + Menu.L.NextMenuAlign, Menu.VAlign + (Menu.L.CursorViewIndex * Menu.L.OptionBuffer), Active.TextColor, 0, (0,0,0), 0, 2, false);
		if(GetCurrentBool(Active.CurrentMenu, i))
			xtxt.color = Menu.EnabledColor;
		Active.Text[ i ] = xtxt;
	}

	self AssignRightStrings();
	Active.ScrollBar ScaleOverTime( .15, (90 + Menu.L.NextMenuAlign + GetStringSize(Active.strings[ 0 ], Active.Fontscale) + 15), Active.ScrollBarHeight);
	
	for( i = 0; i < Active.MAXOPTIONS; i++ )
	{
		Active.Text[ i ] MoveOverTime( .15 );
		Active.Text[ i ] fadeovertime( .15 );
		Active.Text[ i ].alpha = .3;
		Active.Text[ i ].y += (Active.OptionBuffer * i);
	}
	wait .15;
	Active.Text[ 0 ].alpha = 1;
}

MUpdate( value )
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
