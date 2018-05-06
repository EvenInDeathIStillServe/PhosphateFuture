/obj/structure/closet
	name = "closet"
	desc = "You can store things in it."
	icon_state = "closet0"
	icon = 'icons/obj/closets_crates.dmi'
	density = 1
	anchored = 0
	var/closed_icon = "closet0"
	var/open_icon = "closet1"
	var/opened = 0
	var/open_sound = 'sounds/click.ogg'
	var/close_sound = 'sounds/click.ogg'

/obj/structure/closet/New()
	spawn(1)
	if(!opened)
		for(var/obj/item/I in src.loc)
			I.loc = src

/obj/structure/closet/attackby(var/obj/item/W, mob/user)
	if(opened)
		user.drop(src.loc)
	else
		src.attack_hand(user)


/obj/structure/closet/attack_hand(user)
	if(!opened)
		for(var/obj/item/I in src)
			I.loc = src.loc
		for(var/mob/M in src)
			M.loc = src.loc
		icon_state = open_icon
		opened = 1
		density = 0
		playsound(loc, open_sound, 30, 1, -3)
	else
		for(var/obj/item/I in src.loc)
			I.loc = src
		for(var/mob/M in src.loc)
			M.loc = src
		icon_state = closed_icon
		opened = 0
		density = 1
		playsound(loc, close_sound, 30, 1, -3)

/obj/structure/closet/fridge
	name = "fridge"
	desc = "I hope there's food inside."
	icon_state = "fridge0"
	closed_icon = "fridge0"
	open_icon = "fridge1"

/obj/structure/closet/crate
	name = "crate"
	desc = "Ah, a crate! We use these a lot for transporting things."
	icon_state = "crate0"
	closed_icon = "crate0"
	open_icon = "crate1"

/obj/structure/closet/crate/attack_hand(user)
	if(!opened)
		for(var/obj/item/I in src)
			I.loc = src.loc
		icon_state = open_icon
		opened = 1
		playsound(loc, open_sound, 30, 1, -3)
	else
		for(var/obj/item/I in src.loc)
			I.loc = src
		icon_state = closed_icon
		opened = 0
		playsound(loc, close_sound, 30, 1, -3)

/obj/structure/closet/crate/wood
	name = "wooden crate"
	icon_state = "wood0"
	closed_icon = "wood0"
	open_icon = "wood1"