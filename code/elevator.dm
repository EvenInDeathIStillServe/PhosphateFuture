area/elevator
	name = "elevator"
	icon_state = "elevator"
	var/id = 1

area/elevator/proc/move_contents(var/levels, var/goback = 0)
	var/list/A = src.contents
	for(var/atom/movable/B in A)
		if(goback)
			B.Move((locate(B.x, B.y, B.z - levels)))
		else
			B.Move((locate(B.x, B.y, B.z + levels)))