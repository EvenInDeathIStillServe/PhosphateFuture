/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/total = 0
	usr << "<B>Current Players:</B>"
	for(var/mob/M in world)
		if (M.client)
			total++
			usr << M.client
		//Foreach goto(32)
	usr << text("<B>Total Players: []</B>", total)
	return