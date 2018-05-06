/mob/living/human
	name = "Player"
	icon = 'icons/mobs.dmi'
	icon_state = "human"

	mob_size = MOB_MEDIUM

	luminosity = 5
	var/obj/item/clothing/uniform = null
	var/obj/item/clothing/suit = null
	var/obj/item/clothing/head = null
	var/obj/item/clothing/glasses = null
	var/obj/item/clothing/gloves = null
	var/obj/item/clothing/shoes = null
	obj/item/clothing/mask = null

	var/obj/item/clothing/spawn_back = null
	var/obj/item/clothing/spawn_uniform = /obj/item/clothing/uniform/workman
	var/obj/item/clothing/spawn_suit = null
	var/obj/item/clothing/spawn_head = /obj/item/clothing/head/hardhat
	var/obj/item/clothing/spawn_glasses = null
	var/obj/item/clothing/spawn_gloves = null
	var/obj/item/clothing/spawn_shoes = /obj/item/clothing/shoes/jackboots
	var/obj/item/clothing/spawn_mask = null

	var/hair_style = "Bald"
	var/hair_color = "000"
	var/facial_hair_style = "Shaved"
	var/facial_hair_color = "000"
	var/eye_color = "000"

	var/obj/item/weapon/reagent_container/stomach/stomach

	var/burning

	var/mood_level = 0
	var/audible_step

#define AUDIBLE_STEP_TIME		3

/mob/living/human/New()
	spawn(0)
		if(spawn_back)
			equip_to_slot(new spawn_back(src.loc), "back")
		if(spawn_uniform)
			equip_to_slot(new spawn_uniform(src.loc), "uniform")
		if(spawn_suit)
			equip_to_slot(new spawn_suit(src.loc), "suit")
		if(spawn_head)
			equip_to_slot(new spawn_head(src.loc), "head")
		if(spawn_glasses)
			equip_to_slot(new spawn_glasses(src.loc), "glasses")
		if(spawn_gloves)
			equip_to_slot(new spawn_gloves(src.loc), "gloves")
		if(spawn_shoes)
			equip_to_slot(new spawn_shoes(src.loc), "shoes")
		if(spawn_mask)
			equip_to_slot(new spawn_mask(src.loc), "mask")

		stomach = new(src)
		if(client)
			player_list.Add(src)
		if(npc)
			NPCs.Add(src)

/mob/living/human/proc/equip_to_slot(var/obj/item/W as obj, var/slot)
	if(client)
		client.screen += W
	switch(slot)
		if("head")
			getridof(W)
			head = W
			W.inv_slot = "head"
			W.screen_loc = "13,7"
		if("glasses")
			getridof(W)
			glasses = W
			W.inv_slot = "glasses"
			W.screen_loc = "13,6"
		if("mask")
			getridof(W)
			mask = W
			W.inv_slot = "mask"
			W.screen_loc = "13,5"
		if("gloves")
			getridof(W)
			gloves = W
			W.inv_slot = "gloves"
			W.screen_loc = "13,4"
		if("suit")
			getridof(W)
			suit = W
			W.inv_slot = "suit"
			W.screen_loc = "13,3"
		if("uniform")
			getridof(W)
			uniform = W
			W.inv_slot = "uniform"
			W.screen_loc = "13,2"
		if("shoes")
			getridof(W)
			shoes = W
			W.inv_slot = "shoes"
			W.screen_loc = "13,1"
		if("back")
			getridof(W)
			back = W
			W.inv_slot = "back"
			W.screen_loc = "12,1"
	W.loc = src
	W.layer = UI_LAYER + 1
	update_icon()


/mob/living/human/update_icon()
	overlays.Cut()
	if(eye_color)
		var/image/img_eyes_s = image("icon" = 'icons/mob/human_face.dmi', "icon_state" = "eyes_s")
		img_eyes_s.color = "#" + eye_color
		overlays += img_eyes_s
	if(facial_hair_style && (!head || !(head.flags_inv & HIDEFACIALHAIR)) && (!mask || !(mask.flags_inv & HIDEFACIALHAIR)))
		var/datum/sprite_accessory/S = facial_hair_styles[facial_hair_style]
		if(S.icon_state)
			var/image/img_facial_hair_s = image("icon" = 'icons/mob/human_face.dmi', "icon_state" = "[S.icon_state]_s")
			img_facial_hair_s.color = "#" + facial_hair_color
			overlays += img_facial_hair_s
	if(hair_style && (!head || !(head.flags_inv & HIDEHAIR)) && (!mask || !(mask.flags_inv & HIDEHAIR)))
		var/datum/sprite_accessory/S = hair_styles[hair_style]
		if(S.icon_state)
			var/image/img_hair_s = image("icon" = 'icons/mob/human_face.dmi', "icon_state" = "[S.icon_state]_s")
			img_hair_s.color = "#" + hair_color
			overlays += img_hair_s
	if(uniform)
		overlays += image('icons/mob/uniform.dmi', uniform.item_state)
	if(glasses)
		overlays += image('icons/mob/glasses.dmi', glasses.item_state)
	if(mask)
		overlays += image('icons/mob/mask.dmi', mask.item_state)
	if(head)
		overlays += image('icons/mob/head.dmi', head.item_state)
	if(shoes)
		overlays += image('icons/mob/feet.dmi', shoes.item_state)
	if(gloves)
		overlays += image('icons/mob/hands.dmi', gloves.item_state)
	if(suit)
		overlays += image('icons/mob/suit.dmi', suit.item_state)
	if(back)
		overlays += image('icons/mob/back.dmi', back.item_state)
	if(r_hand)
		overlays += image('icons/mob/r_hand.dmi', r_hand.item_state)
	if(l_hand)
		overlays += image('icons/mob/l_hand.dmi', l_hand.item_state)


	if(burning)
		overlays += image('icons/mob/effects/burn.dmi', "burn")

