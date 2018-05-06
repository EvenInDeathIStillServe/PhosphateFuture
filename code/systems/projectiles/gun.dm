/*
	Defines a firing mode for a gun.

	A firemode is created from a list of fire mode settings. Each setting modifies the value of the gun var with the same name.
	If the fire mode value for a setting is null, it will be replaced with the initial value of that gun's variable when the firemode is created.
	Obviously not compatible with variables that take a null value. If a setting is not present, then the corresponding var will not be modified.
*/
/datum/firemode
	var/name = "default"
	var/list/settings = list()

/datum/firemode/New(obj/item/weapon/gun/gun, list/properties = null)
	..()
	if(!properties) return

	for(var/propname in properties)
		var/propvalue = properties[propname]

		if(propname == "mode_name")
			name = propvalue
		else if(isnull(propvalue))
			settings[propname] = gun.vars[propname] //better than initial() as it handles list vars like burst_accuracy
		else
			settings[propname] = propvalue

/datum/firemode/proc/apply_to(obj/item/weapon/gun/gun)
	for(var/propname in settings)
		gun.vars[propname] = settings[propname]

/obj/item/weapon/gun
	name = "gun"
	desc = "Its a gun. It's pretty terrible, though."
	icon = 'icons/obj/gun.dmi'
	icon_state = "detective"
	item_state = "gun"
	slot_flags = SLOT_BELT

	var/burst = 1
	var/fire_delay = 6 	//delay after shooting before the gun can be used again
	var/burst_delay = 2	//delay between shots, if firing in bursts
	var/move_delay = 1
	var/screen_shake = 0
	var/silenced = 0
	var/accuracy = 0   //accuracy is measured in tiles. +1 accuracy means that everything is effectively one tile closer for the purpose of miss chance, -1 means the opposite. launchers are not supported, at the moment.
	var/scoped_accuracy = null
	var/list/burst_accuracy = list(0) //allows for different accuracies for each shot in a burst. Applied on top of accuracy
	var/list/dispersion = list(0)
	var/one_hand_penalty
	var/fire_sound = 'sounds/weapons/gunshot/gunshot.ogg'
	var/fire_sound_text = "gunshot"
	var/unload_sound 	= 'sounds/weapons/flipblade.ogg'
	var/reload_sound 	= null //We don't want these for guns that don't have them.
	var/cocked_sound 	= null
	var/safety = 1 //Whether or not the safety is on.

	var/automatic = 0  //can gun use it, 0 is no, anything above 0 is the delay between clicks in ds
	var/obj/item/ammo_magazine/ammo_magazine = null
	var/next_fire_time = 0

	var/sel_mode = 1 //index of the currently selected mode
	var/list/firemodes = list()

/obj/item/weapon/gun/New()
	..()
	for(var/i in 1 to firemodes.len)
		firemodes[i] = new /datum/firemode(src, firemodes[i])

	if(isnull(scoped_accuracy))
		scoped_accuracy = accuracy

/obj/item/weapon/gun/afterattack(atom/A, mob/living/user, adjacent, params)

	Fire(A,user,params) //Otherwise, fire normally.

/obj/item/weapon/gun/attack(atom/A, mob/living/user, adjacent, params)

	Fire(A,user,params,1) //Point blank!!

/obj/item/weapon/gun/attack_self(mob/user)
	var/datum/firemode/new_mode = switch_firemodes(user)
	if(new_mode)
		to_chat(user, "<span class='notice'>\The [src] is now set to [new_mode.name].</span>")

/obj/item/weapon/gun/proc/switch_firemodes()
	if(firemodes.len <= 1)
		return null

	sel_mode++
	if(sel_mode > firemodes.len)
		sel_mode = 1
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.apply_to(src)

	return new_mode

