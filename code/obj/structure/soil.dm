/obj/structure/soil
	name = "soil"
	desc = "It's perfect for growing plants!"
	icon_state = "soil"
	layer = OBJ_LAYER - 0.1

/obj/structure/soil/examine(mob/user)
	..()
	var/obj/structure/plant/P = locate() in src.loc
	if(P)
		P.examine(user)

/obj/structure/soil/attack_hand(mob/user)
	var/obj/structure/plant/P = locate() in src.loc
	if(P)
		P.attack_hand(user)

/obj/structure/soil/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/shovel))
		var/obj/item/weapon/shovel/S = W
		if(!S.dirt_type)
			S.dirt_type = "dirt"
			S.icon_state = "shovel_dirt"
			user << "You pick up some dirt with [W]."
			playsound(src.loc,'sounds/shovel_up.ogg', 80, 0, 1)
			var/obj/structure/plant/P = locate() in src.loc
			if(P)
				del P
			del src
		else if(S.dirt_type == "dirt")
			playsound(src.loc,'sounds/shovel_down.ogg', 80, 0, 1)
			S.dirt_type = null
			S.icon_state = "shovel"
	if(istype(W, /obj/item/seed))
		var/obj/structure/plant/P = locate() in src.loc
		if(P)
			user << "There's already something growing here."
			return
		var/obj/item/seed/S = W
		S.plant_seed(src.loc)
		del S