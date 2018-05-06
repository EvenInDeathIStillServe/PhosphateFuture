/mob/living/human/process()
	if(mood_level < 0)
		mood_level = mood_level + 0.1
	else if (mood_level > 0)
		mood_level = mood_level - 0.1
	if(client)
		switch(mood_level)
			if(-INFINITY to -4.9)
				mood.icon_state = "sad"
			if(-5 to 5)
				mood.icon_state = "neutral"
			if(5.1 to INFINITY)
				mood.icon_state = "happy"

	if(stomach.reagents.total_volume > 0)
		stomach.reagents.trans_to(stomach.reagents, 0.1, 1)

	if(burning)
		playsound(src, "sounds/mobs/flesh_burning.ogg", 100)
		damage(10, BURN)
		burning = max(0, burning - 10)
		update_icon()