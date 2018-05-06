/obj/machinery/furnace
	name = "furnace"
	desc = "It's pretty hot. Don't want to get too close!"
	icon_state = "furnace"
	density = 1

/obj/machinery/furnace/Bumped(var/atom/movable/AM)
	if(!istype(AM,/obj/item/ore))
		return
	playsound(loc,'sounds/fire.ogg', 80, 0, 1)
	if(istype(AM,/obj/item/ore/iron))
		new/obj/item/ingot/iron(src.loc)
	if(istype(AM,/obj/item/ore/gold))
		new/obj/item/ingot/gold(src.loc)
	if(istype(AM,/obj/item/ore/phosphatez))
		new/obj/item/ingot/phosphatez(src.loc)
	del AM