GetStringSize( string, fontscale )
{
	totalsize = 0;
	if(!isdefined(string))
	{
		return 0;
	}
	for( i = 0; i < string.size; i++)
	{
		totalsize += CharSize( getsubstr(string, i, i + 1) ) * fontscale * 2;
	}
	return int( Totalsize );
}

CharSize( char )
{
	size = 2.1;
	if( IS_LOWER( char ) )
	{
		size = 2;
	}
	char = ToLower(char);
	if(!IS_LOWER( char )) //Not a letter
	{
		if(char == "1")
		{
			return 1.2;
		}
		if(char == "2")
		{
			return 2.3;
		}
		if(char == "3")
		{
			return 2.5;
		}
		if(char == "4")
		{
			return 2.55;
		}
		if(char == "5")
		{
			return 2.475;
		}
		if(char == "6")
		{
			return 2.575;
		}
		if(char == "7")
		{
			return 2.3;
		}
		if(char == "8")
		{
			return 2.6;
		}
		if(char == "9")
		{
			return 2.375;
		}
		if(char == "-")
			return 1;
		if(char == " ")
			return 1;
		return 2.5;
	}
	if(char == "a")
	{
		return size * 1.15;
	}
	else if(char == "b")
	{
		return size * 1.15;
	}
	else if(char == "c")
	{
		return size * 1.15;
	}
	else if(char == "d")
	{
		return size * 1.1;
	}
	else if(char == "e")
	{
		return size * 1.1;
	}
	else if(char == "f")
	{
		return size * .75;
	}
	else if(char == "g")
	{
		return size * 1.15;
	}
	else if(char == "h")
	{
		return size * 1.15;
	}
	else if(char == "i")
	{
		return size * .55;
	}
	else if(char == "j")
	{
		return size * .55;
	}
	else if(char == "k")
	{
		return size * 1.0;
	}
	else if(char == "l")
	{
		return size * .55;
	}
	else if(char == "m")
	{
		return size * 1.6;
	}
	else if(char == "n")
	{
		return size * 1.1;
	}
	else if(char == "o")
	{
		return size * 1.15;
	}
	else if(char == "p")
	{
		return size * 1.15;
	}
	else if(char == "q")
	{
		return size * 1.2;
	}
	else if(char == "r")
	{
		return size * 1.0;
	}
	else if(char == "s")
	{
		return size * 1.1;
	}
	else if(char == "t")
	{
		return size * .75;
	}
	else if(char == "u")
	{
		return size * 1.1;
	}
	else if(char == "v")
	{
		return size * 1.0;
	}
	else if(char == "w")
	{
		return size * 1.4;
	}
	else if(char == "x")
	{
		return size * 1.05;
	}
	else if(char == "y")
	{
		return size * 1.1;
	}
	else if(char == "z")
	{
		return size * .95;
	}
}

IS_LOWER( char )
{
	return issubstr( "abcdefghijklmnopqrstuvwxyz", char );
}



