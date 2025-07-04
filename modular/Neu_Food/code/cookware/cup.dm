/obj/item/reagent_containers/glass/cup
	name = "metal cup"
	desc = "A sturdy cup of metal. Often seen in the hands of warriors, wardens, and other sturdy folk."
	icon = 'modular/Neu_Food/icons/cookware/cup.dmi'
	icon_state = "iron"
	force = 5
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE
	throwforce = 10
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	experimental_inhand = FALSE
	volume = 24
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/reagent_containers/glass/cup/update_icon(dont_fill=FALSE)
	testing("cupupdate")

	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance(icon, "[icon_state]filling")

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		add_overlay(filling)

/obj/item/reagent_containers/glass/cup/wooden
	name = "wooden cup"
	desc = "This cup whispers tales of drunken battles and feasts."
	resistance_flags = FLAMMABLE
	icon_state = "wooden"
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	anvilrepair = null
	sellprice = 0

/obj/item/reagent_containers/glass/cup/steel
	name = "goblet"
	desc = "A steel goblet, its surface adorned with intricate carvings."
	icon_state = "steel"
	sellprice = 10

/obj/item/reagent_containers/glass/cup/aalloymug
	name = "decrepit mug"
	desc = "A decrepit mug. Aeon's grasp is upon its form."
	icon_state = "amug"

/obj/item/reagent_containers/glass/cup/aalloygob
	name = "decrepit goblet"
	desc = "A decrepit goblet. Aeon's grasp is upon its form."
	icon_state = "agoblet"
	sellprice = 0

/obj/item/reagent_containers/glass/cup/silver
	name = "silver goblet"
	desc = "A silver goblet, its surface adorned with intricate carvings and runes."
	icon_state = "silver"
	sellprice = 30
	last_used = 0
	is_silver = TRUE

/obj/item/reagent_containers/glass/cup/silver/small
	name = "silver cup"
	desc = "A silver cup, its surface adorned with intricate carvings and runes."
	icon_state = "scup"
	sellprice = 20

/obj/item/reagent_containers/glass/cup/silver/pickup(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.adjustFireLoss(25)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)

/obj/item/reagent_containers/glass/cup/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && H.dna.species)
			if(istype(H.dna.species, /datum/species/werewolf))
				M.Knockdown(10)
				M.Paralyze(10)
				M.adjustFireLoss(25)
				H.fire_act(1,10)
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				return FALSE
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord))
		M.adjustFireLoss(25)
		M.fire_act(1,10)
		to_chat(M, span_userdanger("I can't pick up the silver, it is my BANE!"))
		return FALSE

/obj/item/reagent_containers/glass/cup/golden
	name = "golden goblet"
	desc = "Adorned with gemstones, this goblet radiates opulence and grandeur."
	icon_state = "golden"
	sellprice = 50

/obj/item/reagent_containers/glass/cup/golden/small
	name = "golden cup"
	desc = "Adorned with gemstones, this cup radiates opulence and grandeur."
	icon_state = "gcup"
	sellprice = 40

/obj/item/reagent_containers/glass/cup/golden/poison
	name = "golden goblet"
	desc = "Adorned with gemstones, this goblet radiates opulence and grandeur."
	icon_state = "golden"
	sellprice = 50
	list_reagents = list(/datum/reagent/toxin/killersice = 1, /datum/reagent/consumable/ethanol/elfred = 20)

/obj/item/reagent_containers/glass/cup/skull
	name = "skull goblet"
	desc = "The hollow eye sockets tell me of forgotten, dark rituals."
	icon_state = "skull"

/obj/item/reagent_containers/glass/cup/ceramic
	name = "teacup"
	desc = "A tea cup made out of ceramic. Used to serve tea."
	dropshrink = 0.7
	icon_state = "cup"
	sellprice = 10

/obj/item/reagent_containers/glass/cup/ceramic/examine()
	. = ..()
	. += span_info("It can be brushed with a dye brush to glaze it.")

/obj/item/reagent_containers/glass/cup/ceramic/attackby(obj/item/I, mob/living/carbon/human/user)
	. = ..()
	if(istype(I, /obj/item/dye_brush))
		if(reagents.total_volume)
			to_chat(user, span_notice("I can't glaze the cup while it has liquid in it."))
			return
		if(do_after(user, 2 SECONDS, target = src))
			to_chat(user, span_notice("I glaze the cup with the dye brush."))
			new /obj/item/reagent_containers/glass/cup/ceramic/fancy(get_turf(src))
			qdel(src)
		return

/obj/item/reagent_containers/glass/cup/ceramic/fancy
	name = "fancy teacup"
	desc = "A fancy tea cup made out of ceramic. Used to serve tea."
	icon_state = "cup_fancy"
	sellprice = 12
