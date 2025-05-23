if (init == true)
{

	#region //Configure the font to draw it
	
		draw_set_font(fn_1);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_set_color(c_black);
	
	#endregion
	
	#region //calculate the position to draw the description
	
		var posx = other.x;
		var posy = other.y - 224;
	
	#endregion
	
	#region //Draw the description globe
	
		draw_sprite(spr_text_globe_bottom,-1,posx,posy+96);
		
		for (var i=0; i<num_lines;i++)
		{
			draw_sprite(spr_text_globe_mid,-1,posx,posy+64 - ((i+1)*25));
		} 
		draw_sprite(spr_text_globe_top,-1,posx,posy+64 - ((i+1)*25));
		draw_sprite(spr_text_globe_image_zone,-1,posx,posy-30 - ((i+2)*25));
		
	
	#endregion
	
	#region //Draw the text
	
		var lines1 = 0;
		
		for (var i=num_lines; i>0;i--)
		{
			draw_text(posx,posy+80-((i)*25), lines[lines1]);
			lines1++;
		}
	
	#endregion
	
	#region //Draw the sprite of the card
	
	var spr = draw_sprite(sprit,-1,posx,posy-16-((i+num_lines)*25));
	
	#endregion
	
	#region //Draw the cost
	
		draw_text(posx-80,posy-80-((i+num_lines-1)*25),man);
	
	#endregion

}