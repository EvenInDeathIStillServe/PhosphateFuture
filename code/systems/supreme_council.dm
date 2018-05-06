/datum/supreme_council
	var/mandate = 0

/datum/supreme_council/New()
	spawn(1)
		process()

/datum/supreme_council/proc/process()
	spawn(3000)
		mandate = rand(5,10)
		process()