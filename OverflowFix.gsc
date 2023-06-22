SmartOverflowEngine()
{
	if(isdefined(level.SmartOverflowEngine))
		return;
	level.SmartOverflowEngine = true;
	level.uniquestrings = [];
	level.anchors = [];
	temp = createServerfontstring("default", 1);
	temp settext(&"Zombies Alive: ");
	temp settext(&"Total Zombies: ");
	temp settext("+");
	temp destroy();
	level.anchors[0] = createServerFontString("default", 1);
	level.anchors[0] setText("EANCHOR_0");
	level.anchors[0].alpha = 0;
	value = 0;
	level thread SmartOverflowOnEndedFix();
	level thread SmartOverFlowOptimizer();
	for(;;)
	{
		level waittill("settext");
		value++;
		if( value >= 50 )
		{
			value = 0;
			level.anchors[ level.anchors.size ] = createServerFontString("default", 1);
			level.anchors[ level.anchors.size - 1] setText(level.uniquestrings[ level.uniquestrings.size - 1]);
			level.anchors[ level.anchors.size - 1].alpha = 0;
		}
		if( level.uniquestrings.size >= 50 )
		{
			SmartOverflowAnchorClear();
			foreach(player in level.players)
			{
				player thread UpdateMenu(false, true);
			}
			wait .01;
		}
	}
}

SmartOverFlowOptimizer()
{
	level endon("game_ended");
	value = false;
	while( 1 )
	{
		level waittill("MenuClose");
		value = false;
		foreach( player in level.players )
		{
			if( !isDefined(player GetMenu()) )
				continue;
			if((player GetMenu()).currentMenu != -1)
			{
				value = true;
				break;
			}
		}
		if( !value )
		{
			SmartOverflowAnchorClear();
		}
	}
}

SmartOverflowAnchorClear()
{
	for( i = level.anchors.size - 1; i > 0; i--)
	{
		level.anchors[i] ClearAllTextAfterHudElem();
		level.anchors[i] destroy();
		wait .0125;
		waittillframeend;
	}
	level.anchors[0] ClearAllTextAfterHudElem();
	level.uniquestrings = [];	
}

SmartOverflowOnEndedFix()
{
	level waittill( "game_ended" );
	SmartOverflowAnchorClear();
	foreach(player in level.players)
	{
		if( isDefined( player GetMenu() ) )
		{
			(player GetMenu()).currentmenu = -1;
			player thread UpdateMenu(false, true);
		}
	}
}

