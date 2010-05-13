/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PART ASSEMBLER

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*  I would recommend using an advanced text editor such as Notepad++, with lua syntax highlighting, to aid in making sure brackets and
general syntax are correct, and generally making the whole thing slightly less horrendous to read.		

It has also just occurred to me that it would be beneficial to only do this when the tool is first equipped in any given game, at least clientside - 
preventing the vast amount of memory-hogging that is performed on load at the moment.		*/

/* TYPE CODES:
	
	Smallbridge:
		SWSH - Single width, single height
		DWSH - Double width, single height
		SWDH - Single width, double height
		DWDH - Double width, double height
		LRC1, LRC2, LRC3, LRC4, LRC5, LRC6 - Landing ramps 1-6
		ESML - Elevator, small
		ELRG	- Elevator, large

	Medbridge:
	
	
	Modbridge:

----------------------------------------------------------------------------------------------------------------------------------------
As you can see, there are currently no types assigned for Medbridge or Modbridge.

To add a type, navigate to SBEP_Experimental/materials/sprites. Duplicate an existing VMT (essentially a text file) and change its name to your new
type. Create an image for your type, and use VTFEdit to convert it to a VTF. (VTFs have to have dimensions that are powers of two - however, your 
sprite can still be shown with the aspect ratio you want, so just convert it with the closest aspect ratio clamps you can see.

Then, navigate to SBEP_Experimental/lua/entities/sbep_base_sprite. Open init.lua and add your new type to the SRT table at the top. Its value, true
or false, is simply whether you want it to rotate or not - the elevator type has the ability to rotate in 90 degree increments, for example, whereas the rest
are all one-orientation-only.

Then open cl_init.lua and make a new entry in the MatTab table at the top, for your new type. The Material() function gets your sprite, so put the right
filename in there, and then in the second entry, put the dimensions you want your sprite to be rendered with.
----------------------------------------------------------------------------------------------------------------------------------------
	
*/

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																EXAMPLEBRIDGE															      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local EXB_PAD = {
	
	-- Example entries. The keys are the model paths - this is how the tool looks up the model - and the values are a table, which itself contains one table for each attachment point.
	Each point has a type, a position, and an orientation. (The latter two are both relative to the model origin.)
	
	[ "MODEL PATH"								] = { { type = "TYPE CODE" , pos = VECTOR POSITION, dir = ANGLE ORIENTATION} , 
						Second attachment point - 		{ type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } } ,
	
	[ "models/smallbridge/hulls,sw/sbhullcurvel.mdl"			] = { { type = "SWSH" , pos = Vector(  446.4 ,-334.8,  0  ) , dir = Angle(  0,  0,  0) } , 
												{ type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } } ,

	[ "models/smallbridge/hulls,sw/sbhullcurvel.mdl"			] = { { type = "SWSH" , pos = Vector(  446.4 ,-334.8,  0  ) , dir = Angle(  0,  0,  0) } , 
												{ type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } } 
	
	Note the structure - the nested tables, and the commas on all except the last entry, are all very important - if you miss a comma, or a bracket, it won't parse, so test it after you modify it. 

						}

