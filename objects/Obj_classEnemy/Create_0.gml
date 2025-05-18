randomize();

colli = false;
collision =  instance_create_layer(x,y,"Instances", Obj_activate_enemy);
pos = 0;
damage = false;
objName = Obj_classEnemy;

stats=
{

	totalLife:20,
	hp:0,
	dmg:2
	
}

card=
{

	dmg:0,
	mana:0,
	isAtack: false,
	isMana: false

}

function excTurn(){

	show_debug_message("hola");

}