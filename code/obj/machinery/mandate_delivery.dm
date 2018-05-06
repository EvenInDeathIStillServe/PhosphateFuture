/obj/machinery/SCMS_machine
	name = "Supreme Council Mandate Shipping machine"
	desc = "Input Phosphate Zenith bars to fulfill Supreme Council mandates. The SCMS machine does not ship the Phosphate Zenith on its own. It merely acts as a container until proper transport."
	icon_state = "SCMS_machine"
	density = 1

/obj/machinery/SCMS_machine/Bumped(var/atom/movable/AM)
	if(!istype(AM,/obj/item/ingot/phosphatez))
		return
	SupremeCouncil.mandate -= 1
	if(SupremeCouncil.mandate < 0)
		money += 100
	else
		money += 75
	del AM