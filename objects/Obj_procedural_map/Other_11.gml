for (var i=0;i<ds_grid_width(map);i++)
{
	for (var j=0;j<ds_grid_height(map);j++)
	{
		if (map[# i,j]==2)
		{
			instance_create_layer(64*i,64*j,"Instances",Obj_start);
		}
		if (map[# i,j]==1)
		{
			instance_create_layer(64*i,64*j,"Instances",Obj_start);
		}
	}
}