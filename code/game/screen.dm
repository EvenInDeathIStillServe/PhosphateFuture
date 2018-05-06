/obj/screen
	layer = UI_LAYER  // make it go over a person
	icon = 'icons/screen.dmi'  // its icon
	var/mob/living/human/owner = null
	var/obj/master = null    //A reference to the object in the slot. Grabs or items, generally.
	alpha = 240

/obj/screen/New(client/C)     //when a new client is made
	C.screen+=src  // add it to the clients screen
	owner = C.mob
	var/mob/M = C.mob
	switch(name)
		if("drop")
			M.drop = src
		if("take")
			M.take = src
		if("swap")
			M.swap = src
		if("right hand")
			M.righthand = src
		if("left hand")
			M.lefthand = src
		if("selector")
			M.selector = src
		if("mood")
			M.mood = src

/obj/screen/drop
	name = "drop"
	icon_state = "drop"
	screen_loc = "1,1"

/obj/screen/take
	name = "take"
	icon_state = "take"
	screen_loc = "2,1"

/obj/screen/swap
	name = "swap"
	icon_state = "swap"
	screen_loc = "4,1"

/obj/screen/righthand
	name = "right hand"
	icon_state = "righthand"
	screen_loc = "5,1"

/obj/screen/lefthand
	name = "left hand"
	icon_state = "lefthand"
	screen_loc = "6,1"

/obj/screen/selector
	name = "selector"
	icon_state = "selector"
	screen_loc = "5,1"
	mouse_opacity = 0

/obj/screen/mood
	name = "mood"
	icon_state = "neutral"
	screen_loc = "13,13"

/obj/screen/inventory
	var/slot_flag = 0

/obj/screen/inventory/Click()
	var/mob/living/human/H = usr
	H.interact(src)


/obj/screen/inventory/attackby(obj/item/clothing/W, mob/living/human/user)
	//var/success = 0
	var/slot = null
	switch(src.name)
		if("back")
			if(W.slot_flags & SLOT_BACK && !user.back)
				slot = "back"
		if("mask")
			if(W.slot_flags & SLOT_MASK && !user.mask)
				slot = "mask"
		if("glasses")
			if(W.slot_flags & SLOT_GLASSES && !user.glasses)
				slot = "glasses"
		if("head")
			if(W.slot_flags & SLOT_HEAD && !user.head)
				slot = "head"
		if("gloves")
			if(W.slot_flags & SLOT_GLOVES && !user.gloves)
				slot = "gloves"
		if("uniform")
			if(W.slot_flags & SLOT_ICLOTHING && !user.uniform)
				slot = "uniform"
		if("suit")
			if(W.slot_flags & SLOT_OCLOTHING && !user.suit)
				slot = "suit"
		if("shoes")
			if(W.slot_flags & SLOT_FEET && !user.shoes)
				slot = "shoes"
	if(slot)
		owner.equip_to_slot(W,slot)
	/*
	if(success)
		W.screen_loc = src.screen_loc
		W.layer = UI_LAYER + 1
		owner.update_icon()
	*/

/obj/screen/inventory/head
	name = "head"
	icon_state = "head"
	screen_loc = "13,7"

/obj/screen/inventory/glasses
	name = "glasses"
	icon_state = "glasses"
	screen_loc = "13,6"

/*
/obj/screen/inventory/head/attackby(obj/item/W, mob/user)
	if(istype(W,/obj/item/clothing/head) && !(owner.head))
		owner.getridof(W)
		W.inv_slot = "head"
		owner.head = W
		owner.head.screen_loc = "13,3"
		owner.head.layer = UI_LAYER + 1
		owner.update_icon()
*/

/obj/screen/inventory/back
	name = "back"
	icon_state = "back"
	screen_loc = "12,1"

/obj/screen/inventory/mask
	name = "mask"
	icon_state = "mask"
	screen_loc = "13,5"

/obj/screen/inventory/gloves
	name = "gloves"
	icon_state = "gloves"
	screen_loc = "13,4"

/obj/screen/inventory/suit
	name = "suit"
	icon_state = "suit"
	screen_loc = "13,3"

/obj/screen/inventory/uniform
	name = "uniform"
	icon_state = "uniform"
	screen_loc = "13,2"

/obj/screen/inventory/shoes
	name = "shoes"
	icon_state = "shoes"
	screen_loc = "13,1"

/*
/obj/screen/inventory/shoes/attackby(obj/item/W, mob/user)
	if(istype(W,/obj/item/clothing/shoes) && !(owner.shoes))
		owner.getridof(W)
		W.inv_slot = "shoes"
		owner.shoes = W
		owner.shoes.screen_loc = "13,1"
		owner.shoes.layer = UI_LAYER + 1
		owner.update_icon()
*/
/obj/screen/take/Click()
	for (var/obj/item/G in view(1,owner))
		if(!istype(G.loc, /turf)) continue
		owner.pickup(G)

/obj/screen/drop/Click()
	owner.drop()

/obj/screen/swap/Click()
	owner.swap_hand()

mob/living/human/proc/swap_hand()
	if(hand)
		selector.screen_loc = "6,1"
		hand = 0
	else
		selector.screen_loc = "5,1"
		hand = 1

/obj/screen/righthand/Click()
	if(!owner.hand)
		owner.swap_hand()

/obj/screen/lefthand/Click()
	if(owner.hand)
		owner.swap_hand()

/obj/screen/mood/Click()
	switch(owner.mood_level)
		if(-INFINITY to -10)
			owner << "This sucks. I want to go home."
		if(-9.9 to -5)
			owner << "I'm slightly miffed."
		if(-4.9 to 4.9)
			owner << "I'm pretty much indifferent right now."
		if(5 to 9.9)
			owner << "This isn't so bad after all."
		if(10 to INFINITY)
			owner << "Hey, life's going pretty good for me right now!"

	if(owner.stomach.reagents.total_volume > 0)
		owner << "My stomach has [owner.stomach.reagents.total_volume] units of fluid in it."

	owner << owner.health

/obj/screen/storage
	name = "storage"

/obj/screen/storage/Click()
	if(!usr.canClick())
		return 1
	if(usr.stat)
		return 1
	if(master)
		var/obj/item/I = usr.get_active_hand()
		if(I)
			usr.ClickOn(master)
	return 1

/obj/screen/inventory
	var/slot_id	//The indentifier for the slot. It has nothing to do with ID cards.


/obj/screen/close
	name = "close"

/obj/screen/close/Click()
	if(master)
		if(istype(master, /obj/item/weapon/storage))
			var/obj/item/weapon/storage/S = master
			S.close(usr)
	return 1


/obj/screen/examine()
	return