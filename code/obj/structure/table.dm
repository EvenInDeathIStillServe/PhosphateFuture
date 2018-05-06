/obj/structure/table
	name = "table"
	icon = 'icons/obj/structure/tables/table.dmi'
	icon_state = "0"
	density = 1
	layer = OBJ_LAYER - 0.1

/obj/structure/table/New()
	spawn(10)
		update_icon()
		for(var/obj/structure/table/T in orange(1))
			T.update_icon()

/obj/structure/table/update_icon()
	var/connectdir = 0
	for(var/direction in cardinal)
		if(locate(src.type) in get_step(src,direction))
			connectdir |= direction
	icon_state = "[connectdir]"
	for(var/o_direction in ordinal)
		if(locate(src.type) in get_step(src,o_direction))
			switch(o_direction)
				if(NORTHWEST)
					if((locate(src.type) in get_step(src, NORTH)) && (locate(src.type) in get_step(src, WEST)))
						overlays += "NW"
				if(NORTHEAST)
					if((locate(src.type) in get_step(src, NORTH)) && (locate(src.type) in get_step(src, EAST)))
						overlays += "NE"
				if(SOUTHWEST)
					if((locate(src.type) in get_step(src, SOUTH)) && (locate(src.type) in get_step(src, WEST)))
						overlays += "SW"
				if(SOUTHEAST)
					if((locate(src.type) in get_step(src, SOUTH)) && (locate(src.type) in get_step(src, EAST)))
						overlays += "SE"

/obj/structure/table/attackby(obj/item/W, mob/user, params)
	user.drop(src.loc)
	var/list/click_params = params2list(params)
	if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
		return
	W.pixel_x = CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
	W.pixel_y = CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)

/obj/structure/table/wood
	icon = 'icons/obj/structure/tables/wood_table.dmi'