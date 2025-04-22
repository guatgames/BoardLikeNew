function scr_separate_chain_text_in_lines(argument0,argument1,argument2){

	#region //Variables
	
		chain=argument0;
		width_spr=sprite_get_width(argument1);
		font=argument2;
		
		var comprobate_chain = string_replace_all(chain, "\n", " ");
		var words2 = scr_separate_text_word(chain);
		
		var lines = false;
		var lenght2 = array_length(words2);
		var provisional1 = "";
		var provisional2 = "";
		var next_word = "";
		var count = 0;	
	
	#endregion
	
	draw_set_font(font);
	
	if (string_width(comprobate_chain) > (width_spr-32))
	{
		for (var i=0; i<lenght2; i++)
		{
			next_word = words2[i];
			
			if (next_word != "\n")
			{
				provisional1 = provisional2;
				provisional2 += (words2[i] + " ");
				
				if (string_width(provisional2) > (width_spr - 32))
				{
					lines[count] = provisional1;
					count++;
					provisional1 = "";
					provisional2 = (words2[i] + " ");
				}
			}
			else 
			{
				lines[count] = provisional2;
				count++;
				provisional1 = "";
				provisional2 = "";
			}
		}
		
	}
	else
	{
		lines[0] = chain;
	}
	if (provisional2 != "")
	{
		lines[count] = provisional2;
	}
	
	words2=0;
	
	return lines;

}