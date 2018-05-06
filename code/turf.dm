/turf
	var/can_bullets = 0 //Can bullet holes be spawned on it?
	var/bullet_holes = 0 //How many bullets already there?

/turf/floor
	icon = 'icons/floors/floors.dmi'
	var/list/stepsound

/turf/floor/Enter()
	if(src.density)
		return 0
	for(var/obj/O in src.contents)
		if(O.density)
			return 0
	return 1

/turf/floor/attack_hand(var/mob/living/human/user)
	if(user.pulling)
		step_towards(user.pulling,src)

/turf/proc/ChangeTurf(var/turf/N)
	var/turf/W = new N(src)
	return W

/turf/floor/spawnpoint
	name = "spawn point"
	icon_state = "spawnpoint"