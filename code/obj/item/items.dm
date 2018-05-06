/obj/item
	icon = 'icons/items.dmi'
	layer = ABOVE_OBJ_LAYER
	var/inv_slot = null
	var/slot_flags = 0
	var/value = 0
	var/item_state
	var/w_class
	var/randpixel
	var/canremove = 1 //Won't allow the item to be removed if set to 0.
	var/zoomdevicename = null //name used for message when binoculars/scope is used
	var/zoom = 0 //1 if item is actively being used to zoom. For scoped guns and binoculars.

/*
For zooming with scope or binoculars. This is called from
modules/mob/mob_movement.dm if you move you will be zoomed out
modules/mob/living/carbon/human/life.dm if you die, you will be zoomed out.
*/
/*
/obj/item/proc/can_zoom(mob/living/user, var/silent = 0)
	var/devicename
	if(zoomdevicename)
		devicename = zoomdevicename
	else
		devicename = src.name

	if(!ishuman(user))
		if(!silent)
			user.visible_message("You are unable to focus through \the [devicename].")
		return 0
	if(user.client.pixel_x | user.client.pixel_y) //Keep people from looking through two scopes at once
		if(!silent)
			user.seek_and_unzoom()
			//user.visible_message("You are too distracted to look through \the [src].")
			//return 0
		if(user.get_active_hand() != src)
			if(!silent)
				user.visible_message(" You are too distracted to look through \the [devicename].")
			return 0
	else if(user.get_active_hand() != src)
		if(!silent) user.visible_message("  You are too distracted to look through \the [devicename].")
		return 0
	return 1

//Looking through a scope or binoculars should /not/ improve your periphereal vision. Still, increase viewsize a tiny bit so that sniping isn't as restricted to NSEW
/obj/item/proc/zoom(mob/user, var/tileoffset = 14,var/viewsize = 9) //tileoffset is client view offset in the direction the user is facing. viewsize is how far out this thing zooms. 7 is normal view
	if(!user.client)
		return

	if(!zoom && can_zoom(user))
		if(user.hud_used.hud_shown)
			user.toggle_zoom_hud()	// If the user has already limited their HUD this avoids them having a HUD when they zoom in
		user.client.view = viewsize

		zoom = 1

		var/tilesize = 32
		var/viewoffset = tilesize * tileoffset

		switch(user.dir)
			if (NORTH)
				user.client.pixel_x = 0
				user.client.pixel_y = viewoffset
			if (SOUTH)
				user.client.pixel_x = 0
				user.client.pixel_y = -viewoffset
			if (EAST)
				user.client.pixel_x = viewoffset
				user.client.pixel_y = 0
			if (WEST)
				user.client.pixel_x = -viewoffset
				user.client.pixel_y = 0

		user.visible_message("\The [user] peers through the [zoomdevicename ? "[zoomdevicename] of [src]" : "[src]"].")
	else
		user.client.view = world.view
		if(!user.hud_used.hud_shown)
			user.toggle_zoom_hud()
		zoom = 0

		user.client.pixel_x = 0
		user.client.pixel_y = 0

/*		if(!cannotzoom)
			user.visible_message("[zoomdevicename ? "\The [user] looks up from [src]" : "\The [user] lowers [src]"].")*/

	return
*/
/obj/item/New()
	if(randpixel)
		pixel_x = rand(-randpixel, randpixel)
		pixel_y = rand(-randpixel, randpixel)
/*
//Checks if the item is being held by a mob, and if so, updates the held icons
/obj/item/proc/update_twohanding()
	update_held_icon()

/obj/item/proc/update_held_icon()
	if(ismob(src.loc))
		var/mob/M = src.loc
		if(M.l_hand == src)
			M.update_inv_l_hand()
		else if(M.r_hand == src)
			M.update_inv_r_hand()

/obj/item/proc/is_held_twohanded(mob/living/M)
	var/check_hand
	if(M.l_hand == src && !M.r_hand)
		check_hand = BP_R_HAND //item in left hand, check right hand
	else if(M.r_hand == src && !M.l_hand)
		check_hand = BP_L_HAND //item in right hand, check left hand
	else
		return FALSE

	//would check is_broken() and is_malfunctioning() here too but is_malfunctioning()
	//is probabilistic so we can't do that and it would be unfair to just check one.
	if(ishuman(M))
/*
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/hand = H.organs_by_name[check_hand]
		if(istype(hand) && hand.is_usable())
*/
		return TRUE
	return FALSE
