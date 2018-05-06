/obj/machinery/saw
	name = "saw"
	desc = "I saw a guy fall asleep while working with one of these. He's not around anymore."
	icon_state = "saw"
	density = 1

/obj/machinery/saw/Bumped(var/atom/movable/AM)
	if(!istype(AM,/obj/item/wood))
		return
	playsound(loc,'sounds/saw.ogg', 80, 0, 1)
	var/obj/item/stack/planks/P = new(src.loc)
	P.amount = 5
	del AM