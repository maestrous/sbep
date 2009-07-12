local DoorControllerTable = {
			[ "models/SmallBridge/Panels/sbpaneldoor.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldooriris.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneliris.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldoorwide2.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldoordw.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl"	] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldockin.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldockout.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Ship Parts/sbhulldseb.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Ship Parts/sbhulldst.mdl"			] = 65.1  ,
			[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		] = 65.1  ,
			[ "models/SmallBridge/Panels/sbpaneldbsmall.mdl"		] = 130.2 ,
			[ "models/Slyfo/SLYpaneldoor1.mdl"						] = 0
						}

for k,v in pairs( DoorControllerTable ) do

	list.Set( "SBEP_DoorControllerModels", k , v )

end