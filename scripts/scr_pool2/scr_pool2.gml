function scr_pool2(listOfCArds,deckList,deckList2){

	for (var i=0; i<ds_list_size(deckList);i++)
	{
		
        var card = Obj_classCard;
		card = ds_list_find_value(deckList,i);
		instance_activate_object(card);
		card.x=900+32*i;
		card.y=660;
		card.image_index=1;
		ds_list_add(deckList2,card);	
		
	}

}