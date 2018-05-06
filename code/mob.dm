/mob/Login()
	if(!loc)
		loc = locate(/turf/floor/spawnpoint)
	clients += src.client
	player_list |= src

/mob/Logout()
	clients -= src.client
	player_list -= src
/*
/mob/Move()
	if(anchored)
		return
	if(istype(src.loc,/obj/structure/closet))
		src.loc.attack_hand(src)
	var/pull = 0
	var/old_loc = loc
	if(pulling)
		if(src.z != pulling.z)
			pulling.pulledby = null
			pulling = null
		else if(get_dist(src,pulling) == 1 || (get_dir(src,pulling) in ordinal && get_dist(src,pulling) == 2))
			pull = 1
		else if(get_dist(src,pulling) > 2)
			pulling.pulledby = null
			pulling = null
	..()
	if(old_loc != loc)
		if(istype(src,/mob))
			for(var/mob/M in loc)
				if(M == src)
					continue
				if(M.stat)
					continue
				M.Move(old_loc)
		if(pull)
			step(pulling,get_dir(pulling,old_loc))
		src.Moved()
*/
/atom/movable/Move()
	if(istype(src,/obj/item/projectile))
		..()
	if(anchored)
		return
	if(istype(src.loc,/obj/structure/closet) && ismob(src))
		src.loc:attack_hand(src)
	var/pull = 0
	var/old_loc = loc
	if(pulling)
		if(src.z != pulling.z)
			pulling.pulledby = null
			pulling = null
		else if(get_dist(src,pulling) == 1 || (get_dir(src,pulling) in ordinal && get_dist(src,pulling) == 2))
			pull = 1
		else if(get_dist(src,pulling) > 2)
			pulling.pulledby = null
			pulling = null
	..()
	if(old_loc != loc)
		if(istype(src,/mob))
			for(var/mob/M in loc)
				if(M == src)
					continue
				if(M.stat)
					continue
				M.Move(old_loc)
		if(pull)
			step(pulling,get_dir(pulling,old_loc))
		src.Moved()


/*
		spawn(src.delay)
			src.move=1
*/
/atom/movable/proc/Moved()
	last_moved = world.time

/mob/verb/examinate(atom/A as mob|obj|turf in view())
	set name = "Examine"
	set category = "IC"

	if(!stat)
		face_atom(A)
	A.examine(src)
/*
/mob/Cross(var/atom/movable/AM)
	world << "listen to me"
	if(istype(AM,/mob))
		var/original_loc = src.loc
		var/target_loc = AM.loc
		src.Move(target_loc)
		AM.Move(original_loc)
*/

/*
/mob/Bumped(var/atom/movable/AM)
	if(istype(AM,/mob))
		var/original_loc = src.loc
		var/target_loc = AM.loc
		src.loc = target_loc
		AM.loc = original_loc
*/
/mob/proc/pickup(var/obj/item/pickedup)

/mob/proc/unequip(var/obj/item/unequipped)

/mob/proc/interact(var/atom/interacted)

/mob/proc/drop()

/mob/proc/getridof(var/obj/item/riddenof)

/mob/proc/get_active_hand()

/mob/proc/get_inactive_hand()

/mob/proc/put_in_hands()

/mob/proc/npc_process()

/mob
	var/obj/item/holding = null
	var/last_click = null
	var/mob_size
	var/shakecamera

	var/obj/item/r_hand = null
	var/obj/item/l_hand = null
	var/obj/item/clothing/mask = null
	var/obj/item/back = null
	var/hand = 1

	var/stat = 0

	var/npc = 0

	var/obj/screen/drop = null
	var/obj/screen/take = null
	var/obj/screen/swap = null
	var/obj/screen/righthand = null
	var/obj/screen/lefthand = null
	var/obj/screen/selector = null
	var/obj/screen/mood = null

	var/obj/item/weapon/storage/s_active = null

/mob/proc/show_message(msg)
	src << msg