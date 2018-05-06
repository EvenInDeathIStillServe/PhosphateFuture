/atom/proc/Adjacent(var/atom/neighbor) // basic inheritance, unused
	return 0

/atom/movable/Adjacent(var/atom/neighbor)
	if(neighbor == loc) return 1
	if(!isturf(loc)) return 0
	for(var/turf/T in locs)
		if(isnull(T)) continue
		if(T.Adjacent(neighbor,src)) return 1
	return 0