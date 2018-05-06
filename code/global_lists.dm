var/global/list/chemical_reagents_list				//list of all /datum/reagent datums indexed by reagent id
var/global/list/hair_styles = list()
var/global/list/facial_hair_styles = list()
#define subtypesof(typepath) ( typesof(typepath) - typepath )

/proc/make_datum_references_lists()

	for(var/path in subtypesof(/datum/sprite_accessory/hair))
		var/datum/sprite_accessory/D = new path()
		hair_styles[D.name] = D
	for(var/path in subtypesof(/datum/sprite_accessory/facial_hair))
		var/datum/sprite_accessory/D = new path()
		facial_hair_styles[D.name] = D