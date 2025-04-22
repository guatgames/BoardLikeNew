function scr_shuffle_deck(listOfCards,deckList)
{
	ds_list_shuffle(listOfCards);

		for (var j=0; j<ds_list_size(listOfCards) ;j++)
			{
				var card = instance_create_layer(room_width/2,room_height/2,"Instances",ds_list_find_value(listOfCards,j));
				instance_deactivate_object(card);
				ds_list_add(deckList,card);
			}

	
}