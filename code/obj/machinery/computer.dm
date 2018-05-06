/obj/machinery/computer
	name = "computer"
	desc = "I would give you the definition of a computer, but you already know what a computer is. Right?"
	icon_state = "computer_off"
	density = 1
	var/id
	var/on = 0
	var/busy = 0
	var/on_icon = "computer_on"
	var/off_icon = "computer_off"

/obj/machinery/computer/New()
	id = "[rand(1,9999)]"

/obj/machinery/computer/examine(user)
	..()
	user << "It has the number [id] on the side."

/obj/machinery/computer/verb/toggle_power()
	set name = "Toggle power"
	set category = "Object"
	set src in oview(1)

	if(busy)
		usr << "[src] is still starting up."
		return
	if(on)
		usr << "You turn off [src]."
		on = 0
	else
		usr << "You boot up [src]."
		busy = 1
		sleep(50)
		flick("computer_boot",src)
		playsound(src, 'sounds/computer_start.ogg', 100, 1)
		busy = 0
		on = 1
	icon_state = on ? on_icon : off_icon

/obj/machinery/computer/attack_hand(user)
	if(!on)
		toggle_power()
		return
	switch(input("What would you like to do?","Computer") in list("Check Supreme Council mandate","Cancel"))
		if("Check Supreme Council mandate")
			if(SupremeCouncil.mandate > 0)
				user << "The Supreme Council requires [SupremeCouncil.mandate] Phosphate Zenith ingots."
			else if(SupremeCouncil.mandate < 0)
				user << "The Supreme Council mandate has been fulfilled, and [-SupremeCouncil.mandate] extra Phosphate Zenith ingots have been shipped."
			else
				user << "The Supreme Council mandate has been fulfilled. Anymore Phosphate Zenith ingots will result in a bonus."