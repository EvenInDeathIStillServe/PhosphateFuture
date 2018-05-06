/client
	var/move_delay = 2
	var/click_delay = 3
	var/last_moved
	var/last_told

/client/Move()
	if(world.time >= last_moved + move_delay)
		if(mob.stat)
			if(last_told + 10 < world.time)
				to_chat(src, "<span class='danger'>I'm DEAD!</span>")
				last_told = world.time
			return
		last_moved = world.time
		..()