for k,v in pairs( EXDB_PAD ) do		// Adds all the data in the Examblebridge table to the list
	if v ~= {} then
		list.Set( "SBEP_PartAssemblyData", k , v )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	SMALLBRIDGE															      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local SMB_PAD = {

	[ "models/smallbridge/hulls,sw/sbhullcurvel.mdl"			] = { { type = "SWSH" , pos = Vector(  446.4 ,-334.8,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullcurvem.mdl"			] = { { type = "SWSH" , pos = Vector(  334.8 ,-223.2,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -223.2 , 334.8,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullcurves.mdl"			] = { { type = "SWSH" , pos = Vector(  223.2 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhulle05.mdl"				] = { { type = "SWSH" , pos = Vector(   55.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(  -55.8 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulle1.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulle2.mdl"				] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulle3.mdl"				] = { { type = "SWSH" , pos = Vector(  334.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -334.8 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulle4.mdl"				] = { { type = "SWSH" , pos = Vector(  446.4 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -446.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhulledh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulledh05.mdl"				] = { { type = "SWDH" , pos = Vector(   55.8 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector(  -55.8 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulledh2.mdl"				] = { { type = "SWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulledh3.mdl"				] = { { type = "SWDH" , pos = Vector(  334.8 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -334.8 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulledh4.mdl"				] = { { type = "SWDH" , pos = Vector(  446.4 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -446.4 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhulleflip.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,180) } } ,
	[ "models/smallbridge/hulls,sw/sbhullend.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullenddh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhullr.mdl"					] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullrdh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   , 111.6, 65.1) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullrtri.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhullslanthalfl.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,  55.8,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 , -55.8,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullslanthalfr.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 , -55.8,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,  55.8,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullslantl.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 , 111.6,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,-111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullslantr.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 , 111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhullt.mdl"					] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulltdh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   , 111.6, 65.1) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulltdl.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulltdldw.mdl"				] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhulltri1.mdl"				] = { { type = "SWSH" , pos = Vector(  -74.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulltri2.mdl"				] = { { type = "SWSH" , pos = Vector(  -74.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(   37.2 ,64.432,  0  ) , dir = Angle(  0, 60,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhulltri3.mdl"				] = { { type = "SWSH" , pos = Vector(  -74.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(   37.2 , 64.43,  0  ) , dir = Angle(  0, 60,  0) } ,
																	  { type = "SWSH" , pos = Vector(   37.2 ,-64.43,  0  ) , dir = Angle(  0,-60,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,sw/sbhullx.mdl"					] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullxdh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   ,-111.6, 65.1) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   , 111.6, 65.1) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullxdl.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,sw/sbhullxdldw.mdl"				] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldwe05.mdl"				] = { { type = "DWSH" , pos = Vector(   55.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(  -55.8 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwe1.mdl"				] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwe2.mdl"				] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwe3.mdl"				] = { { type = "DWSH" , pos = Vector(  334.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -334.8 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwe4.mdl"				] = { { type = "DWSH" , pos = Vector(  446.4 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -446.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldwedh.mdl"				] = { { type = "DWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwedh05.mdl"			] = { { type = "DWDH" , pos = Vector(   55.8 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector(  -55.8 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwedh2.mdl"			] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwedh3.mdl"			] = { { type = "DWDH" , pos = Vector(  334.8 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -334.8 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwedh4.mdl"			] = { { type = "DWDH" , pos = Vector(  446.4 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -446.4 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldweflip.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,180) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwend.mdl"				] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwend2.mdl"			] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwenddh.mdl"			] = { { type = "DWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwenddh2.mdl"			] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldwr.mdl"				] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwrdh.mdl"				] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   , 223.2, 65.1) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldwt.mdl"				] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwtdh.mdl"				] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector(    0   ,-223.2, 65.1) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   , 223.2, 65.1) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwtdl.mdl"				] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwtsl.mdl"				] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hulls,dw/sbhulldwx.mdl"				] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwxdh.mdl"				] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   ,-223.2, 65.1) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   , 223.2, 65.1) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/hulls,dw/sbhulldwxdl.mdl"				] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/ship parts/sbcockpit1.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbcockpit2.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbcockpit2o.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbcockpit2or.mdl"			] = {  	} ,
	[ "models/smallbridge/ship parts/sbcockpit3.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbcockpit4.mdl"			] = { { type = "SWSH" , pos = Vector(  -27.9 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbcockpit5dw.mdl"			] = { { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/ship parts/sbengine1.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine2.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine2o.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine2or.mdl"			] = {   } ,
	[ "models/smallbridge/ship parts/sbengine3.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine4dw.mdl"			] = { { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine4l.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine4m.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine4r.mdl"			] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine5.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbengine5dwdh.mdl"			] = { { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/ship parts/sbhulldsdwe.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbhulldsdwe2.mdl"			] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbhulldse.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbhulldse2.mdl"			] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbhulldseb.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sbhulldsp.mdl"				] = {  	} ,
	[ "models/smallbridge/ship parts/sbhulldsp2.mdl"			] = {  	} ,
	[ "models/smallbridge/ship parts/sbhulldst.mdl"				] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/ship parts/sblandramp.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC1" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sblandrampdw.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC3" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sblandrampdwdh.mdl"		] = { { type = "DWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC5" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sblandrampp.mdl"			] = {  	} ,
	[ "models/smallbridge/ship parts/sblandramppdw.mdl"			] = {  	} ,
	[ "models/smallbridge/ship parts/sblandramppdwdh.mdl"		] = {  	} ,
	[ "models/smallbridge/ship parts/sblanduramp.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC2" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sblandurampdw.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC4" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/ship parts/sblandurampdwdh.mdl"		] = { { type = "DWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "LRC6" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbconvmb.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbconvmbdh.mdl"				] = { { type = "SWDH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbconvmbdw.mdl"				] = { { type = "DWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbconvmbdwdh.mdl"			] = { { type = "DWDH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbsplit2s-2sw.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 , 111.6,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 , 111.6,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,-111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplit2s-dw.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 , 111.6,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,-111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbsplitdws-dhd.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplitdws-dhm.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplitdws-dhu.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbsplits-dhd.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplits-dhm.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplits-dhu.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbsplits-dw.mdl"			] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplits-dwa.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplits-dwdh.mdl"			] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/splitters/sbsplitv.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 , 111.6,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/splitters/sbsplitvdh.mdl"				] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWDH" , pos = Vector( -111.6 , 111.6, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWDH" , pos = Vector( -111.6 ,-111.6, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/splitters/sbsplitvw.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 , 167.4,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-167.4,  0  ) , dir = Angle(  0,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/height transfer/sbhtcramp.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 , 111.6, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 , 111.6, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,-111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtcramp2d.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 , 334.8,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 , 334.8,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-334.8,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,-334.8,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtcramp2u.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 , 334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 , 334.8, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,-334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,-334.8, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtcrampdl.mdl"		] = { { type = "SWSH" , pos = Vector(  223.2 , 111.6, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 , 111.6, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  223.2 ,-111.6,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,-111.6,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/height transfer/sbhtramp.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtramp05.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtrampdw.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtrampdw05.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/height transfer/sbhtsdwrampd.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsdwrampm.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsdwrampu.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,-65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/height transfer/sbhtsrampd.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsrampm.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsrampu.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,-65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,-65.1) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/height transfer/sbhtsrampz.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  111.6 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsrampzdh.mdl"		] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsrampzdw.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWSH" , pos = Vector(  111.6 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/height transfer/sbhtsrampzdwdh.mdl"	] = { { type = "DWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/panels/sbdoor.mdl"					] = { 	} ,
	[ "models/smallbridge/panels/sbdoorsquare.mdl"				] = {  	} ,
	[ "models/smallbridge/panels/sbdoorwide.mdl"				] = { 	} ,
	[ "models/smallbridge/panels/sbpaneldbsmall.mdl"			] = { 	} ,
	[ "models/smallbridge/panels/sbpaneldh.mdl"					] = { { type = "SWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldhdw.mdl"				] = { { type = "DWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldockin.mdl"				] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldockout.mdl"			] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoor.mdl"				] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoordh.mdl"				] = { { type = "SWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoordhdw.mdl"			] = { { type = "DWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWDH" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoordw.mdl"				] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoordw2.mdl"			] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldooriris.mdl"			] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoorsquare.mdl"			] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoorsquaredw.mdl"		] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoorsquaredw2.mdl"		] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoorwide.mdl"			] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneldoorwide2.mdl"			] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpaneliris.mdl"				] = {  	} ,
	[ "models/smallbridge/panels/sbpanelsolid.mdl"				] = { { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/panels/sbpanelsoliddw.mdl"			] = { { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevb.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbe.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbedh.mdl"		] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,195.3) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbedw.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbr.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbt.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevbx.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevm.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevme.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevmedh.mdl"		] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,195.3) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevmedw.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevmr.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevmt.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevmx.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevp0.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,small/sbselevp1.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,small/sbselevp2e.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,small/sbselevp2esl.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,small/sbselevp2r.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,small/sbselevp3.mdl"		] = {  	} ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevs.mdl"			] = { { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevs2.mdl"		] = { { type = "ESML" , pos = Vector(    0   ,   0  ,130.2) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-130.2), dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevslant.mdl"		] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,   0  ,260.4) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,260.4) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,small/sbselevt.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevte.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevtedh.mdl"		] = { { type = "SWDH" , pos = Vector(  111.6 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWDH" , pos = Vector( -111.6 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevtedw.mdl"		] = { { type = "DWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "DWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevtr.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevtt.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,small/sbselevtx.mdl"		] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-111.6,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 111.6,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,large/sblelevb.mdl"			] = { { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevbe.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevbedh.mdl"		] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,195.3) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevbr.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevbt.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevbx.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,large/sblelevm.mdl"			] = { { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevme.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevmedh.mdl"		] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,195.3) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevmr.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevmt.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevmx.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,large/sblelevp0.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,large/sblelevp1.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,large/sblelevp2e.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,large/sblelevp2r.mdl"		] = {  	} ,
	[ "models/smallbridge/elevators,large/sblelevp3.mdl"		] = {  	} ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,large/sblelevs.mdl"			] = { { type = "ELRG" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevs2.mdl"		] = { { type = "ELRG" , pos = Vector(    0   ,   0  ,130.2) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-130.2), dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/elevators,large/sblelevt.mdl"			] = { { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevte.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevtedh.mdl"		] = { { type = "DWDH" , pos = Vector(  223.2 ,   0  , 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,   0  , 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevtr.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevtt.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/elevators,large/sblelevtx.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   ,-223.2,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "DWSH" , pos = Vector(    0   , 223.2,  0  ) , dir = Angle(  0, 90,  0) } ,
																	  { type = "ELRG" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/hangars/sbdb1l.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb1ls.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb1m.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb1m1.mdl"					] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hangars/sbdb1m12.mdl"					] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hangars/sbdb1r.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb1rs.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb2l.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb2m.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb2mdw.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb2r.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb3m.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb3mdw.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb3mx.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb3mxdw.mdl"				] = {  	} ,
	[ "models/smallbridge/hangars/sbdb3side.mdl"				] = {  	} ,
	[ "models/smallbridge/hangars/sbdb4l.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb4m.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb4mdw.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdb4r.mdl"					] = {  	} ,
	[ "models/smallbridge/hangars/sbdbcomp1.mdl"				] = { { type = "SWSH" , pos = Vector( -446.4 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -446.4 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hangars/sbdbseg1s.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hangars/sbdbseg1ss.mdl"				] = { { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,130.2) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/hangars/sbdbseg2s.mdl"				] = {  	} ,
	[ "models/smallbridge/hangars/sbdbseg3s.mdl"				] = {  	} ,
	[ "models/smallbridge/hangars/sbdbseg4s.mdl"				] = {  	} ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/life support/sbhullcache.mdl"			] = { { type = "SWSH" , pos = Vector(  111.6 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } , 
																	  { type = "SWSH" , pos = Vector( -111.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
	[ "models/smallbridge/station parts/sbbayaps.mdl"			] = { { type = "SWSH" , pos = Vector(   55.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbbaydps.mdl"			] = { { type = "SWSH" , pos = Vector(   55.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgecomm.mdl"		] = { { type = "SWSH" , pos = Vector(  -18.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgecommdw.mdl"		] = { { type = "DWSH" , pos = Vector(  -18.6 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgecommelev.mdl"	] = { { type = "ESML" , pos = Vector(   46.5 ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgesphere.mdl"		] = { { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgevisor.mdl"		] = { { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgevisorb.mdl"		] = { { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgevisorm.mdl"		] = { { type = "ESML" , pos = Vector(    0   ,   0  , 65.1) , dir = Angle(-90,  0,  0) } ,
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbbridgevisort.mdl"		] = { { type = "ESML" , pos = Vector(    0   ,   0  ,-65.1) , dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbdockcs.mdl"			] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbhangarld.mdl"			] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 , 334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 , 334.8, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 ,-334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,-334.8, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbhangarlu.mdl"			] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,130.2) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 , 334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 , 334.8, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 ,-334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,-334.8, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbhangarlud.mdl"		] = { { type = "SWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  223.2 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -223.2 ,   0  ,130.2) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 , 334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 , 334.8, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 ,-334.8, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,-334.8, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbhangarlud2.mdl"		] = { { type = "DWSH" , pos = Vector(  223.2 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWSH" , pos = Vector(  223.2 ,   0  ,130.2) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWSH" , pos = Vector( -223.2 ,   0  ,130.2) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 , 446.4, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 , 446.4, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "DWDH" , pos = Vector(  223.2 ,-446.4, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "DWDH" , pos = Vector( -223.2 ,-446.4, 65.1) , dir = Angle(  0,180,  0) } } ,
	[ "models/smallbridge/station parts/sbhubl.mdl"				] = { { type = "SWSH" , pos = Vector(  558   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -558   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-558  ,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 558  ,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/station parts/sbhuble.mdl"			] = { { type = "SWSH" , pos = Vector(  558   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -558   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-558  ,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 558  ,  0  ) , dir = Angle(  0, 90,  0) } , 
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,195.3) , dir = Angle(-90,  0,  0) } , 
																	  { type = "ESML" , pos = Vector(    0   ,   0  ,-195.3), dir = Angle( 90,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbhubls.mdl"			] = { { type = "SWSH" , pos = Vector(  558   ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -558   ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-558  ,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 558  ,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/station parts/sbhubs.mdl"				] = { { type = "SWSH" , pos = Vector(  334.8 ,   0  ,  0  ) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -334.8 ,   0  ,  0  ) , dir = Angle(  0,180,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   ,-334.8,  0  ) , dir = Angle(  0,270,  0) } , 
																	  { type = "SWSH" , pos = Vector(    0   , 334.8,  0  ) , dir = Angle(  0, 90,  0) } } ,
	[ "models/smallbridge/station parts/sbrooml1.mdl"			] = { { type = "DWDH" , pos = Vector(  409.2 ,   0  ,120.9) , dir = Angle(  0,  0,  0) } } ,
	[ "models/smallbridge/station parts/sbroomsgc.mdl"			] = { { type = "SWSH" , pos = Vector( -446.4 ,   0  ,325.5) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  892.8 , 446.4, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -446.4 , 446.4, 65.1) , dir = Angle(  0,180,  0) } ,
																	  { type = "SWSH" , pos = Vector(  892.8 ,-446.4, 65.1) , dir = Angle(  0,  0,  0) } ,
																	  { type = "SWSH" , pos = Vector( -446.4 ,-446.4, 65.1) , dir = Angle(  0,180,  0) } }
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
						}

for m,D in pairs( SMB_PAD ) do		// Adds all the data in the Smallbridge table to the list
	if D ~= {} then
		list.Set( "SBEP_PartAssemblyData", m , D )
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	MEDBRIDGE															      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MEDB_PAD = {
	
	/*[ "MODEL PATH"								] = { { type = "TYPE CODE" , pos = VECTOR POSITION, dir = ANGLE ORIENTATION} , 
							Second attachment point - 		{ type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } }  */
	
						}

for m,D in pairs( MEDB_PAD ) do		// Adds all the data in the Medbridge table to the list
	if D ~= {} then
		list.Set( "SBEP_PartAssemblyData", m , D )
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	MODBRIDGE															      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MODB_PAD = {

	/*[ "MODEL PATH"								] = { { type = "TYPE CODE" , pos = VECTOR POSITION, dir = ANGLE ORIENTATION} , 
							Second attachment point - 		{ type = "SWSH" , pos = Vector( -334.8 , 446.4,  0  ) , dir = Angle(  0, 90,  0) } }  */
						}

for m,D in pairs( MODB_PAD ) do		// Adds all the data in the Modbridge table to the list
	if D ~= {} then
		list.Set( "SBEP_PartAssemblyData", m , D )
	end
end