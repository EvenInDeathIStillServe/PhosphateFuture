/atom
	var/pass_flags = 0
	var/flags = 0

/atom/proc/attackby(obj/item/W, mob/user)

/atom/proc/attack_hand(mob/user)

/atom/proc/update_icon()

/atom/proc/Bumped(AM as mob|obj)
	return

/atom/proc/CanPass(atom/movable/mover, turf/target)
	return !density

/atom/proc/CheckExit()
	return 1

//Hook for running code when a dir change occurs
/atom/proc/setDir(newdir)
	dir = newdir

/atom/proc/set_density(var/new_density)
	if(density != new_density)
		density = !!new_density

/atom/proc/bullet_act(obj/item/projectile/P, def_zone)
	P.on_hit(src, 0, def_zone)
	. = 0

/atom/proc/visible_message(msg)
	viewers(src) << msg

/atom/proc/contains(var/atom/location)
	if(!location)
		return 0
	if(location == src)
		return 1

	return contains(location.loc)

/atom/movable/proc/dropInto(var/atom/destination)
	while(istype(destination))
		var/atom/drop_destination = destination.onDropInto(src)
		if(!istype(drop_destination) || drop_destination == destination)
			return forceMove(destination)
		destination = drop_destination
	return forceMove(null)

/atom/proc/onDropInto(var/atom/movable/AM)
	return // If onDropInto returns null, then dropInto will forceMove AM into us.

/atom/movable/onDropInto(var/atom/movable/AM)
	return loc // If onDropInto returns something, then dropInto will attempt to drop AM there.