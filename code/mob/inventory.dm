// Removes an item from inventory and places it in the target atom.
// If canremove or other conditions need to be checked then use unEquip instead.
/mob/proc/drop_from_inventory(var/obj/item/W, var/atom/target = null)
	if(W)
		remove_from_mob(W, target)
		if(!(W && W.loc)) return 1 // self destroying objects (tk, grabs)
		update_icon()
		return 1
	return 0

//Checks if a given slot can be accessed at this time, either to equip or unequip I
/mob/proc/slot_is_accessible(var/slot, var/obj/item/I, mob/user=null)
	return 1

/mob/proc/isEquipped(obj/item/I)
	if(!I)
		return 0
	return get_inventory_slot(I) != 0

/mob/proc/canUnEquip(obj/item/I)
	if(!I) //If there's nothing to drop, the drop is automatically successful.
		return 1
	var/slot = get_inventory_slot(I)
	if(!slot)
		return 1 //already unequipped, so success
	return I.mob_can_unequip(src, slot)


/mob/proc/get_inventory_slot(obj/item/I)
	var/slot = 0
	for(var/s in slot_first to slot_last) //kind of worries me
		if(get_equipped_item(s) == I)
			slot = s
			break
	return slot

//Returns the item equipped to the specified slot, if any.
/mob/proc/get_equipped_item(var/slot)
	switch(slot)
		if(slot_l_hand) return l_hand
		if(slot_r_hand) return r_hand
		if(slot_back) return back
	return null

//This differs from remove_from_mob() in that it checks if the item can be unequipped first.
/mob/proc/unEquip(obj/item/I, force = 0, var/atom/target = null) //Force overrides NODROP for things like wizarditis and admin undress.
	if(!(force || canUnEquip(I)))
		return
	drop_from_inventory(I, target)
	return 1

/*
	Removes the object from any slots the mob might have, calling the appropriate icon update proc.
	Does nothing else.

	>>>> *** DO NOT CALL THIS PROC DIRECTLY *** <<<<

	It is meant to be called only by other inventory procs.
	It's probably okay to use it if you are transferring the item between slots on the same mob,
	but chances are you're safer calling remove_from_mob() or drop_from_inventory() anyways.

	As far as I can tell the proc exists so that mobs with different inventory slots can override
	the search through all the slots, without having to duplicate the rest of the item dropping.
*/
/mob/proc/u_equip(obj/W as obj)
	if (W == r_hand)
		r_hand = null
		update_inv_r_hand(0)
	else if (W == l_hand)
		l_hand = null
		update_inv_l_hand(0)
	else if (W == back)
		back = null
		update_inv_back(0)
	else if (W == mask)
		mask = null
		update_inv_wear_mask(0)
	return

//Attemps to remove an object on a mob.
/mob/proc/remove_from_mob(var/obj/O, var/atom/target)
	if(!O) // Nothing to remove, so we succeed.
		return 1
	src.u_equip(O)
	if (src.client)
		src.client.screen -= O
	O.reset_plane_and_layer()
	O.screen_loc = null
	if(istype(O, /obj/item))
		var/obj/item/I = O
		if(target)
			I.forceMove(target)
		else
			I.dropInto(loc)
		I.dropped(src)
	return 1