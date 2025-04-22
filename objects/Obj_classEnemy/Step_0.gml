
if (self.colli==true)
{

	if (self.card.isAtack==true)
	{
	
		self.stats.hp+=self.card.dmg;
		self.colli=false;
		self.card.dmg=0;
	
	}
	if (self.card.isMana=true)
	{
	
		self.colli=false;
	
	}
}

if (self.stats.hp>=self.stats.totalLife)
{

	ds_list_delete(global.enemies_list,pos);
	
	instance_destroy(self);
	instance_destroy(self.collision);
	

}