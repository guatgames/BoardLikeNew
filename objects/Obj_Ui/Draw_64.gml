draw_set_font(fn_1);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
	

draw_sprite(spr_heart,2,8,8);

draw_text_transformed(70,74,Obj_Player.life,2,2,0);

draw_sprite(spr_shield,2,128,48);

draw_set_color(c_black);

draw_text_transformed(174,96,Obj_Player.shield,2,2,0);

draw_sprite(spr_mana,1,room_width-200,32);

draw_set_color(c_white);

draw_text_transformed(room_width-164,96,Obj_Player.mana,2,2,0);

draw_text_transformed(room_width-100,96,Obj_Player.manaMax,2,2,0);