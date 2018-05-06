/obj/structure/chair
	icon = 'icons/obj/furniture.dmi'

/obj/structure/chair/New()
	..()
	handle_layer()

/obj/structure/chair/verb/rotate()
	set name = "Rotate Chair"
	set category = "Object"
	set src in oview(1)

	if(!usr || !isturf(usr.loc))
		return
	spin()

/obj/structure/chair/proc/spin()
	setDir(turn(dir, 90))

/obj/structure/chair/setDir(newdir)
	..()
	handle_rotation(newdir)

/obj/structure/chair/proc/handle_rotation(direction)
	handle_layer()

/obj/structure/chair/proc/handle_layer()
	if(dir == NORTH)
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

/obj/structure/chair/wooden
	name = "wooden chair"
	desc = "Solid craftsmanship, if I do say so myself!"
	icon_state = "wooden_chair"

/obj/structure/chair/office
	name = "office chair"
	desc = "The comfort it provides has a severe drawback: it brings with it the duties of filing reports and number-crunching."
	icon_state = "office_chair"
	anchored = 0

/obj/structure/chair/office/Moved()
	playsound(src, 'sounds/roll.ogg', 100, 1)

/obj/structure/stool //Honorary chair
	name = "stool"
	desc = "Comfy!"
	icon_state = "stool"
	icon = 'icons/obj/furniture.dmi'