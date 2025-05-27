local getrawmetatable = insertCFunction(@checked function(Stack: number) : number?
	local ObjectType: string = cfns.lua_type(Stack, 1);
	if (ObjectType ~= macros.LUA_TTABLE and ObjectType ~= macros.LUA_TUSERDATA) then
		error("invalid argument #1 to 'getrawmetatable' (table or userdata expected)", 2);
		return 0;
	end;
	
	if (not cfns.lua_getmetatable(Stack, 1)) then
		cfns.lua_pushnil(Stack);
	end;
	
	return 1;
end);
