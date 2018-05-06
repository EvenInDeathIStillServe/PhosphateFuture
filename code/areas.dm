/area
	icon = 'icons/areas.dmi'
	icon_state = "area"
	layer = 20
	invisibility = 101
	var/list/ambience = list()

/area/Entered(A)
	..()
	if(!istype(A,/mob))
		return
	var/mob/L = A
	if(!L.ckey)
		return

	play_ambience(L)

/area/proc/play_ambience(var/mob/L)
	if(!L.client.ambience_playing)
		L.client.ambience_playing = 1
		L << sound('sounds/ambience/TheAuroraPrinciple-Sen.ogg', repeat = 1, wait = 0, volume = 35, channel = 2)
	if(src.ambience.len && prob(35))
		if((world.time >= L.client.played + 600))
			var/sound = pick(ambience)
			L << sound(sound, repeat = 0, wait = 0, volume = 25, channel = 1)
			L.client.played = world.time