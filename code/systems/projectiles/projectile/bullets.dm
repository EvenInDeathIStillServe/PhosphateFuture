/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	fire_sound = 'sounds/weapons/gunshot/gunshot_strong.ogg'
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	check_armour = "bullet"
	embed = 1
	var/mob_passthrough_check = 0

	muzzle_type = /obj/effect/projectile/bullet/muzzle

/obj/item/projectile/bullet/pistol
	fire_sound = 'sounds/weapons/gunshot/gunshot_pistol.ogg'
	damage = 20

/obj/item/projectile/bullet/pistol/medium
	damage = 25

/obj/item/projectile/bullet/rifle/a545x39
	damage = 20
	agony = 20
	fire_sound = 'sounds/weapons/gunshot/ak74.ogg'

/obj/item/projectile/bullet/rifle/a556x45
	damage = 20
	agony = 20
	fire_sound = 'sounds/weapons/gunshot/m16.ogg'