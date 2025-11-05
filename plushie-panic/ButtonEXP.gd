extends Pickups
class_name ButtonEXP

@export var EXP : float

func activate():
	super.activate()
	prints("+" + str(EXP) + "EXP")
	player_reference.gain_EXP(EXP) #activating EXP will make player gain xp
	
