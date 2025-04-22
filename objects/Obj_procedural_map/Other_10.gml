for (var i=0;i<ds_grid_width(map);i++)
{
	for (var j=0;j<ds_grid_height(map);j++)
	{
		if (map[# i,j]==2)
		{
			down=true;
			up=true;
			right=true;
			left=true;
		}
		if (down==true && map[# i,j+1]==0)
		{
			map[# i,j+1]=1;
			down=false;
		}
		if (up==true && map[# i,j-1]==0)
		{
			map[# i,j-1]=1;
			up=false;
		}
		if (right==true && map[# i+1,j]==0)
		{
			map[# i+1,j]=1;
			right=false;
		}
		if (left==true && map[# i-1,j]==0)
		{
			map[# i-1,j]=1;
			left=false;
		}
	}
}