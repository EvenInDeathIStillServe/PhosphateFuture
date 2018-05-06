/obj/effect/landmark/zcontroller
	name = "Z-Level Controller"
	icon_state = "z_controller"
	var/initialized = 0
	var/up 						//Allows up movement
	var/down 					//Allows down movement

	var/list/normal = list()	//These are the turfs and their update speed
	var/list/fast = list()

	var/normal_time				//Time period between updates
	var/fast_time

/obj/effect/landmark/zcontroller/New()
	..()
	for(var/turf/T in world)
		if(T.z == z)
			fast += T
	normal_time = world.time + 50
	fast_time = world.time + 10

	initialized = 1
	process()
	return 1

/obj/effect/landmark/zcontroller/process()
	if (world.time > fast_time)
		calc(fast)
		fast_time = world.time + 10

	if (world.time > normal_time)
		calc(normal)
		normal_time = world.time + 50

	spawn(10)
		process()

/obj/effect/landmark/zcontroller/proc/add(var/list/L, var/I, var/transfer)
	while (L.len)
		var/turf/T = pick(L)

		L -= T
		normal -= T
		fast -= T

		if(!T || !istype(T, /turf))
			continue

		switch (I)
			if(1)	normal += T
			if(2)	fast += T

/turf
	var/list/z_overlays = list()

/turf/New()
	..()

	var/turf/controller = locate(1, 1, z)
	for(var/obj/effect/landmark/zcontroller/c in controller)
		if(c.initialized)
			var/list/turf = list()
			turf += src
			c.add(turf,2,1)


atom/movable/Move() //Hackish
	. = ..()

	var/turf/controllerlocation = locate(1, 1, src.z)
	for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
		if(controller.up || controller.down)
			var/list/temp = list()
			temp += locate(src.x, src.y, src.z)
			controller.add(temp,2,1)

/obj/effect/landmark/zcontroller/proc/calc(var/list/L)
	var/list/normalholder = list()
	var/list/fastholder = list()
	var/new_list

	while(L.len)
		var/turf/T = pick(L)
		new_list = 0

		if(!T || !istype(T, /turf))
			L -= T
			continue

		T.overlays -= T.z_overlays
		T.z_overlays -= T.z_overlays

		if(down && istype(T, /turf/floor/openspace))
			var/turf/below = locate(T.x, T.y, src.z - 1)
			if(below)
				if(istype(below, /turf))
					var/image/t_img = list()
					new_list = 1

					var/image/temp = image(below, dir=below.dir, layer = TURF_LAYER + 0.04)

					temp.color = rgb(127,127,127)
					temp.overlays += below.overlays
					t_img += temp
					T.overlays += t_img
					T.z_overlays += t_img

				// get objects
				var/image/o_img = list()
				for(var/obj/o in below)
					// ingore objects that have any form of invisibility
					if(o.invisibility) continue
					new_list = 1
					var/image/temp2 = image(o, dir=o.dir, layer = TURF_LAYER+0.05*o.layer)
					temp2.color = rgb(127,127,127)
					temp2.overlays += o.overlays
					o_img += temp2
				T.overlays += o_img
				T.z_overlays += o_img

				// get mobs
				var/image/m_img = list()
				for(var/mob/m in below)
					// ingore mobs that have any form of invisibility
					if(m.invisibility) continue
					new_list = 2
					var/image/temp2 = image(m, dir=m.dir, layer = TURF_LAYER+0.05*m.layer)
					temp2.color = rgb(127,127,127)
					temp2.overlays += m.overlays
					m_img += temp2
				T.overlays += m_img
				T.z_overlays += m_img

				T.overlays -= below.z_overlays
				T.z_overlays -= below.z_overlays

/*
				if(istype(below, /turf/floor/openspace)) //The turf below is open space? Just use its overlays, then.
					var/image/b_img = list()
					var/image/temp3 = image
*/
		L -= T
		if(new_list == 1)
			normalholder += T
		if(new_list == 2)
			fastholder += T
			for(var/d in cardinal)
				var/turf/mT = get_step(T,d)
				if(!(mT in fastholder))
					fastholder += mT
				for(var/f in cardinal)
					var/turf/nT = get_step(mT,f)
					if(!(nT in fastholder))
						fastholder += nT

	add(normalholder, 1, 0)
	add(fastholder, 2, 0)
	return