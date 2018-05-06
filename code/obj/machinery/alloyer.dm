/obj/machinery/alloyer
	name = "alloyer"
	desc = "This machine allows the alloying of two ingots in order to create an ingot of a different type with different properties."
	icon_state = "alloyer"
	density = 1
	var/obj/item/ingot/ingot_1 = null
	var/obj/item/ingot/ingot_2 = null

/obj/machinery/alloyer/Bumped(var/atom/movable/AM)
	if(!istype(AM,/obj/item/ingot))
		return
	if(!AM:alloyable)
		return
	if(!ingot_2 && !ingot_1)
		ingot_1 = AM
		AM.loc = src
		alloy()
		playsound(loc,'sounds/alloyer.ogg', 80, 0, 1, 1)
		return
	if(!ingot_1 && ingot_2.type != AM.type)
		ingot_1 = AM
		AM.loc = src
		alloy()
		playsound(loc,'sounds/alloyer.ogg', 80, 0, 1, 1)
		return
	if(!ingot_2 && ingot_1.type != AM.type)
		ingot_2 = AM
		AM.loc = src
		alloy()
		playsound(loc,'sounds/alloyer.ogg', 80, 0, 1, 1)
		return

/obj/machinery/alloyer/proc/alloy()
	if(!ingot_1 || !ingot_2)
		return
	if((istype(ingot_1,/obj/item/ingot/iron) && istype(ingot_2,/obj/item/ingot/gold)) || (istype(ingot_2,/obj/item/ingot/iron) && istype(ingot_1,/obj/item/ingot/gold)))
		new/obj/item/ingot/firegold(src.loc)
	del ingot_1
	del ingot_2