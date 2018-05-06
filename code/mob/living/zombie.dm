/mob/living/human/zombie
	name = "zombie"
	icon_state = "zombie"
	npc = 1

/mob/living/human/zombie/New()
	if(prob(50))
		spawn_head = null
	if(prob(40))
		spawn_uniform = /obj/item/clothing/uniform/miner
	if(prob(30))
		spawn_mask = /obj/item/clothing/mask/shemagh
	if(prob(30))
		spawn_suit = /obj/item/clothing/suit/hazard
	..()

/mob/living/human/zombie/npc_process()
	if(stat)
		return
	if(!target)
		for(var/mob/living/human/H in view(7,src))
			if(H.client)
				target = H
				break
		if(prob(5))
			playsound(src, "sounds/mobs/zombie/zombie_idle[rand(1,7)].ogg", 100)
		Move(get_step(loc,pick(cardinal)))
		return

	step_to(src,target)
	if(prob(10))
		playsound(src, "sounds/mobs/zombie/zombie_sight[rand(1,7)].ogg", 100)

	if(get_dist(src,target) > 7)
		target = null