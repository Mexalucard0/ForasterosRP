function AddNewVariation(which, gender, one, two, single)
	local Where = Variations[which][gender]
	if not single then
		Where[one] = two
		Where[two] = one
	else
		Where[one] = two
	end
end

--[[
		This is where all the different variations go.
		For jackets i included extra things that arent just hoodies aswell, things like the christmas sweater with their different lights.
		So doing the command whilst wearing the christmas sweater you can toggle the light.

		Tip for adding new ones of this is to toggle Config.Debug, and use vMenu Player Appearance to switch around.

		If you are using EUP you might have to change things around!
		But it should be easy enough to understand and make changes as you want.

		Simply just : 

		AddNewVariation(Table, Gender, First, Second)

		And for Hair there is also the "single" var.
		Its important for haircuts.
]]--

Citizen.CreateThread(function()
	-- Male Visor/Hat Variations
	AddNewVariation("Visor", "Male", 18, 67+80)
	AddNewVariation("Visor", "Male", 82+80, 67+80)
	AddNewVariation("Visor", "Male", 50+80, 68+80)
	AddNewVariation("Visor", "Male", 51+80, 69+80)
	AddNewVariation("Visor", "Male", 53+80, 71+80)
	AddNewVariation("Visor", "Male", 62+80, 72+80)
	AddNewVariation("Visor", "Male", 65+80, 66+80)
	AddNewVariation("Visor", "Male", 73+80, 74+80)
	AddNewVariation("Visor", "Male", 76+80, 77+80)
	AddNewVariation("Visor", "Male", 79+80, 78+80)
	AddNewVariation("Visor", "Male", 80+80, 81+80)
	AddNewVariation("Visor", "Male", 91+80, 92+80)
	AddNewVariation("Visor", "Male", 104+80, 105+80)
	AddNewVariation("Visor", "Male", 109+80, 110+80)
	AddNewVariation("Visor", "Male", 116+80, 117+80)
	AddNewVariation("Visor", "Male", 118+80, 119+80)
	AddNewVariation("Visor", "Male", 123+80, 124+80)
	AddNewVariation("Visor", "Male", 125+80, 126+80)
	AddNewVariation("Visor", "Male", 127+80, 128+80)
	AddNewVariation("Visor", "Male", 130+80, 131+80)
	-- Female Visor/Hat Variations
	AddNewVariation("Visor", "Female", 49+81, 67+81)
	AddNewVariation("Visor", "Female", 63+81, 64+81)
	AddNewVariation("Visor", "Female", 51+81, 69+81)
	AddNewVariation("Visor", "Female", 142, 70+81)
	AddNewVariation("Visor", "Female", 71+81, 72+81)
	AddNewVariation("Visor", "Female", 75+81, 76+81)
	AddNewVariation("Visor", "Female", 76+81, 77+81)
	AddNewVariation("Visor", "Female", 78+81, 79+81)
	AddNewVariation("Visor", "Female", 18, 65+81)
	AddNewVariation("Visor", "Female", 89+81, 90+81)
	AddNewVariation("Visor", "Female", 102+81, 103+81)
	AddNewVariation("Visor", "Female", 107+81, 108+81)
	AddNewVariation("Visor", "Female", 114+81, 115+81)
	AddNewVariation("Visor", "Female", 116+81, 117+81)
	AddNewVariation("Visor", "Female", 121+81, 122+81)
	AddNewVariation("Visor", "Female", 123+81, 124+81)
	AddNewVariation("Visor", "Female", 125+81, 126+81)
	AddNewVariation("Visor", "Female", 128+81, 129+81)
	-- Male Bags
	AddNewVariation("Bags", "Male", 45+91, 44+91)
	AddNewVariation("Bags", "Male", 41+91, 40+91)
	-- Female Bags
	AddNewVariation("Bags", "Female", 45+91, 44+91)
	AddNewVariation("Bags", "Female", 41+91, 40+91)
	-- Male Hair
	AddNewVariation("Hair", "Male", 7, 15, true)
	AddNewVariation("Hair", "Male", 43+84, 15, true)
	AddNewVariation("Hair", "Male", 9, 43+84, true)
	AddNewVariation("Hair", "Male", 11, 43+84, true)
	AddNewVariation("Hair", "Male", 15, 43+84, true)
	AddNewVariation("Hair", "Male", 16, 43+84, true)
	AddNewVariation("Hair", "Male", 17, 43+84, true)
	AddNewVariation("Hair", "Male", 20, 43+84, true)
	AddNewVariation("Hair", "Male", 22, 43+84, true)
	AddNewVariation("Hair", "Male", 45+84, 43+84, true)
	AddNewVariation("Hair", "Male", 47+84, 43+84, true)
	AddNewVariation("Hair", "Male", 49+84, 43+84, true)
	AddNewVariation("Hair", "Male", 51+84, 43+84, true)
	AddNewVariation("Hair", "Male", 52+84, 43+84, true)
	AddNewVariation("Hair", "Male", 53+84, 43+84, true)
	AddNewVariation("Hair", "Male", 56+84, 43+84, true)
	AddNewVariation("Hair", "Male", 58+84, 43+84, true)
	-- Female Hair
	AddNewVariation("Hair", "Female", 1, 49, true)
	AddNewVariation("Hair", "Female", 2, 49, true)
	AddNewVariation("Hair", "Female", 7, 49, true)
	AddNewVariation("Hair", "Female", 9, 49, true)
	AddNewVariation("Hair", "Female", 10, 49, true)
	AddNewVariation("Hair", "Female", 11, 48, true)
	AddNewVariation("Hair", "Female", 14, 53+84, true)
	AddNewVariation("Hair", "Female", 15, 42, true)
	AddNewVariation("Hair", "Female", 21, 42, true)
	AddNewVariation("Hair", "Female", 23, 42, true)
	AddNewVariation("Hair", "Female", 31, 53+84, true)
	AddNewVariation("Hair", "Female", 39, 49, true)
	AddNewVariation("Hair", "Female", 40, 49, true)
	AddNewVariation("Hair", "Female", 42, 53+84, true)
	AddNewVariation("Hair", "Female", 45, 49, true)
	AddNewVariation("Hair", "Female", 48, 49, true)
	AddNewVariation("Hair", "Female", 49, 48, true)
	AddNewVariation("Hair", "Female", 52+84, 53+84, true)
	AddNewVariation("Hair", "Female", 53+84, 42, true)
	AddNewVariation("Hair", "Female", 54+84, 55+84, true)
	AddNewVariation("Hair", "Female", 59+84, 42, true)
	AddNewVariation("Hair", "Female", 59+84, 54+84, true)
	AddNewVariation("Hair", "Female", 68+84, 53+84, true)
	AddNewVariation("Hair", "Female", 76+84, 48, true)
	-- Male Top/Jacket Variations
	AddNewVariation("Jackets", "Male", 29+84, 30+84)
	AddNewVariation("Jackets", "Male", 31+84, 32+84)
	AddNewVariation("Jackets", "Male", 42+84, 43+84)
	AddNewVariation("Jackets", "Male", 68+84, 69+84)
	AddNewVariation("Jackets", "Male", 74+84, 75+84)
	AddNewVariation("Jackets", "Male", 87+84, 88+84)
	AddNewVariation("Jackets", "Male", 99+84, 100+84)
	AddNewVariation("Jackets", "Male", 101+84, 102+84)
	AddNewVariation("Jackets", "Male", 103+84, 104+84)
	AddNewVariation("Jackets", "Male", 126+84, 127+84)
	AddNewVariation("Jackets", "Male", 129+84, 130+84)
	AddNewVariation("Jackets", "Male", 184+84, 185+84)
	AddNewVariation("Jackets", "Male", 188+84, 189+84)
	AddNewVariation("Jackets", "Male", 194+84, 195+84)
	AddNewVariation("Jackets", "Male", 196+84, 197+84)
	AddNewVariation("Jackets", "Male", 198+84, 199+84)
	AddNewVariation("Jackets", "Male", 200+84, 203+84)
	AddNewVariation("Jackets", "Male", 202+84, 205+84)
	AddNewVariation("Jackets", "Male", 206+84, 207+84)
	AddNewVariation("Jackets", "Male", 210+84, 211+84)
	AddNewVariation("Jackets", "Male", 217+84, 218+84)
	AddNewVariation("Jackets", "Male", 229+84, 230+84)
	AddNewVariation("Jackets", "Male", 232+84, 233+84)
	AddNewVariation("Jackets", "Male", 251+84, 253+84)
	AddNewVariation("Jackets", "Male", 256+84, 261+84)
	AddNewVariation("Jackets", "Male", 262+84, 263+84)
	AddNewVariation("Jackets", "Male", 265+84, 266+84)
	AddNewVariation("Jackets", "Male", 267+84, 268+84)
	AddNewVariation("Jackets", "Male", 279+84, 280+84)
	-- Female Top/Jacket Variations
	AddNewVariation("Jackets", "Female", 53+84, 52+84) 
	AddNewVariation("Jackets", "Female", 57+84, 58+84) 
	AddNewVariation("Jackets", "Female", 62+84, 63+84) 
	AddNewVariation("Jackets", "Female", 90+84, 91+84) 
	AddNewVariation("Jackets", "Female", 92+84, 93+84) 
	AddNewVariation("Jackets", "Female", 94+84, 95+84) 
	AddNewVariation("Jackets", "Female", 187+84, 186+84)
	AddNewVariation("Jackets", "Female", 190+84, 191+84) 
	AddNewVariation("Jackets", "Female", 196+84, 197+84) 
	AddNewVariation("Jackets", "Female", 198+84, 199+84) 
	AddNewVariation("Jackets", "Female", 200+84, 201+84)
	AddNewVariation("Jackets", "Female", 202+84, 205+84) 
	AddNewVariation("Jackets", "Female", 204+84, 207+84) 
	AddNewVariation("Jackets", "Female", 210+84, 211+84)
	AddNewVariation("Jackets", "Female", 214+84, 215+84)
	AddNewVariation("Jackets", "Female", 227+84, 228+84) 
	AddNewVariation("Jackets", "Female", 239+84, 240+84) 
	AddNewVariation("Jackets", "Female", 242+84, 243+84) 
	AddNewVariation("Jackets", "Female", 259+84, 261+84)
	AddNewVariation("Jackets", "Female", 265+84, 270+84) 
	AddNewVariation("Jackets", "Female", 271+84, 272+84) 
	AddNewVariation("Jackets", "Female", 274+84, 275+84) 
	AddNewVariation("Jackets", "Female", 276+84, 277+84)
	AddNewVariation("Jackets", "Female", 292+84, 293+84) 
end)

