/atom/movable
	var/atom/movable/pulling
	var/atom/movable/pulledby
	var/last_moved

/atom/movable/Bump(var/atom/A as mob|obj|turf|area)
	A.Bumped(src)
	..()

/atom/movable/Bumped(var/atom/movable/AM)
	if(anchored)
		return
	var/to_go = get_dir(AM,src)
	step(src,to_go)

/atom/movable/New()
	..()
	initialize()

/atom/movable/proc/initialize()

/atom/movable/proc/forceMove(atom/destination)
	if(loc == destination)
		return 0
	var/is_origin_turf = isturf(loc)
	var/is_destination_turf = isturf(destination)
	// It is a new area if:
	//  Both the origin and destination are turfs with different areas.
	//  When either origin or destination is a turf and the other is not.
	var/is_new_area = (is_origin_turf ^ is_destination_turf) || (is_origin_turf && is_destination_turf && loc.loc != destination.loc)

	var/atom/origin = loc
	loc = destination

	if(origin)
		origin.Exited(src, destination)
		if(is_origin_turf)
			for(var/atom/movable/AM in origin)
				AM.Uncrossed(src)
			if(is_new_area && is_origin_turf)
				origin.loc.Exited(src, destination)

	if(destination)
		destination.Entered(src, origin)
		if(is_destination_turf) // If we're entering a turf, cross all movable atoms
			for(var/atom/movable/AM in loc)
				if(AM != src)
					AM.Crossed(src)
			if(is_new_area && is_destination_turf)
				destination.loc.Entered(src, origin)
	return 1

//I thought this would help with the open space bug. It didn't. Shame.
/*
/atom/movable/proc/forceMove(atom/destination)
	if(destination)
		if(pulledby)
			pulledby.pulling = null
		var/atom/oldloc = loc
		if(oldloc)
			oldloc.Exited(src, destination)
		loc = destination
		destination.Entered(src, oldloc)
		var/area/old_area = get_area(oldloc)
		var/area/destarea = get_area(destination)
		if(old_area != destarea)
			destarea.Entered(src)
		for(var/atom/movable/AM in destination)
			if(AM == src)
				continue
			AM.Crossed(src)
		return 1
	return 0
*/