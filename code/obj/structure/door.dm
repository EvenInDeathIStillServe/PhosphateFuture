/obj/structure/door
	name = "door"
	desc = "Remember to knock, or you might get an eyeful of..."
	opacity = 1
	density = 1
	icon_state = "door"
	icon = 'icons/obj/structure/doors.dmi'
	var/initial_state
	var/state = 0 //Closed = 0, Opened = 1
	var/isSwitchingStates
	var/openSound = 'sounds/effects/stonedoor_openclose.ogg'
	var/closeSound = 'sounds/effects/stonedoor_openclose.ogg'

/obj/structure/door/New()
	initial_state = icon_state

/obj/structure/door/Bumped(var/atom/movable/M)
	if(isSwitchingStates)
		return
	Open()

/obj/structure/door/attack_hand(mob/user)
	if(isSwitchingStates)
		return
	if(state == 0)
		Open()
	else
		Close()

/obj/structure/door/attackby(obj/item/weapon/W, mob/user)
	attack_hand(user)

/obj/structure/door/proc/Open()
	if(state == 1)
		return
	isSwitchingStates = 1
	opacity = 0
	playsound(src, openSound, 100, 1)
	flick("[initial_state]opening",src)
	sleep(10)
	density = 0
	state = 1
	isSwitchingStates = 0
	icon_state = "[initial_state]open"

/obj/structure/door/proc/Close()
	if(state == 0)
		return
	isSwitchingStates = 1
	playsound(src, closeSound, 100, 1)
	flick("[initial_state]closing",src)
	sleep(10)
	opacity = 1
	density = 1
	state = 0
	isSwitchingStates = 0
	icon_state = "[initial_state]"

/obj/structure/door/wood
	icon_state = "wood"
	openSound = 'sounds/effects/doorcreaky.ogg'
	closeSound = 'sounds/effects/doorcreaky.ogg'