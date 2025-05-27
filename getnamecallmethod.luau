local getnamecallmethod = insertCFunction(@checked function(lua_State: number): number --// TODO: fix this not working sometimes
	cfns.lua_pushstring(lua_State, cfns.lua_namecallatom(lua_State, 1))
	return 1;
end);
