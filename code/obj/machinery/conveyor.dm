/obj/machinery
	icon = 'icons/machinery.dmi'
	anchored = 1

/obj/machinery/conveyor
	name = "conveyor belt"
	desc = "It moves things around."
	icon_state = "conveyor"
	layer = OBJ_LAYER - 0.1

/obj/machinery/conveyor/attackby(var/obj/item/W, mob/user)
	user.drop(src.loc)

/obj/machinery/conveyor/west
	icon_state = "conveyor_west"

/obj/machinery/conveyor/west/south
	dir = 2

/obj/machinery/conveyor/west/north
	dir = 1

/obj/machinery/conveyor/east
	icon_state = "conveyor_east"

/obj/machinery/conveyor/east/south
	dir = 2

/obj/machinery/conveyor/east/north
	dir = 1

/obj/machinery/conveyor/north
	icon_state = "conveyor_north"

/obj/machinery/conveyor/north/east
	dir = 4

/obj/machinery/conveyor/north/west
	dir = 8

/obj/machinery/conveyor/south
	icon_state = "conveyor_south"

/obj/machinery/conveyor/south/east
	dir = 4

/obj/machinery/conveyor/south/west
	dir = 8

/obj/machinery/conveyor/process()
	spawn(1)
		for(var/atom/movable/A in src.loc.contents - src)
			if(A.loc == src.loc && !A.anchored && A.last_moved + 1 < world.time)
				step(A,src.dir)