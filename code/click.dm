/atom/Click(location,control,params)
	if(src)
		usr.ClickOn(src, params)
/atom/DblClick(location,control,params)
	if(src)
		usr.DblClickOn(src,params)

/mob/proc/ClickOn(var/atom/A, params)
	var/list/modifiers = params2list(params)
	if(src.move && !stat)
		face_atom(A)
	if(last_click + client.click_delay > world.time)
		return
	if(modifiers["middle"])
		MiddleClickOn(A)
		return
	if(modifiers["shift"])
		ShiftClickOn(A)
		return
	if(modifiers["alt"]) // alt and alt-gr (rightalt)
		AltClickOn(A)
		return
	if(modifiers["ctrl"])
		CtrlClickOn(A)
		return
	var/obj/item/W = get_active_hand()
	if(W == A)
		W.attack_self(src)
		return 1

	if(get_dist(src,A) <= 1 || A.loc == src)
		src.interact(A, params)

	else if(W && !istype(A,/obj/screen))
		if(get_dist(src,A) > 1)
			W.afterattack(A, src, 0, params)
	last_click = world.time

/mob/proc/DblClickOn(var/atom/A, var/params)
	ClickOn(A,params)

/mob/proc/MiddleClickOn(var/atom/A)
	return

/mob/living/human/MiddleClickOn(var/atom/A)
	swap_hand()

/mob/proc/ShiftClickOn(var/atom/A)
	A.ShiftClick(src)
	return

/atom/proc/ShiftClick(var/mob/user)
	if(user.client && user.client.eye == user)
		user.examinate(src)
	return

/mob/proc/CtrlClickOn(var/atom/A)
	A.CtrlClick(src)
	return

/atom/proc/CtrlClick(var/mob/user)
	return

/atom/movable/CtrlClick(var/mob/user)
	if(!src.anchored)
		if(user.pulling == src)
			src.pulledby = null
			user.pulling = null
			return
		if(user.pulling)
			user.pulling.pulledby = null
		user.pulling = src
		src.pulledby = user

/mob/proc/AltClickOn(var/atom/A)
	A.AltClick(src)
	return

/atom/proc/AltClick(var/mob/user)
	/*
	var/turf/T = get_turf(src)
	if(T && user.TurfAdjacent(T))
		if(user.listed_turf == T)
			user.listed_turf = null
		else
			user.listed_turf = T
			user.client.statpanel = T.name */
	return

// Proximity_flag is 1 if this afterattack was called on something adjacent, in your square, or on your person.
// Click parameters is the params string from byond Click() code, see that documentation.
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	return

/mob/proc/canClick()
	if(last_click + client.click_delay  < world.time)
		return 1
	return 0

/mob/proc/face_atom(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)	direction = NORTH
		else		direction = SOUTH
	else
		if(dx > 0)	direction = EAST
		else		direction = WEST
	if(direction != dir)
		dir = direction
