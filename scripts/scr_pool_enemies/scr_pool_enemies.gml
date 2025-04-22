function scr_pool_enemies(list){ 
	if (!ds_list_empty(list))
	{
	
		for(var i = 0 ; i < ds_list_size(list); i++)
		{
		
			var enemy = ds_list_find_value(list,i);
			enemy.pos = i;
			enemy.excTurn();
            Obj_Player.comprobatedmg();
		
		}
	
	} else {
		
		show_debug_message("You Win");
	
	}

}