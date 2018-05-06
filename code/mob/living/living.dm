/mob/living
	var/health = 100
	var/mob/target
	var/skeleton

/mob/living/proc/die()
	if(ishuman(src))
		var/mob/living/human/H = src
		H.drop_r_hand()
		H.drop_l_hand()
	density = 0
	layer = BELOW_MOB_LAYER
	pixel_y -= 10
	transform = turn(transform,90)
	update_icon()

/mob/living/proc/damage(var/damage, var/dam_type)
	health -= damage
	if(dam_type == BRUTE && !skeleton && prob(50))
		var/obj/effects/blood/B = locate() in src.loc
		if(!B)
			new /obj/effects/blood(src.loc)
	if(dam_type == BURN && !skeleton && health <= -50)
		skeleton = 1
		icon_state = "skeleton"
		update_icon()
	if(stat)
		return
	if(health <= 0)
		stat = DEAD
		die()

/mob/living/proc/heal(var/heal)
	health = min(100,health += heal)