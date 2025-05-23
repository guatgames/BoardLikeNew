randomize();

loadBattle();

function loadBattle(){
    
    var file = file_text_open_read("battle.json");
    
    if (file >= 0){
    
        var jsonString = file_text_read_string(file);
        var battle = json_parse(jsonString);
        file_text_close(file);
        
        var currentRoom = instance_create_layer(x,y,"Instances",Obj_manage_room);
        currentRoom.seed = battle.seedBattle;
        
        var currentPlayer = instance_create_layer(x,y,"Instances",Obj_Player);
        currentPlayer.life = battle.player.life;
        
        show_debug_message(battle.deck[1].objName);
        
        var manager = instance_create_layer(x,y,"Instances",Obj_manage_turns);
        manager.seed = battle.seedManager;
        
        for(var i = 0; i < array_length(battle.deck); i++){

            var card = battle.deck[i];
            
            ds_list_add(manager.list,card.objName);
        
        }
        
        ds_list_sort(Obj_manage_turns.list,false);
        
        
    } else {
       
        var currentRoom = instance_create_layer(x,y,"Instances",Obj_manage_room);
        
        var currentPlayer = instance_create_layer(x,y,"Instances",Obj_Player);
        
        var manager = instance_create_layer(x,y,"Instances",Obj_manage_turns);
        ds_list_add(manager.list,Obj_card_atack,Obj_card_shield,Obj_card_mana,Obj_card_mana,Obj_card_shield,
				 Obj_card_atack,Obj_card_atack,Obj_card_atack,Obj_card_shield,Obj_card_atack,
				 Obj_card_atackAll);
   
    }
    
    var UI = instance_create_layer(x,y,"Instances",Obj_Ui);
     
        
    
}

function saveBattle(){
    
    var battle = {
        
        player : {

            life: Obj_Player.life,
            manaMax: Obj_Player.manaMax

        },
        
        enemies: [],
        
        deck : [],
        seedManager : Obj_manage_turns.seed,
        seedBattle : Obj_manage_room.seed
        
    };
    
    for(var i = 0; i < ds_list_size(global.enemies_list); i++){

        var enemy = ds_list_find_value(global.enemies_list,i);
        
        battle.enemies[i] = {
            
            objName: enemy.objName
            
        }
    
    }
    
    ds_list_sort(Obj_manage_turns.list,false);
    
    for(var i = 0; i < ds_list_size(Obj_manage_turns.list); i++){

        var card = ds_list_find_value(Obj_manage_turns.list,i);
        
        battle.deck[i] = {
            
            objName: card.information.nameObject
            
        }
    
    }
    
    var file = file_text_open_write("battle.json");
    
    file_text_write_string(file,json_stringify(battle));
    file_text_close(file);
    
}