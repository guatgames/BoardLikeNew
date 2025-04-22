function scr_separate_text_word(argument0){

	chain=argument0;
	words=false;
	
	var lenght= string_length(chain) +string_count(" ", chain);
	var word="";
	var count=0;
	
	for (var i=1;i<=lenght;i++)
	{
		if (string_char_at(chain,i) !=" ")
		{
			word = word + string_char_at(chain, i);
		} 
		else 
		{
			if (string_length(word) !=0)
			{
				words[count]= word;
				count++;
				word="";
			}
		}
	}
	
	if (word != "")
	{
	 words[count]= word;
	}
	return words;
	
}