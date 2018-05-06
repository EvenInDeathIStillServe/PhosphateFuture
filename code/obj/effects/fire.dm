/obj/effects/fire
	name = "fire"
	desc = "Burn, baby, burn!"
	mouse_opacity = 0
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	var/spread = 0
	var/die_out = 100

/obj/effects/fire/New()
	spawn(1)
		if(locate(/obj/effects/water) in src.loc)
			qdel(src)
		for(var/obj/effects/fire/F in src.loc)
			if(F == src)
				continue
			spread()
			qdel(src)
		setDir(pick(cardinal))
		if(spread > 0)
			spread()
		process()
		spawn(die_out)
			qdel(src)

/obj/effects/fire/proc/spread()
	spawn(1)
		var/list/adjacent_turf = list()
		for(var/direction in cardinal)
			if(!locate(/obj/effects/fire in get_step(src,direction)))
				adjacent_turf += get_step(src,direction)
		if(!adjacent_turf.len)
			return
		spread--
		var/obj/effects/fire/F = new(pick(adjacent_turf))
		F.spread = spread
		if(spread)
			spread()

/obj/effects/fire/process()
	for(var/atom/A in loc)
		A.fire_act()
	spawn(1)
		process()

/atom/proc/fire_act()

/mob/living/human/fire_act()
	if(!burning)
		burning += 15
		update_icon()
	burning = min(100, burning + 5)