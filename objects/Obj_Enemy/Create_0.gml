// Inherit the parent event
event_inherited();

self.stats.dmg = 5;

function excTurn(){
	
	show_debug_message("Te dañe soy malo");
	//damage = true;
	
	Obj_Player.damaged = self.stats.dmg;

}

