var/const/FALLOFF_SOUNDS = 0.5

var/list/rustle_sound = list('sounds/effects/rustle1.ogg','sounds/effects/rustle2.ogg','sounds/effects/rustle3.ogg','sounds/effects/rustle4.ogg','sounds/effects/rustle5.ogg')

/proc/playsound(var/atom/source, soundin, vol as num, vary, extrarange as num, falloff, var/is_global)
	var/frequency = get_rand_frequency() // Same frequency for everybody
	var/turf/turf_source = get_turf(source)

 	// Looping through the player list has the added bonus of working for mobs inside containers
	for(var/mob/M in world)
		if(!M || !M.client)
			continue

		var/distance = get_dist(M, turf_source)
		if(distance <= (world.view + extrarange) * 3)
			var/turf/T = get_turf(M)

			if(T && T.z == turf_source.z)
				soundin = get_sfx(soundin)
				M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff, is_global)

/proc/get_rand_frequency()
	return rand(32000, 55000) //Frequency stuff only works with 45kbps oggs.

/mob/proc/playsound_local(var/turf/turf_source, soundin, vol as num, vary, frequency, falloff, is_global)
	var/sound/S = sound(soundin)
	S.wait = 0 //No queue
	S.channel = 0 //Any channel
	S.volume = vol
	S.environment = -1
	if (vary)
		if(frequency)
			S.frequency = frequency
		else
			S.frequency = get_rand_frequency()

	if(isturf(turf_source))
		// 3D sounds, the technology is here!
		var/turf/T = get_turf(src)

		//sound volume falloff with distance
		var/distance = get_dist(T, turf_source)

		S.volume -= max(distance - world.view, 0) * 2 //multiplicative falloff to add on top of natural audio falloff.

		//sound volume falloff with pressure


		if (S.volume <= 0)
			return	//no volume means no sound

		var/dx = turf_source.x - T.x // Hearing from the right/left
		S.x = dx
		var/dz = turf_source.y - T.y // Hearing from infront/behind
		S.z = dz
		// The y value is for above your head, but there is no ceiling in 2d spessmens.
		S.y = 1
		S.falloff = (falloff ? falloff : FALLOFF_SOUNDS)
	if(!is_global)
		S.environment = 2
	src << S

/proc/get_sfx(soundin)
	if(istext(soundin))
		switch(soundin)
			if ("rustle") soundin = pick(rustle_sound)
	return soundin
