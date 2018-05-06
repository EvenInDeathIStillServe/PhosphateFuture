/obj/structure
	icon = 'icons/structures.dmi'
	anchored = 1

/obj/structure/tree
	name = "tree"
	desc = "It is lush and green. What a shame how many of these are going to be felled in the name of industrialism."
	icon_state = "tree"
	layer = MOB_LAYER + 1

/obj/structure/sapling
	name = "sapling"
	desc = "A baby tree!"
	icon_state = "sapling"

/obj/structure/sapling/New()
	spawn(600)
		new /obj/structure/tree(src.loc)
		del src

/obj/structure/tree/attackby(var/obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/axe))
		user << "You chop [src] down."
		new /obj/item/wood(src.loc)
		new /obj/item/acorn(src.loc)
		del src