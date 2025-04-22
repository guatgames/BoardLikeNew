canMove=false;

moving=false;

with(Obj_activate_card)
{
    image_index=0;
}

with (Obj_activate_enemy)
{

    image_index=0;

}
  
if(Obj_Player.mana > 0 && self.information.cost <= Obj_Player.mana || self.information.cost == 0){
      
    
    
    if (other.information.isArea==false)
    {
    	with (Obj_classEnemy)
    	{
    
    		if ( place_meeting(other.x,other.y,self.collision) )
    		{
    			other.x=room_width/2;
    			other.y=room_height/2-32;
    			other.alarm[0]=15;             
    			self.colli=true;
    			self.card.dmg=other.information.dmg;
    			self.card.isAtack=other.information.isAtack;
                Obj_Player.mana -= other.information.cost;
                
                if(other.information.isShield){
                
                    Obj_Player.shield += other.information.shield;
                
                }
                
                other.excCard();
    	
    		}
            
    	
    	}
    	
    } else {
    
    	if (place_meeting(self.x,self.y,Obj_activate_card))
    	{
    
            if(self.information.isAtack == true){
        		if (!ds_list_empty(global.enemies_list))
        		{
        	
        			for(var i = 0 ; i < ds_list_size(global.enemies_list); i++)
        			{
        		
        				var enemy = ds_list_find_value(global.enemies_list,i);
        				enemy.pos = i;
        				enemy.colli=true;
        				enemy.card.dmg=self.information.dmg;
        				enemy.card.isAtack=self.information.isAtack;
                        
        		
        			}
                    Obj_Player.mana -= self.information.cost; 
                    self.excCard();
        	
        		} else {
        		
        		
        	
        		}
            } else {
             
            }
            if(self.information.isMana == true){
                
                Obj_Player.mana += self.information.addMana;
                self.excCard();
                
            }
            if(self.information.isShield){
                
                Obj_Player.shield += self.information.shield;
                   
            }
            
            self.x=room_width/2;
            self.y=room_height/2-32;
            self.alarm[0]=15; 
    
    	}
    }
} else {
	show_debug_message("No hay mana");
}