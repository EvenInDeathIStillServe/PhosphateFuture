/obj/machinery/drill
	name = "industrial mining drill"
	desc = "Looks heavy-duty. It's controlled using a drill control panel."
	icon_state = "drill"
	density = 1

/obj/machinery/drill_control
	name = "drill control panel"
	desc = "There's lots of buttons and dials. Fortunately, I'm trained to use it."
	icon_state = "drill_control0"
	density = 1
	var/state = 0

/obj/machinery/drill_control/attack_hand(user)
	if(state)
		user << "The drill is still working. I should wait until it's done."
		return
	state = 1
	icon_state = "drill_control1"
	user << "You activated the drill."
	for(var/obj/machinery/drill/R in orange(1,src))
		playsound(R.loc, 'sounds/drill.ogg', 80, 0, 1)
	spawn(30)
		for(var/obj/machinery/drill/D in orange(1,src))
			var/obj/structure/ore_source/O = locate() in D.loc
			if(O)
				new O.ore_type(D.loc)
		state = 0
		icon_state = "drill_control0"