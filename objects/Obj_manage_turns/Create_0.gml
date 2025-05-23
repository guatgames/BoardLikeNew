randomize();

list=ds_list_create();
ds_list_add(list,Obj_card_atack,Obj_card_shield,Obj_card_mana,Obj_card_mana,Obj_card_shield,
				 Obj_card_atack,Obj_card_atack,Obj_card_atack,Obj_card_shield,Obj_card_atack,
				 Obj_card_atackAll);

numOfHand=5;
deck=ds_list_create();
init_deck=ds_list_create();
dead_deck=ds_list_create();
hand_list=ds_list_create();
hand=0;
playerTurn=true;
heist=true;  
cleanHand = false;


//This is the object that will manage the turns during the combat

#region //machine state
	machine=new StateMachine("Start");
	characterState=0;
    
 
	#region //States

		#region //Start
			machine.AddState("Start", {
				onEnter: function()
				{
					//Create the pool
					scr_pool(list,deck,init_deck);
                    //Request the pool
                    scr_pool(list,deck,init_deck);
                    //Set the mana
                    Obj_Player.mana = Obj_Player.manaMax;
                    
                    playerTurn=true;
					win = false;
					
				}
			})
		#endregion

		#region //heist state
			machine.AddState("Heist", {
	
				onEnter: function()
				{
					if (playerTurn==true ){
                        
                       
                        
                        
                        
                            while (hand<5) {
                                if (!ds_list_empty(init_deck)){
    
                                        var card = Obj_classCard;
                                        card = ds_list_find_value(init_deck,0);
                                        card.x = 124*hand;
                                        card.y=664;
                                        card.image_index=1;
                                        ds_list_add(hand_list,card);
                                        card.list=Obj_manage_turns.hand_list; 
                                        ds_list_delete(init_deck,ds_list_find_index(init_deck,card.id));
                                        Obj_finish_turn.finishTurn=false;
                                        hand++;
                                    
                                } else {
                        
                                    
                            
                                }
                            
                            }
                           
                            heist=false;
                        
                        
                        
                    }
					
				},
	
				onStep: function()
				{
				    
				},
	
			})
		#endregion
		
		#region //Reorganiza deck
		
			machine.AddState("Reorganize",
			{
			
				onEnter: function()
				{
					
					if (ds_list_size(init_deck) <= 5)
					{
						
						scr_reorganize_deck(list,dead_deck,deck,init_deck);
						scr_pool(list,deck,init_deck);
					    
					}
                    playerTurn=true;
                    heist=true;
					
				
				},
                onExit: function(){
                    
                    playerTurn=true;
                    heist=true;
                    
                }
			
			})
		
		#endregion
		
		#region //Enemy State
		
			machine.AddState("EnemysTurn",
			{
				onEnter: function()
				{
                    
                    for (var i = 0; i < ds_list_size(hand_list); i++) {
                        
                        var card = Obj_classCard;
                        card = ds_list_find_value(hand_list,i);

                        ds_list_add(dead_deck,card.id);  
                        
                        //ds_list_delete(hand_list,ds_list_find_index(hand_list,card.id));
                        
                        instance_deactivate_object(card);

                    }
                    
                    ds_list_clear(hand_list);
                    hand = 0;
                    Obj_Player.mana = Obj_Player.manaMax;
                    //cleanHand = true;
                    
                    scr_pool_enemies(global.enemies_list);
                    Obj_finish_turn.finishTurn=false;
                    Obj_Player.shield = 0;
					
				},
				
				
			})
		
		#endregion
		
		#region //win state
		
			machine.AddState("Win", {
			
				onEnter: function(){
				
					draw_set_font(fn_1);
					draw_set_valign(fa_middle);
					draw_set_halign(fa_center);
					draw_set_color(c_black);
					win = true;
				
				},
				
				onStep: function(){
				
					if(ds_list_empty(global.enemies_list)){
					
						show_debug_message("Ganaste x2");
						show_debug_message(win);
					
					} else {
					
						
					
					}
				
				} 
			
			})
		
		#endregion
		
		#region //loose state
		
			machine.AddState("Loose", {
			
				onEnter: function(){
				
					if(Obj_Player.life <= 0){
					
						show_debug_message("Perdiste");
					
					} else {
					
						
					
					}
				
				},
				
				onStep: function(){
				
					
				
				}
			
			})
		
		#endregion
		
	#endregion
	
	#region //Transitions
	
		machine.AddTransition("Start","Heist",function()
		{
			return playerTurn;
		})
		
		machine.AddTransition("Heist","EnemysTurn",function()
		{
			return Obj_finish_turn.finishTurn;
		})
		
		machine.AddTransition("EnemysTurn","Reorganize",function()
		{
			return ds_list_size(init_deck);
		})

        machine.AddTransition("Heist","Reorganize",function()
		{
			return ds_list_size(init_deck) <= 1;
		})
		
		machine.AddTransition("Reorganize","Heist",function()
		{
			return playerTurn;
		})
		
		machine.AddTransition("Heist","Win",function()
		{
			return ds_list_empty(global.enemies_list);
		})
		
		machine.AddTransition("EnemysTurn","Loose",function(){
		
			return Obj_Player.life <= 0 ;
		
		})
		
		machine.AddTransition("Heist","Loose",function(){
		
			return Obj_Player.life <= 0;
		
		})
		
	
	#endregion
	

#endregion
