

seed = random_get_seed();

start();

function start(){
    
    random_set_seed(seed)
    
    var numOfEnemys = random_range(0,3);
    
    global.enemies_list = ds_list_create();
    
    
    for (var i=0; i<=numOfEnemys;i++)
    {
    
    	var enemy = instance_create_layer(320+256*i,128,"Ui_Battle",Obj_Enemy);
    	enemy.pos = i;
    	
    	ds_list_add(global.enemies_list,enemy);
    
    }
    
}
