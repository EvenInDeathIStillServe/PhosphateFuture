/obj/multiz
	icon = 'icons/structures.dmi'
	density = 0
	opacity = 0
	anchored = 1
	var/istop = 1

	CanPass(obj/mover, turf/source)
		return !density

	proc/targetZ()
		return src.z + (istop ? -1 : 1)

/obj/multiz/stairs
	name = "stairs"
	desc = "stairs.  You walk up and down them."
	icon_state = "ramptop"
	density = 1

/obj/multiz/stairs/New()
	icon_state = istop ^ istype(src, /obj/multiz/stairs/active) ? "ramptop" : "rampbottom"

/obj/multiz/stairs/enter/bottom
	istop = 0

/obj/multiz/stairs/active

/obj/multiz/stairs/active/Bumped(var/atom/movable/M)
	M.loc = locate(src.x, src.y, targetZ())
	return 1

/obj/multiz/stairs/active/bottom
	istop = 0

/obj/multiz/stairs/active/bypass
	icon_state = "wramp"

/obj/multiz/stairs/active/bypass/bottom
	istop = 0

/obj/multiz/stairs/active/bypass/New()
	return

/obj/multiz/stairs/active/bypass/Bumped(var/atom/movable/M)
	M.loc = locate(src.x, src.y, targetZ())
	return 1