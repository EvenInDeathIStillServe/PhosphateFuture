/obj/machinery/budgetdisplay
	name = "budget display"
	desc = "It displays the outpost's budget."
	icon_state = "budget_profit"

/obj/machinery/budgetdisplay/examine(user)
	..()
	if(money <= 0)
		user << "The outpost is running a deficit of [money*-1] credits."
	else
		user << "The outpost budget is [money] credits."

/obj/machinery/budgetdisplay/process()
	if(money <= 0)
		icon_state = "budget_loss"
	else
		icon_state = "budget_profit"

/obj/machinery/buy
	name = "buy"
	desc = "Buy low."
	icon_state = "buy"

/obj/machinery/buy/attack_hand(user)
	if (money >= 50)
		money = money - 50
		stock = stock + 1
		user << "You buy some stocks."
	else
		user << "You can't afford any more shares!"

/obj/machinery/sell
	name = "sell"
	desc = "Sell high."
	icon_state = "sell"

/obj/machinery/sell/attack_hand(user)
	if (stock >=1)
		user << "You sell some stocks."
		money = money + 50
		stock = stock - 1
	else
		user << "You don't have any stocks!"