/mob/living/human/npc
	name = "NPC"
	npc = 1

/mob/living/human/npc/npc_process()
	if(stat)
		return
	Move(get_step(loc,pick(cardinal)))