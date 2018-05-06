/atom
	var/tmp/move = 1
	var/delay = 2
	var/anchored = 0

/atom/proc/examine(mob/user)
	if(istype(src,/mob/living/human))
		var/mob/living/human/M = src
		var/sub_pronoun
		var/poss_adjective
		var/data
		if(M == user)
			data += "<span class='notice'>Hey! It's me, \icon[src] <b>[src]!</b></span><br>"
			sub_pronoun = "I'm"
			poss_adjective = "my"
		else
			data += "<span class='notice'>That's our friend, \icon[src] <b>[src].</b></span><br>"
			sub_pronoun = "They're"
			poss_adjective = "their"
		if(M.head)
			data += "<span class='notice'>[sub_pronoun] wearing [M.head] \icon[M.head] on [poss_adjective] head.</span><br>"
		if(M.glasses)
			data += "<span class='notice'>[sub_pronoun] wearing [M.glasses] \icon[M.glasses] on [poss_adjective] eyes.</span><br>"
		if(M.mask)
			data += "<span class='notice'>[sub_pronoun] wearing [M.mask] \icon[M.mask]  on [poss_adjective] face.</span><br>"
		if(M.uniform)
			data += "<span class='notice'>[sub_pronoun] wearing [M.uniform] \icon[M.uniform].</span><br>"
		if(M.suit)
			data += "<span class='notice'>[sub_pronoun] wearing [M.suit] \icon[M.suit].</span><br>"
		if(M.back)
			data += "<span class='notice'>[sub_pronoun] carrying [M.back] \icon[M.back] on [poss_adjective] back.</span><br>"
		if(M.gloves)
			data += "<span class='notice'>[sub_pronoun] wearing [M.gloves] \icon[M.gloves] on [poss_adjective] hands.</span><br>"
		if(M.shoes)
			data += "<span class='notice'>[sub_pronoun] wearing [M.shoes] \icon[M.shoes]  on [poss_adjective] feet.</span><br>"
		switch(M.health)
			if(100)
				data += "<span class='notice'>[sub_pronoun] perfectly healthy.</span>"
			if(60 to 99)
				data += "<span class='red'>[sub_pronoun] slightly wounded.</span>"
			if(1 to 59)
				data += "<span class='danger'>[sub_pronoun] severely wounded.</span>"
			if(-INFINITY to 0)
				data += "<span class='danger'>[sub_pronoun] DEAD!</span>"

		user << data
	else
		user << "That's \icon[src] \a <b>[src]</b>. [src.desc]"

/datum/master_controller/New()
	spawn(1)
		process()

/datum/master_controller/proc/process()
	for(var/obj/machinery/M in world)
		M.process()
	spawn(10)
		process()

/datum/life_controller/New()
	spawn(1)
		process()

/datum/life_controller/proc/process()
	for(var/mob/M in world)
		M.process()
	spawn(10)
		process()

/datum/puppet_master/New()
	spawn(1)
		process()

/datum/puppet_master/proc/process()
	for(var/mob/M in NPCs)
		spawn(rand(0,4))
			M.npc_process()
	spawn(10)
		process()

// Should be treated as a replacement for the 'del' keyword.
// Datums passed to this will be given a chance to clean up references to allow the GC to collect them.
/proc/qdel(var/datum/A)
	if(!A)
		return
/*
	if(!istype(A))
		log_error("qdel() was passed [log_info_line(A)]. qdel() can only handle instances of (sub)type /datum.")
		crash_with("qdel() was passed [log_info_line(A)]. qdel() can only handle instances of (sub)type /datum.")

	else if(isnull(A.gcDestroyed))
		// Let our friend know they're about to get collected
		. = !A.Destroy()
*/
	A.Destroy()
	if(. && A)
		A.finalize_qdel()

/datum/proc/finalize_qdel()
	del(src)

/atom/proc/process()

/proc/get_turf(atom/location)
	while(location)
		if(isturf(location))
			return location
		location = location.loc
	return null

/proc/in_range(source, user)
	if(get_dist(source, user) <= 1)
		return 1

/proc/get_area(atom/A)
	if (!istype(A))
		return
	for(A, A && !isarea(A), A=A.loc); //semicolon is for the empty statement
	return A