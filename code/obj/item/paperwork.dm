/obj/item/weapon/paper
	name = "paper"
	desc = "I'm glad all the trees we're cutting down are being used to share information."
	icon = 'icons/obj/paperwork.dmi'
	icon_state = "paper"
	item_state = "paper"

	var/info 	//This is the writing on the paper.

/obj/item/weapon/paper/New()
	update_icon()
	pixel_x = rand(0,8)-4
	pixel_y = rand(0,4)-4

/obj/item/weapon/paper/update_icon()
	if(info)
		icon_state = "paper_words"
	else
		icon_state = "paper"

/obj/item/weapon/paper/verb/erase_writing()
	set name = "Erase writing"
	set category = "Object"
	set src in usr

	info = null

/obj/item/weapon/paper/attack_self(mob/user)
	examine(user)

/obj/item/weapon/paper/attackby(var/obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/pen))
		var/writing = "[input("What do you want to write?","Paperwork")]"
		if(!writing)
			return
		info += writing
		src.update_icon()

/obj/item/weapon/paper/examine(user)
	..()
	if(info)
		user << browse("<HEAD><TITLE>[src]</TITLE></HEAD><TT>[info]</TT>", "window=paper")

/obj/item/weapon/pen
	name = "pen"
	desc = "Mightier than the sword! At least, that's what I heard."
	icon = 'icons/obj/paperwork.dmi'
	icon_state = "pen"
	item_state = "pen"

/obj/structure/filingcabinet
	name = "filing cabinet"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/paperwork.dmi'
	icon_state = "filingcabinet"
	density = 1

/obj/structure/filingcabinet/chestdrawer
	name = "chest drawer"
	icon_state = "chestdrawer"


/obj/structure/filingcabinet/tall
	icon_state = "tallcabinet"