/obj/machinery/elevator_control
	name = "elevator control"
	desc = "The power of elevation is at your disposal."
	icon_state = "elevator_control"
	density = 1
	var/id = 1
	var/sent = 0
	var/levels_to_move = -1

/obj/machinery/elevator_control/attack_hand(user)
	for(var/area/elevator/E in world)
		if(src.id == E.id)
			if(sent)
				E.move_contents(levels_to_move, 1)
			else
				E.move_contents(levels_to_move)
	for(var/obj/machinery/elevator_control/C in world)
		if(C.id == id)
			sent = !sent
	world << "[pick(hair_styles)]"

/obj/machinery/elevator_control/bottom
	levels_to_move = 1