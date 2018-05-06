/obj/machinery/concrete_machine
	name = "concrete machine"
	desc = "Thanks to TECHNOLOGY, concrete production has been simplified into one, single machine. Hooray!"
	icon_state = "concrete_machine"
	density = 1

/obj/machinery/concrete_machine/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/shovel))
		var/obj/item/weapon/shovel/S = W
		if(S.dirt_type == "sand")
			S.dirt_type = null
			S.icon_state = "shovel"
			user << "You put some sand into [src]. It produces some concrete slabs."
			var/obj/item/stack/concrete/C = new(src.loc)
			C.amount = 10