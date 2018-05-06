world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)

// Make objects move 8 pixels per tick when walking

mob
	step_size = 32

obj
	step_size = 32


var/datum/master_controller = new /datum/master_controller()
var/datum/life_controller = new /datum/life_controller()
var/datum/puppet_master = new /datum/puppet_master()
var/money = 100
var/stock = 0
var/list/player_list = list()
var/list/clients = list()
var/list/NPCs = list()

var/datum/supreme_council/SupremeCouncil = new /datum/supreme_council()

world/New()

	make_datum_references_lists() //initialises global lists for referencing frequently used datums (so that we only ever do it once)