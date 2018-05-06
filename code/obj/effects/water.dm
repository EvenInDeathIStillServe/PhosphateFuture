/obj/effects/water
	name = "water"
	desc = "It's wet!"
	icon_state = "water"
	var/list/stepsound = list('sounds/step/water-01.ogg','sounds/step/water-02.ogg','sounds/step/water-03.ogg','sounds/step/water-04.ogg')

/obj/effects/water/Crossed(var/atom/movable/M)
	if(ishuman(M))
		M:burning = 0
		M.update_icon()