*/
/obj/item/proc/attack_self(mob/user)
	return

/obj/item/proc/mob_can_unequip(mob/M, slot, disable_warning = 0)
	if(!slot) return 0
	if(!M) return 0

	if(!canremove)
		return 0
	if(!M.slot_is_accessible(slot, src, disable_warning? null : M))
		return 0
	return 1

// called when this item is removed from a storage item, which is passed on as S. The loc variable is already set to the new destination before this is called.
/obj/item/proc/on_exit_storage(obj/item/weapon/storage/S as obj)
	return

// called when this item is added into a storage item, which is passed on as S. The loc variable is already set to the storage item.
/obj/item/proc/on_enter_storage(obj/item/weapon/storage/S as obj)
	return

// called when "found" in pockets and storage items. Returns 1 if the search should end.
/obj/item/proc/on_found(mob/finder as mob)
	return

/obj/item/proc/equipped(var/mob/user, var/slot)
	hud_layerise()
	if(user.client) user.client.screen |= src
	if(user.pulling == src) user.pulling = null

	//Update two-handing status
	var/mob/M = loc
	if(!istype(M))
		return

// apparently called whenever an item is removed from a slot, container, or anything else.
/obj/item/proc/dropped(mob/user as mob)
	if(randpixel)
		pixel_z = randpixel //an idea borrowed from some of the older pixel_y randomizations. Intended to make items appear to drop at a character
/*
	if(zoom)
		zoom(user) //binoculars, scope, etc
*/
/obj/item/gold
	name = "bag of gold"
	desc = "We're rich!"
	icon_state = "gold"
	value = 100

/obj/item/attack_hand(mob/user)
	if(src.loc == user)
		user.unequip(src)
		user.update_icon()
		return
	user.pickup(src)

/obj/item/proc/attack(mob/M, mob/user, click_parameters)

/obj/item/verb/verb_pickup()
	set name = "Pick up"
	set category = "Object"
	set src in oview(1)

	usr.interact(src)

/obj/item/wood
	name = "wood"
	desc = "Got wood?"
	icon_state = "wood"

/obj/item/acorn
	name = "acorn"
	desc = "This turns into a tree when planted in soil. Crazy how nature does that."
	icon_state = "acorn"

/obj/item/ore/iron
	name = "iron ore"
	desc = "Sin(12)? 1. 0.43837114678/2. 0.58778525229/ 3. 0.95105651629/ 4. 0.20791169081"
	icon_state = "iron_ore"

/obj/item/ore/gold
	name = "gold ore"
	desc = "We've struck gold!"
	icon_state = "gold_ore"

/obj/item/ore/phosphatez
	name = "phosphate zenith ore"
	desc = "It's what we're here for."
	icon_state = "phosphatez_ore"

/obj/item/ore/New()
	pixel_x = rand(0,8)-4
	pixel_y = rand(0,4)-4

/obj/item/ingot
	name = "ingot"
	icon_state = "iron_ingot"
	var/alloyable = 1

/obj/item/ingot/iron
	name = "iron ingot"
	desc = "This can be turned into a wide variety of objects."
	icon_state = "iron_ingot"
	value = 10

/obj/item/ingot/gold
	name = "gold ingot"
	desc = "This thing's heavy! You could say it's worth its weight in gold."
	icon_state = "gold_ingot"
	value = 25

/obj/item/ingot/firegold
	name = "firegold ingot"
	desc = "An alloy made of iron and gold. It's much more durable than both of its constituents, and more valuable too."
	icon_state = "firegold_ingot"
	alloyable = 0
	value = 50

/obj/item/ingot/phosphatez
	name = "phosphate zenith ingot"
	desc = "This is only step 2. We're not done yet."
	icon_state = "phosphatez_ingot"
	value = 75

/obj/item/ingot/New()
	pixel_x = rand(0,8)-4
	pixel_y = rand(0,4)-4