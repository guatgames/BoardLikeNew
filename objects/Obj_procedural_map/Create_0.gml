randomize();

rooms=random_range(8,14);

instance_create_layer(0,0,"Instances", Obj_Camera)

MapMax=10;

map=ds_grid_create(MapMax,MapMax);

down=false;
up=false;
right=false;
left=false;


for (var i=0; i<ds_grid_width(map);i++)
{
	for (var j=0;j<ds_grid_height(map);j++)
	{
		map[# i,j]=0;
	}
}
map[# 5,5]=2;

event_user(0);
event_user(1);