/mob/living/human/interact(atom/interacted, params)
	if(hand)
		if(r_hand)
			interacted.attackby(r_hand,src, params)
		else
			interacted.attack_hand(src)
/*
			if(interacted.loc == src)
				src.unequip(interacted)
				update_icon()
				return
*/
	else
		if(l_hand)
			interacted.attackby(l_hand,src, params)
		else
			interacted.attack_hand(src)
/*
			if(interacted.loc == src)
				src.unequip(interacted)
				update_icon()
				return
			else
*/
/mob/living/human/getridof(obj/item/riddenof)
	if(r_hand == riddenof)
		r_hand = null
	else if(l_hand == riddenof)
		l_hand = null

/mob/living/human/unequip(obj/item/unequipped)
	//if(hand && r_hand == unequipped || !hand && l_hand == unequipped)
	if(hand && r_hand || !hand && l_hand)
		return
	switch(unequipped.inv_slot)
		if("r_hand")
			src.r_hand = null
		if("l_hand")
			src.l_hand = null
		if("uniform")
			src.uniform = null
		if("suit")
			src.suit = null
		if("back")
			src.back = null
		if("head")
			src.head = null
		if("glasses")
			src.glasses = null
		if("mask")
			src.mask = null
		if("shoes")
			src.shoes = null
	client.screen -= unequipped
	src.pickup(unequipped)

/mob/living/human/pickup(obj/item/pickedup)
	if(stat)
		return
	if(hand)
		put_in_r_hand(pickedup)
	else
		put_in_l_hand(pickedup)
		pickedup.screen_loc = "6,1"
	update_icon()

/mob/living/human/drop(var/drop_loc = null)
	if(hand)
		drop_r_hand(drop_loc)
	else
		drop_l_hand(drop_loc)
	update_icon()

/mob/living/human/put_in_hands(var/obj/item/pickedup)
	if(hand)
		put_in_r_hand(pickedup)
	else
		put_in_l_hand(pickedup)
	update_icon()

/mob/living/human/proc/put_in_r_hand(var/obj/item/pickedup)
	if(r_hand)
		pickedup.loc = src.loc
		return
	var/obj/item/weapon/storage/S
	if(istype(loc,/obj/item/weapon/storage))
		S = loc
	client.screen += pickedup
	pickedup.loc = src
	r_hand = pickedup
	r_hand.layer = UI_LAYER + 1
	r_hand.inv_slot = "r_hand"
	r_hand.screen_loc = "5,1"
	src << "You pick up [pickedup]."
	if(S)
		S.storage_ui.on_pre_remove(src,pickedup)

/mob/living/human/proc/put_in_l_hand(var/obj/item/pickedup)
	if(l_hand)
		pickedup.loc = src.loc
		return
	var/obj/item/weapon/storage/S
	if(istype(loc,/obj/item/weapon/storage))
		S = loc
	client.screen += pickedup
	pickedup.loc = src
	l_hand = pickedup
	l_hand.layer = UI_LAYER + 1
	l_hand.inv_slot = "l_hand"
	l_hand.screen_loc = "6,1"
	src << "You pick up [pickedup]."
	if(S)
		S.storage_ui.on_pre_remove(src,pickedup)

/mob/living/human/proc/drop_r_hand(var/drop_loc = null)
	if(!r_hand)
		return
	if(drop_loc)
		r_hand.loc = drop_loc
	else
		r_hand.loc = src.loc
//	src << "You drop [r_hand]."
	client.screen -= r_hand
	r_hand.reset_plane_and_layer()
	r_hand.inv_slot = null
	r_hand = null

/mob/living/human/proc/drop_l_hand(var/drop_loc = null)
	if(!l_hand)
		return
	if(drop_loc)
		l_hand.loc = drop_loc
	else
		l_hand.loc = src.loc
//	src << "You drop [l_hand]."
	client.screen -= l_hand
	l_hand.reset_plane_and_layer()
	l_hand.inv_slot = null
	l_hand = null

/mob/living/human/attackby(var/obj/item/weapon/W, mob/user)
	W.attack(src, user)

/mob/living/human/get_active_hand()
	if(hand)	return r_hand
	else		return l_hand

/mob/living/human/get_inactive_hand()
	if(hand) 	return l_hand
	else		return r_hand

/mob/living/human/Moved()
	..()
	if(istype(loc,/turf/floor))
		var/turf/floor/floor = loc
		if(floor.stepsound && audible_step <= world.time && prob(70))
			var/obj/effects/water/W = locate() in loc
			if(W)
				playsound(loc,pick(W.stepsound), 70, 0, 1, 1)
			playsound(loc,pick(floor.stepsound), 70, 0, 1, 1)
			audible_step = world.time + AUDIBLE_STEP_TIME