function scr_pool(listOfCards,deckList,deckList2){
	
	ds_list_shuffle(listOfCards);
    var card = Obj_classCard;
	
	if (!ds_list_empty(deckList))
		{
            
			for (var i=0; i < ds_list_size(deckList);i++)
			{
				
				card = ds_list_find_value(deckList,i);
				instance_activate_object(card);
				card.x=700+32*i;
				card.y=660;
				card.image_index=0;
				ds_list_add(deckList2,card);
                card.list=deckList2;
						
			}
		} else 
		{
			for (var j=0; j<ds_list_size(listOfCards) ;j++)
				{
                    
					card = instance_create_layer(room_width/2,room_height/2,"Instances",ds_list_find_value(listOfCards,j));
					ds_list_add(deckList,card);
                    instance_deactivate_object(card);
                    
                    
				}			
		}
	
}