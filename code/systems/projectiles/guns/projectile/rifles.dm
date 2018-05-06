/obj/item/weapon/gun/projectile/automatic/ak74
	name = "AK-74"
	desc = "A standard-issue Soviet Army combat rifle. Chambers 5.45x39 rounds."
	icon_state = "ak74"
	item_state = "ak74"
	w_class = 5
	load_method = MAGAZINE
	caliber = "545x39"
	ammo_type = /obj/item/ammo_casing/a545x39
	allowed_magazines = list(/obj/item/ammo_magazine/c545x39m, /obj/item/ammo_magazine/c545x39b)
	magazine_type = null
	one_hand_penalty = 3
	accuracy = 2.5
	fire_delay = 2

//	wielded_item_state = "ak74-wielded"
	fire_sound = 'sounds/weapons/gunshot/ak74.ogg'
	unload_sound = 'sounds/weapons/guns/ak74_magout.ogg'
	reload_sound = 'sounds/weapons/guns/ak74_magin.ogg'
	cocked_sound = 'sounds/weapons/guns/ak74_cock.ogg'

	var/obj/item/weapon/material/knife/bayonet/sa/knife = FALSE

	firemodes = list(
		list(mode_name="semiauto",     burst=1, fire_delay=2,    move_delay=null, one_hand_penalty=2, burst_accuracy=null,              dispersion=null,                          automatic = 0),
		list(mode_name="short bursts", burst=3, fire_delay=null, move_delay=3,    one_hand_penalty=4, burst_accuracy=list(1,1,0),       dispersion=list(0.0, 0.3, 0.6),           automatic = 0),
		list(mode_name="long bursts",  burst=5, fire_delay=null, move_delay=4,    one_hand_penalty=5, burst_accuracy=list(1,1,0,-1,-2), dispersion=list(0.3, 0.3, 0.6, 1.2, 1.5), automatic = 0),
		list(mode_name="automatic",    burst=1, fire_delay=0.5,  move_delay=null, one_hand_penalty=2, burst_accuracy=null,              dispersion=list(0.2),                     automatic = 0.7),
		)

/obj/item/weapon/gun/projectile/automatic/m16a2
	name = "M16A2"
	desc = "A standard-issue USMC combat rifle. Chambers 5.56x39 rounds."
	icon_state = "m16a2"
	item_state = "m16"
	w_class = 5
	load_method = MAGAZINE
	caliber = "556x45"
	ammo_type = /obj/item/ammo_casing/a556x45
	allowed_magazines = /obj/item/ammo_magazine/c556x45m
	magazine_type = null
	one_hand_penalty = 4
	accuracy = 3
	fire_delay = 3

//	wielded_item_state = "m16-wielded"
	fire_sound = 'sounds/weapons/gunshot/m16.ogg'
	unload_sound = 'sounds/weapons/guns/m16_magout.ogg'
	reload_sound = 'sounds/weapons/guns/m16_magin.ogg'
	cocked_sound = 'sounds/weapons/guns/m16_chargeback.ogg'

	var/obj/item/weapon/material/knife/bayonet/usmc/knife = FALSE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=4, burst_accuracy=null,       dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=3,    one_hand_penalty=5, burst_accuracy=list(2,1,1),dispersion=list(0.0, 0.3, 0.3)),
		)