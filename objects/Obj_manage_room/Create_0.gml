randomize();

numOfEnemys = random_range(1,3);

instance_create_layer(x,y,"Instances",Obj_manage_turns);

global.enemies_list =ds_list_create();


for (var i=0; i<=numOfEnemys;i++)
{

	var enemy = instance_create_layer(320+256*i,128,"Ui_Battle",Obj_Enemy);
	enemy.pos = i;
	
	ds_list_add(global.enemies_list,enemy);

}

ds_list_delete(global.enemies_list,ds_list_size(global.enemies_list));
