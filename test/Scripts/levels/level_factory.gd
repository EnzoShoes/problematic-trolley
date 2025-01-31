class_name LevelFactory
extends Node

static var possible_victims : Array = []:
	get():
		return possible_victims_per_glitch[Glitch.active_glitch]

static var possible_victims_per_glitch : Dictionary = {
	Glitch.glitches.NONE : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.AI_UPLOADING : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.OPPRESSIVE_SOCIETY : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL],
	Glitch.glitches.UTILITY_MONSTER : [Globals.victim_types.BAD, Globals.victim_types.BABY, Globals.victim_types.RICH, Globals.victim_types.OLD, Globals.victim_types.NORMAL, Globals.victim_types.UTIL_MONSTER]
}

static var mandatory_victims_per_glitch : Dictionary = {
	Glitch.glitches.NONE : [],
	Glitch.glitches.AI_UPLOADING : [Globals.victim_types.RICH],
	Glitch.glitches.OPPRESSIVE_SOCIETY : [Globals.victim_types.NORMAL],
	Glitch.glitches.UTILITY_MONSTER : [Globals.victim_types.UTIL_MONSTER]
}

static var premade_lvls_map = {
	"lvl_1" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL]
	}, # Basic trolley probleme
	"lvl_2" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.OLD]
	}, # Comparing old and normal
	"lvl_3" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BABY]
	}, # Comparing baby and normal
	"lvl_4" : {
		"top" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BABY]
	}, # Comparing baby with normal, but normal wins. 
	"lvl_5" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.NORMAL]
	}, # Comparing normal with normal, to show that you win on even. 
	# Next trust phase
	"lvl_6" : {
		"top" : [Globals.victim_types.RICH],
		"bot" : [Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BAD]
	}, # Comparing rich with baby, but baby wins.
	"lvl_7" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.OLD]
	}, # Comparing normal with bad (bad cannot win)
	"lvl_8" : {
		"top" : [Globals.victim_types.BABY],
		"bot" : [Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,]
	}, # Comparing baby with rich (obvious)
	"lvl_9" : {
		"top" : [Globals.victim_types.BABY],
		"bot" : [Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,Globals.victim_types.RICH,]
	}, # Comparing baby with rich (obvious)
	"lvl_10" : {
		"top" : [Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD],
		"bot" : [Globals.victim_types.BABY]
	}, # Comparing old and baby, but old wins. 
# Next trust phase
	"lvl_11" : {
		"top" : [Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD],
		"bot" : [Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY]
	}, # Let's start with an obvious one. 
	"lvl_12" : {
		"top" : [Globals.victim_types.RICH, Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BAD,Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD]
	}, # Rich normal vs BABYx2, but with a bunch of BAD.
	"lvl_13" : {
		"top" : [Globals.victim_types.RICH, Globals.victim_types.RICH, Globals.victim_types.BAD, Globals.victim_types.BAD],
		"bot" : [Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY,Globals.victim_types.BABY]
	}, # Rich normal vs Babies (win), vs RICH bad
	"lvl_14" : {
		"top" : [Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD],
		"bot" : [Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD]
	}, # Before the final one
	"lvl_15" : {
		"top" : [Globals.victim_types.RICH, Globals.victim_types.RICH, Globals.victim_types.RICH, Globals.victim_types.RICH, ],
		"bot" : [Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD, Globals.victim_types.BAD,Globals.victim_types.BAD,Globals.victim_types.BAD]
	} # Final one. 
} 

static var tutorial_lvls_map = {
	"lvl_1" : {
		"top" : [Globals.victim_types.NORMAL],
		"bot" : [Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL, Globals.victim_types.NORMAL]
	},
	"lvl_2" : {
		"top": [Globals.victim_types.BABY],
		"bot": [Globals.victim_types.NORMAL]
	},
	"lvl_3" : {
		"top": [Globals.victim_types.OLD],
		"bot": [Globals.victim_types.NORMAL]
	},
	"lvl_4" : {
		"top": [Globals.victim_types.BABY],
		"bot": [Globals.victim_types.RICH]
	},
	"lvl_5" : {
		"top": [Globals.victim_types.OLD],
		"bot": [Globals.victim_types.BAD]
	},
	"lvl_6" : {
		"top": [Globals.victim_types.OLD, Globals.victim_types.OLD, Globals.victim_types.OLD],
		"bot": [Globals.victim_types.RICH]
	}
}

static func new_random_lvl(max_ppl_on_tracks : int) -> Dictionary:
	var random_lvl : Dictionary = {
		"top" : [],
		"bot" : []
	}
	
	var chosen_track = random_lvl.keys().pick_random()
	for victim_type in mandatory_victims_per_glitch[Glitch.active_glitch]:
		random_lvl[chosen_track].append(victim_type)
	
	### Dirty quick fix
	var min_ppl_on_tracks: int
	if max_ppl_on_tracks == 0 or max_ppl_on_tracks == 1:
		min_ppl_on_tracks = 2
		max_ppl_on_tracks = 2
	else: 
		min_ppl_on_tracks = max_ppl_on_tracks -1
		
	
	for i in range(randi_range(min_ppl_on_tracks,max_ppl_on_tracks)):
		random_lvl["top"].append(randi_range(0,len(possible_victims)-1))
	for i in range(randi_range(max_ppl_on_tracks-1,max_ppl_on_tracks)):
		random_lvl["bot"].append(randi_range(0,len(possible_victims)-1))
	
	return random_lvl
