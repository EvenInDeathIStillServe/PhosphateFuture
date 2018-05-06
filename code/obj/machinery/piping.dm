/obj/machinery/piping
	var/datum/pipe_network/network = null
	icon = 'icons/piping.dmi'
	density = 1
	anchored = 1

/obj/machinery/piping/examine(mob/user)
	..()
	if(network)
		user << "Network: [network.nametag]"
		for(var/datum/reagent/R in network.pipe_tank.reagents.reagent_list)
			user << "[R]: [R.volume] units."

/obj/machinery/piping/pipe
	name = "pipe"
	desc = "Ooooh, a pipe! It might either lead to a magic kingdom, or the sewage runoff. The latter is more likely."
	icon_state = "pipe"

/obj/machinery/piping/pipe/New()
	spawn(10)
		update_connections()
		var/obj/machinery/piping/pipe/P
		for(var/direction in cardinal)
			if(locate(P in get_step(src,direction)))
				P.update_connections()
	..()

/obj/machinery/piping/pipe/Del()
	var/obj/machinery/piping/pipe/P
	for(var/direction in cardinal)
		if(locate(P in get_step(src,direction)))
			P.update_connections()
	..()

/obj/machinery/piping/pipe/proc/update_connections()
	var/connectdir = 0
	for(var/direction in cardinal)
		var/obj/machinery/piping/P = locate() in get_step(src,direction)
		if(P)
			connectdir |= direction
	icon_state = "pipe[connectdir]"

/obj/machinery/piping/pipe/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/wrench))
		network = new /datum/pipe_network
		network.nametag = "[pick(alphabet)][pick(alphabet)][pick(alphabet)][rand(1,9)]"
		src.init_network()
		user << "Network initialized!"


/obj/machinery/piping/proc/init_network()
	for(var/direction in cardinal)
		var/obj/machinery/piping/P = locate() in get_step(src,direction)
		if(P && P.network !=  src.network)
			P.network = src.network
			P.init_network()


/obj/machinery/piping/pump_intake
	name = "intake pump"
	desc = "This contraption siphons fluids and pushes them into an attached pipe network."
	icon_state = "pump_intake"

/obj/machinery/piping/pump_intake/process()
	if(locate(/obj/effects/water) in src.loc && src.network)
		network.pipe_tank.reagents.add_reagent("water",10)