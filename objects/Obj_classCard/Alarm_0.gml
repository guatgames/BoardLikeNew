

Obj_manage_turns.hand--;

ds_list_add(Obj_manage_turns.dead_deck,self.id);  

ds_list_delete(Obj_manage_turns.hand_list,ds_list_find_index(Obj_manage_turns.hand_list,self.id));

list = Obj_manage_turns.dead_deck;

instance_deactivate_object(self);