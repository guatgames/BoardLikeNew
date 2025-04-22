if (self.image_index==1)
{
	des = instance_create_layer(x,y,"Instances",Obj_description_card);

	des.sprit = self.information.sprite;
	des.man=self.information.cost;
	des.text=self.information.description;
} else 
{
	
}

if (moving==true)
{
	instance_destroy(des);
}