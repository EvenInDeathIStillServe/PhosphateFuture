/obj/structure/window
	name = "window"
	desc = "Let the light through!"
	icon_state = "window"
	density = 1
	var/health = 30

/obj/structure/window/bullet_act(var/obj/item/projectile/P)
	health -= P.damage
	playsound(src, "sounds/effects/hit_on_shattered_glass.ogg", 100, 1)
	if(health <= 0)
		playsound(src, "sounds/effects/Glassbr[rand(1,3)].ogg", 100, 1)
		for(var/i=rand(1,3), i>0, i--)
			new /obj/item/weapon/glass_shard(src.loc)
		qdel(src)