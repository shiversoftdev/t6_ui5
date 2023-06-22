createShader(shader, align, relative, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
	hud setParent(level.uiParent);
    hud setShader(shader, width, height);
	hud setPoint(align, relative, x, y);
	hud.hideWhenInMenu = true;
	hud.archived = false;
    return hud;
}

drawText(text, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort, islevel)
{
	hud = undefined;
	if(isdefined(islevel) && islevel)
		hud = createserverfontstring(font, fontscale);
	else
		hud = self createFontString(font, fontScale);
    hud setPoint(align, relative, x, y);
	hud.color = color;
	hud.alpha = alpha;
	hud.glowColor = glowColor;
	hud.glowAlpha = glowAlpha;
	if(sort < 0)
		hud.sort = 6;
	else
		hud.sort = sort;
	hud.alpha = alpha;
	hud setSafeText(text);
	if(sort == -1)
		hud.foreground = true;
	hud.hideWhenInMenu = true;
	hud.archived = false;
	return hud;
}


setSafeText(text)
{
	if( !isinarray(level.uniquestrings, text ) )
	{
		level.uniquestrings = add_to_array(level.uniquestrings, text, 0 );
		level notify("settext");
	}
	self setText(text);
}


