function scr_reorganize_deck(listOfCards,listOfCards2,deckList,deckList2){

	//clean the principla list
	ds_list_clear(deckList);
	
	
	
	//get the dead cards
	for (var i=0;i<ds_list_size(listOfCards2);i++)
	{
        ds_list_add(deckList,ds_list_find_value(listOfCards2,i));
	}
	
	//clean the dead cards list
	ds_list_clear(listOfCards2);
	
	//get the rest init cards
	for (var j=0;j<ds_list_size(deckList2);j++)
	{
   
        ds_list_add(deckList,ds_list_find_value(deckList2,j));
	
	}
	
	ds_list_clear(deckList2);
	
	ds_list_shuffle(deckList);
}