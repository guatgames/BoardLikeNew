health = 100;
life = 70;
manaMax = 3;
mana = 0;
shield = 0;
damaged = 0;

function comprobatedmg(){
    
    if(damaged > 0){
    
        if(shield > 0){
            
            shield -= damaged;
            
            damaged = 0;
            
        } else {
         
            life -= damaged;     
            
            damaged = 0;  
            
        }
        
    }
    
}
