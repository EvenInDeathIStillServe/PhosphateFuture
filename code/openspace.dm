/turf/floor/openspace
	name = "open space"
	icon_state = "openspace"
	var/turf/floorbelow

/turf/floor/openspace/New()
	getbelow()

/turf/floor/openspace/proc/getbelow()
	floorbelow = locate(src.x, src.y, src.z - 1)

/turf/floor/openspace/Enter(var/atom/movable/O, var/atom/oldloc)
	if(..())
		spawn(1)
			O.loc = floorbelow
			floorbelow.Enter(usr)
			O << "You fall down!"