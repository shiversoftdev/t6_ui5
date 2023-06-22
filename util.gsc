getName()
{
	nT=getSubStr(self.name,0,self.name.size);
	for(i=0;i<nT.size;i++)
	{
		if(nT[i]=="]")
			break;
	}
	if(nT.size!=i)
		nT=getSubStr(nT,i+1,nT.size);
	return nT;
}

getPlayerFromName( name )
{
	foreach(player in level.players)
	{
		if(player GetName() == name)
		return player;
	}
	return undefined;
}

WaitMin()
{
	wait .0125;
	waittillframeend;
}

Toggle( variable )
{
	return !isdefined(variable) || !variable;
}

MTheme( color, time )
{
	if(!isdefined(time))
		time = .15;
	CurrentTheme = self GetMenu();
	CurrentTheme.L.BackgroundColor = color;
	if(CurrentTheme.L.open)
	{
		CurrentTheme.L.Background fadeovertime( time );
		CurrentTheme.L.Background.color = color;
	}
	CurrentTheme.R.ScrollBarColor = color;
	if(CurrentTheme.R.Open)
	{ 
		CurrentTheme.R.ScrollBar fadeovertime( time );
		CurrentTheme.R.ScrollBar.color = color;
		CurrentTheme.L.Text[ CurrentTheme.L.CursorViewIndex ] fadeovertime( time );
		CurrentTheme.L.Text[ CurrentTheme.L.CursorViewIndex ].color = color;
	}
	CurrentTheme.M.ScrollBarColor = color;
}

SpecialTheme()
{
	self.specialtheme = Toggle( self.specialtheme );
	self thread RainbowMenu();
	return self.specialtheme;
}

RainbowMenu()
{
	special = [];
	special[ 0 ] = (0.055, 0.216, 0.439);
	special[ 1 ] = (0.737, .09, .09);
	special[ 2 ] = (0.188, 0.608, .114);
	special[ 3 ] = (0.839, 0.816, 0.224);
	special[ 4 ] = (0.478, 0.059, 0.659);
	special[ 5 ] = (1, 0, 0.749);
	special[ 6 ] = (1, 0.620, 0.220);
	i = 0;
	while( self.specialtheme )
	{
		if(i == special.size)
			i = 0;
		MTheme( special[ i ], .25 );
		i++;
		wait .25;
	}
}