-- And this is the master table, i put it down here since it has all the glove variations, and thats quite the eyesore.
-- You probably dont wanna touch anything down here really.
-- I generated these glove ones with a tool i made, im pretty certain its accurate, there might be native function for this.
-- If there is i wish i knew of it before i spent hours doing it this way.

Variations = {
	Jackets = {Male = {}, Female = {}},
	Hair = {Male = {}, Female = {}},
	Bags = {Male = {}, Female = {}},
	Visor = {Male = {}, Female = {}},
	Gloves = {
		Male = {
			[16] = 4,
			[17] = 4,
			[18] = 4,
			[19] = 0,
			[20+84] = 1,
			[21+84] = 2,
			[22+84] = 4,
			[23+84] = 5,
			[24+84] = 6,
			[25+84] = 8,
			[26+84] = 11,
			[27+84] = 12,
			[28+84] = 14,
			[29+84] = 15,
			[30+84] = 0,
			[31+84] = 1,
			[32+84] = 2,
			[33+84] = 4,
			[34+84] = 5,
			[35+84] = 6,
			[36+84] = 8,
			[37+84] = 11,
			[38+84] = 12,
			[39+84] = 14,
			[40+84] = 15,
			[41+84] = 0,
			[42+84] = 1,
			[43+84] = 2,
			[44+84] = 4,
			[45+84] = 5,
			[46+84] = 6,
			[47+84] = 8,
			[48+84] = 11,
			[49+84] = 12,
			[50+84] = 14,
			[51+84] = 15,
			[52+84] = 0,
			[53+84] = 1,
			[54+84] = 2,
			[55+84] = 4,
			[56+84] = 5,
			[57+84] = 6,
			[58+84] = 8,
			[59+84] = 11,
			[60+84] = 12,
			[61+84] = 14,
			[62+84] = 15,
			[63+84] = 0,
			[64+84] = 1,
			[65+84] = 2,
			[66+84] = 4,
			[67+84] = 5,
			[68+84] = 6,
			[69+84] = 8,
			[70+84] = 11,
			[71+84] = 12,
			[72+84] = 14,
			[73+84] = 15,
			[74+84] = 0,
			[75+84] = 1,
			[76+84] = 2,
			[77+84] = 4,
			[78+84] = 5,
			[79+84] = 6,
			[80+84] = 8,
			[81+84] = 11,
			[82+84] = 12,
			[83+84] = 14,
			[84+84] = 15,
			[85+84] = 0,
			[86+84] = 1,
			[87+84] = 2,
			[88+84] = 4,
			[89+84] = 5,
			[90+84] = 6,
			[91+84] = 8,
			[92+84] = 11,
			[93+84] = 12,
			[94+84] = 14,
			[95+84] = 15,
			[96+84] = 4,
			[97+84] = 4,
			[98+84] = 4,
			[99+84] = 0,
			[100+84] = 1,
			[101+84] = 2,
			[102+84] = 4,
			[103+84] = 5,
			[104+84] = 6,
			[105+84] = 8,
			[106+84] = 11,
			[107+84] = 12,
			[108+84] = 14,
			[109+84] = 15,
			[110+84] = 4,
			[111+84] = 4,
			[115+84] = 112,
			[116+84] = 112,
			[117+84] = 112,
			[118+84] = 112,
			[119+84] = 112,
			[120+84] = 112,
			[121+84] = 112,
			[122+84] = 113,
			[123+84] = 113,
			[124+84] = 113,
			[125+84] = 113,
			[126+84] = 113,
			[127+84] = 113,
			[128+84] = 113,
			[129+84] = 114,
			[130+84] = 114,
			[131+84] = 114,
			[132+84] = 114,
			[133+84] = 114,
			[134+84] = 114,
			[135+84] = 114,
			[136+84] = 15,
			[137+84] = 15,
			[138+84] = 0,
			[139+84] = 1,
			[140+84] = 2,
			[141+84] = 4,
			[142+84] = 5,
			[143+84] = 6,
			[144+84] = 8,
			[145+84] = 11,
			[146+84] = 12,
			[147+84] = 14,
			[148+84] = 112,
			[149+84] = 113,
			[150+84] = 114,
			[151+84] = 0,
			[152+84] = 1,
			[153+84] = 2,
			[154+84] = 4,
			[155+84] = 5,
			[156+84] = 6,
			[157+84] = 8,
			[158+84] = 11,
			[159+84] = 12,
			[160+84] = 14,
			[161+84] = 112,
			[162+84] = 113,
			[163+84] = 114,
			[165+84] = 4,
			[166+84] = 4,
			[167+84] = 4,
		},
		Female = {
			[16] = 11,
			[17] = 3,
			[18] = 3,
			[19] = 3,
			[20] = 0,
			[21+84] = 1,
			[22+84] = 2,
			[23+84] = 3,
			[24+84] = 4,
			[25+84] = 5,
			[26+84] = 6,
			[27+84] = 7,
			[28+84] = 9,
			[29+84] = 11,
			[30+84] = 12,
			[31+84] = 14,
			[32+84] = 15,
			[33+84] = 0,
			[34+84] = 1,
			[35+84] = 2,
			[36+84] = 3,
			[37+84] = 4,
			[38+84] = 5,
			[39+84] = 6,
			[40+84] = 7,
			[41+84] = 9,
			[42+84] = 11,
			[43+84] = 12,
			[44+84] = 14,
			[45+84] = 15,
			[46+84] = 0,
			[47+84] = 1,
			[48+84] = 2,
			[49+84] = 3,
			[50+84] = 4,
			[51+84] = 5,
			[52+84] = 6,
			[53+84] = 7,
			[54+84] = 9,
			[55+84] = 11,
			[56+84] = 12,
			[57+84] = 14,
			[58+84] = 15,
			[59+84] = 0,
			[60+84] = 1,
			[61+84] = 2,
			[62+84] = 3,
			[63+84] = 4,
			[64+84] = 5,
			[65+84] = 6,
			[66+84] = 7,
			[67+84] = 9,
			[68+84] = 11,
			[69+84] = 12,
			[70+84] = 14,
			[71+84] = 15,
			[72+84] = 0,
			[73+84] = 1,
			[74+84] = 2,
			[75+84] = 3,
			[76+84] = 4,
			[77+84] = 5,
			[78+84] = 6,
			[79+84] = 7,
			[80+84] = 9,
			[81+84] = 11,
			[82+84] = 12,
			[83+84] = 14,
			[84+84] = 15,
			[85+84] = 0,
			[86+84] = 1,
			[87+84] = 2,
			[88+84] = 3,
			[89+84] = 4,
			[90+84] = 5,
			[91+84] = 6,
			[92+84] = 7,
			[93+84] = 9,
			[94+84] = 11,
			[95+84] = 12,
			[96+84] = 14,
			[97+84] = 15,
			[98+84] = 0,
			[99+84] = 1,
			[100+84] = 2,
			[101+84] = 3,
			[102+84] = 4,
			[103+84] = 5,
			[104+84] = 6,
			[105+84] = 7,
			[106+84] = 9,
			[107+84] = 11,
			[108+84] = 12,
			[109+84] = 14,
			[110+84] = 15,
			[111+84] = 3,
			[112+84] = 3,
			[113+84] = 3,
			[114+84] = 0,
			[115+84] = 1,
			[116+84] = 2,
			[117+84] = 3,
			[118+84] = 4,
			[119+84] = 5,
			[120+84] = 6,
			[121+84] = 7,
			[122+84] = 9,
			[123+84] = 11,
			[124+84] = 12,
			[125+84] = 14,
			[126+84] = 15,
			[127+84] = 3,
			[128+84] = 3,
			[132+84] = 129,
			[133+84] = 129,
			[134+84] = 129,
			[135+84] = 129,
			[136+84] = 129,
			[137+84] = 129,
			[138+84] = 129,
			[139+84] = 130,
			[140+84] = 130,
			[141+84] = 130,
			[142+84] = 130,
			[143+84] = 130,
			[144+84] = 130,
			[145+84] = 130,
			[146+84] = 131,
			[147+84] = 131,
			[148+84] = 131,
			[149+84] = 131,
			[150+84] = 131,
			[151+84] = 131,
			[152+84] = 131,
			[154+84] = 153,
			[155+84] = 153,
			[156+84] = 153,
			[157+84] = 153,
			[158+84] = 153,
			[159+84] = 153,
			[160+84] = 153,
			[162+84] = 161,
			[163+84] = 161,
			[164+84] = 161,
			[165+84] = 161,
			[166+84] = 161,
			[167+84] = 161,
			[168+84] = 161,
			[169+84] = 15,
			[170+84] = 15,
			[171+84] = 0,
			[172+84] = 1,
			[173+84] = 2,
			[174+84] = 3,
			[175+84] = 4,
			[176+84] = 5,
			[177+84] = 6,
			[178+84] = 7,
			[179+84] = 9,
			[180+84] = 11,
			[181+84] = 12,
			[182+84] = 14,
			[183+84] = 129,
			[184+84] = 130,
			[185+84] = 131,
			[186+84] = 153,
			[187+84] = 0,
			[188+84] = 1,
			[189+84] = 2,
			[190+84] = 3,
			[191+84] = 4,
			[192+84] = 5,
			[193+84] = 6,
			[194+84] = 7,
			[195+84] = 9,
			[196+84] = 11,
			[197+84] = 12,
			[198+84] = 14,
			[199+84] = 129,
			[200+84] = 130,
			[201+84] = 131,
			[202+84] = 153,
			[203+84] = 161,
			[204+84] = 161,
			[206+84] = 3,
			[207+84] = 3,
			[208+84] = 3,
		},
		Player_Zero = {
			[0] = 26,
			[1] = 26,
			[2] = 26,
			[3] = 26,
			[4] = 26,
			[5] = 26,
			[6] = 26,
			[7] = 26,
			[8] = 26,
			[9] = 26,
			[10] = 26,
			[11] = 26,
			[12] = 26,
			[13] = 26,
			[14] = 26,
			[15] = 26,
			[16] = 26,
			[17] = 26,
			[18] = 26,
			[19] = 26,
			[20] = 26,
			[21] = 26,
			[22] = 26,
			[23] = 26,
			[24] = 26,
			[25] = 26,
			[27] = 26,
			[28] = 26,
			[29] = 26,
			[30] = 26,
			[31] = 26,
		}, 	
		Player_One = {
			[0] = 26,
			[1] = 26,
			[2] = 26,
			[3] = 26,
			[4] = 26,
			[5] = 26,
			[6] = 26,
			[7] = 26,
			[8] = 26,
			[9] = 26,
			[10] = 26,
			[11] = 26,
			[12] = 26,
			[13] = 26,
			[14] = 26,
			[15] = 26,
			[16] = 26,
			[17] = 26,
			[18] = 26,
			[19] = 26,
			[20] = 26,
			[21] = 26,
			[22] = 26,
			[23] = 26,
			[24] = 26,
			[25] = 26,
			[27] = 26,
			[28] = 26,
			[29] = 26,
			[30] = 26,
			[31] = 26,
		}, 	
		Player_Two = {
			[0] = 16,
			[1] = 16,
			[2] = 16,
			[3] = 16,
			[4] = 16,
			[5] = 16,
			[6] = 16,
			[7] = 16,
			[8] = 16,
			[9] = 16,
			[10] = 16,
			[11] = 16,
			[12] = 16,
			[13] = 16,
			[14] = 16,
			[15] = 16,
			[17] = 16,
			[18] = 16,
			[19] = 16,
			[20] = 16,
			[21] = 16,
			[22] = 16,
			[23] = 16,
			[24] = 16,
			[25] = 16,
			[26] = 16,
			[27] = 16,
			[28] = 16,
			[29] = 16,
			[30] = 16,
			[31] = 16,
			[32] = 16,
			[33] = 16,
		}
	}
}