/obj/item/weapon/gun/proc/Fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0)

	if(!user || !target) return
	if(target.z != user.z) return

	if(world.time < next_fire_time)
		if (world.time % 3) //to prevent spam
			to_chat(user, "<span class='warning'>[src] is not ready to fire again!</span>")
		return


	var/shoot_time = (burst - 1)* burst_delay//burst - bullets count for one gun's burst so 1*0 = 0?
	user.setClickCooldown(shoot_time) //no clicking on things while shooting
	user.setMoveCooldown(shoot_time)

	//actually attempt to shoot
	var/turf/targloc = get_turf(target) //cache this in case target gets deleted during shooting, e.g. if it was a securitron that got destroyed.
	for(var/i in 1 to burst)
		var/obj/projectile = consume_next_projectile(user)
		if(!projectile)
			handle_click_empty(user)
			return

		process_accuracy(projectile, user, target, i)

		if(pointblank)
			process_point_blank(projectile, user, target)

		if(process_projectile(projectile, user, target, pick(BP_CHEST,BP_HEAD), clickparams))
			handle_post_fire(user, target, pointblank, reflex)
			update_icon()

		if(i < burst)
			sleep(burst_delay)

		if(!(target && target.loc))
			target = targloc
			pointblank = 0

	next_fire_time = world.time + fire_delay

//called if there was no projectile to shoot
/obj/item/weapon/gun/proc/handle_click_empty(mob/user)
	if (user)
		user.visible_message("*click click*", "<span class='danger'>*click*</span>")
	else
		src.visible_message("*click click*")
	playsound(src.loc, 'sounds/weapons/empty.ogg', 100, 1)

/obj/item/weapon/gun/proc/process_accuracy(obj/projectile, mob/user, atom/target, var/burst, var/held_twohanded)
	var/obj/item/projectile/P = projectile
	if(!istype(P))
		return //default behaviour only applies to true projectiles

	var/acc_mod = burst_accuracy[min(burst, burst_accuracy.len)]
	var/disp_mod = dispersion[min(burst, dispersion.len)]

	//Accuracy modifiers
	P.accuracy = accuracy + acc_mod
	P.dispersion = disp_mod + (dispersion_modifyer / 2)//disp_mod see in click.dm

//obtains the next projectile to fire
/obj/item/weapon/gun/proc/consume_next_projectile()
	return null

//does the actual launching of the projectile
/obj/item/weapon/gun/proc/process_projectile(obj/projectile, mob/user, atom/target, var/target_zone, var/params=null)
	var/obj/item/projectile/P = projectile
	if(!istype(P))
		return 0 //default behaviour only applies to true projectiles

	if(params)
		P.set_clickpoint(params)

	//shooting while in shock
	var/x_offset = 0
	var/y_offset = 0

	var/launched = !P.launch_from_gun(target, user, src, target_zone, x_offset, y_offset)

	if(launched)
		play_fire_sound(user,P)

	return launched

/obj/item/weapon/gun/proc/play_fire_sound(var/mob/user, var/obj/item/projectile/P)
	var/shot_sound = (istype(P) && P.fire_sound)? P.fire_sound : fire_sound
	if(silenced)
		playsound(user, shot_sound, 10, 1)
	else
		playsound(user, shot_sound, 50, 1)

/obj/item/weapon/gun/proc/process_point_blank(obj/projectile, mob/user, atom/target)
	var/obj/item/projectile/P = projectile
	if(!istype(P))
		return //default behaviour only applies to true projectiles

	//default point blank multiplier
	var/damage_mult = 1.3

	P.damage *= damage_mult

//called after successfully firing
/obj/item/weapon/gun/proc/handle_post_fire(mob/user, atom/target, var/pointblank=0, var/reflex=0)
	if(!silenced)
		if(reflex)
			user.visible_message(
				"<span class='reflex_shoot'><b>\The [user] fires \the [src][pointblank ? " point blank at \the [target]":""] by reflex!</b></span>",
				"<span class='reflex_shoot'>You fire \the [src] by reflex!</span>",
				"You hear a [fire_sound_text]!"
			)
		else
			user.visible_message(
				"<span class='danger'>\The [user] fires \the [src][pointblank ? " point blank at \the [target]":""]!</span>",
				"<span class='warning'>You fire \the [src]!</span>",
				"You hear a [fire_sound_text]!"
				)
	if(screen_shake)
		spawn()
			shake_camera(user, screen_shake+1, screen_shake)
	update_icon()

/obj/item/weapon/gun/proc/cock_gun(mob/user)//Not really sure what the point of this is. I just plays a sound.
	set waitfor = 0
	if(cocked_sound)
		sleep(3)
		if(user && loc) playsound(user, cocked_sound, 100, 1)