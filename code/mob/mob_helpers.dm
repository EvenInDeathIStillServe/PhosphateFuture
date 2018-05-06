/proc/check_zone(zone)
	if(!zone)	return BP_CHEST
	switch(zone)
		if(BP_EYES)
			zone = BP_HEAD
		if(BP_MOUTH)
			zone = BP_HEAD
	return zone

// Emulates targetting a specific body part, and miss chances
// May return null if missed
// miss_chance_mod may be negative.
/proc/get_zone_with_miss_chance(zone, var/mob/target, var/miss_chance_mod = 0, var/ranged_attack=0)
	zone = check_zone(zone)

	var/miss_chance = 10
/*
	if (zone in base_miss_chance)
		miss_chance = base_miss_chance[zone]
*/
	miss_chance = max(miss_chance + miss_chance_mod, 0)
	if(prob(miss_chance))
		if(prob(70))
			return null
//		return pick(base_miss_chance)
	return zone

/proc/issmall(A)
	if(A && istype(A, /mob/living))
		var/mob/living/L = A
		return L.mob_size <= MOB_SMALL
	return 0

/mob/proc/can_wield_item(obj/item/W)
	if(W.w_class >= ITEM_SIZE_LARGE && issmall(src))
		return FALSE //M is too small to wield this
	return TRUE

/proc/shake_camera(mob/M, duration, strength=1)
	if(!M || !M.client || M.shakecamera)
		return
	M.shakecamera = 1
	spawn(1)
		if(!M.client)
			return

		var/atom/oldeye=M.client.eye

		var/x
		for(x=0; x<duration, x++)
			M.client.eye = locate(dd_range(1,M.loc.x+rand(-strength,strength),world.maxx),dd_range(1,M.loc.y+rand(-strength,strength),world.maxy),M.loc.z)
			sleep(1)
		M.client.eye=oldeye
		M.shakecamera = 0

/proc/do_after(mob/user, delay, atom/target = null, needhand = 1, progress = 1)
	if(!user)
		return 0
	var/atom/target_loc = null
	var/target_type = null

	if(target)
		target_loc = target.loc
		target_type = target.type

	var/atom/original_loc = user.loc

	var/holding = user.get_active_hand()

	var/datum/progressbar/progbar
	if (progress)
		progbar = new(user, delay, target)

	var/endtime = world.time + delay
	var/starttime = world.time
	. = 1
	while (world.time < endtime)
		sleep(1)
		if (progress)
			progbar.update(world.time - starttime)

		if(!user || user.loc != original_loc)
			. = 0
			break

		if(target_loc && (!target || target_loc != target.loc || target_type != target.type))
			. = 0
			break

		if(needhand)
			if(user.get_active_hand() != holding)
				. = 0
				break

	if (progbar)
		qdel(progbar)