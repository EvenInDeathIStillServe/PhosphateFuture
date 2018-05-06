/obj/structure/multiz
	icon = 'icons/multiz.dmi'
	var/istop = 0

/obj/structure/multiz/proc/targetZ()
	return src.z + (istop? -1 : 1)

/obj/structure/multiz/ladder
	name = "ladder"
	desc = "You can go up or down this."
	icon_state = "ladder_up"

/obj/structure/multiz/ladder/up
	desc = "You can go up this."

/obj/structure/multiz/ladder/down
	desc = "You can go down this."
	icon_state = "ladder_down"
	istop = 1

/*
/obj/structure/multiz/ladder/New()
	icon_state = "ladder_[istop ? "down" : "up" ]"
*/

/obj/structure/multiz/ladder/attack_hand(var/mob/M)
	playsound(src, "sounds/ladder.ogg", 50, 1)
	M.Move(locate(src.x, src.y, targetZ()))

/obj/structure/multiz/ladder/attackby(obj/item/weapon/W, mob/user)
	attack_hand(user)