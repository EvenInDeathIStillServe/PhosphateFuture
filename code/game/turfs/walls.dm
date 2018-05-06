/turf/wall
	icon = 'icons/walls.dmi'
	density = 1
	opacity = 1
	can_bullets = 1
	var/walltype
	var/being_removed
	var/floor_above_type

/turf/wall/New()
	..()
	spawn(10)
		update_icon()
		for(var/direction in cardinal)
			if(istype(get_step(src,direction),src.type))
				var/turf/wall/W = get_step(src,direction)
				W.update_icon()
		if(floor_above_type) //This changes the turf above the new wall to the appropriate floor type
			var/turf/controller = locate(1, 1, z)
			for(var/obj/effect/landmark/zcontroller/c in controller)
				if(c.initialized && c.up)
					var/turf/above = locate(x,y,z+1)
					if(istype(above,/turf/floor/openspace))
						above.ChangeTurf(floor_above_type)

//Apparently this isn't necessary
/*
/turf/wall/ChangeTurf(var/turf/N)
	if(floor_above_type) //This changes the turf above the new wall to the appropriate floor type
		var/turf/controller = locate(1, 1, z)
		for(var/obj/effect/landmark/zcontroller/c in controller)
			if(c.initialized && c.up)
				var/turf/above = locate(x,y,z+1)
				if(istype(above,/turf/floor/openspace))
					above.ChangeTurf(floor_above_type)
	..()
*/

/turf/wall/Del()
	being_removed = 1
	for(var/direction in cardinal)
		if(istype(get_step(src,direction),src.type))
			var/turf/wall/W = get_step(src,direction)
			W.update_icon()
	..()

/turf/wall/update_icon()
	var/connectdir = 0
	for(var/direction in cardinal)
		if(istype(get_step(src,direction),src.type))
			var/turf/wall/W = get_step(src,direction)
			if(W.being_removed)
				continue
			connectdir |= direction
	icon_state = "[walltype][connectdir]"

/turf/wall/rock
	name = "rock wall"
	icon_state = "rock0"
	walltype = "rock"
	floor_above_type = /turf/floor/rock

/turf/wall/rock/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/pickaxe))
		playsound(src, "sounds/pickaxe1.wav", 50)
		switch(rand(1,10))
			if(3 to 5)
				new/obj/item/ore/iron(src)
			if(6 to 8)
				new/obj/item/ore/gold(src)
			if(8 to 9)
				new/obj/structure/ore_source/iron(src)
			if(10)
				new/obj/structure/ore_source/gold(src)
		src.ChangeTurf(/turf/floor/rock)

/turf/wall/rock/attack_hand(mob/user)
	if(do_after(user, 20, src))
		user << "You touch [src]."

/turf/wall/wood
	name = "wood wall"
	icon_state = "wood0"
	walltype = "wood"

/turf/wall/concrete
	name = "concrete wall"
	icon_state = "concrete0"
	walltype = "concrete"
	floor_above_type = /turf/floor/concrete