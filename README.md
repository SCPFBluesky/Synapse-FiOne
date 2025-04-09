# Synapse F (Synapse-FiOne)
Synapse F is a open source INCOMPLETE roblox studio exucutor, this project mimics an exploit enviorment written in pure luau \ lua with the help of the FiOne bytecode interpreter. 
More functions are planned to be added over time.
Source code and .RBXL will be provided once the project is stable and ready for release.

## Enviorment

## getgenv
Returns the table of ``Synapse F`` global enviroment table.


## getrenv
Returns a table of the ``roblox`` enviorment table.

## getreg
Returns a table of the LUA registry.

## Metatable

## getrawmetatable

Returns the metatable of a table or userdata, even if the metatable has the ``__metatable`` metamethod.
| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Object`      | `userdata or table`   | The target.                                                                                   |

```lua
  local raw = getrawmetatable(game);
  table.foreach(raw, print);
```

## hookmetamethod

Hooks any specified ``metamethod`` on any userdata or table

| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Object`      | `userdata or table`   | Object to hook.                                                                                   |
| `Metamethod`      | `string`  | The metamethod to hook.   |
| `Closure`      | `any?`     | The new function. |


```lua
  local hook;
  hook = hookmetamethod(game, "__index", function(Self, ...) -- replaces the __index metamethod with our own new function.
    
  end);
```

## hooknamecallmethod | hooknamecallmetamethod
Hooks the ``__namecall`` metamethod of any table or userdata. Internally calls ``hookmetamethod`` function.

| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Object`      | `userdata or table`   | Object to hook.                                                                                   |
| `Closure`      | `any?`     | The new function. |


```lua
  local hook;
  hook = hooknamecallmethod(game, function(Self, ...) -- replaces the __namecall metamethod with our own new function.
    
  end);
```

## Hooking
Let's move onto the non metatable hooking functions Synapse-F has to offer.

## hookfunction
Replaces provided function with our new function, returns the old function if you do not want to fully replace the old function.


| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Function`      | `any`   | The function to hook.                                                                                   |
| `Closure`      | `any?`     | The new function. |

```lua
  local function yeah(X, Y, Z)
    print("Our x", X);
  end;

  local oldyeah;
  oldyeah = hookfunction(yeah, function(X, Y, Z)
      if X == 4 then
          X = 3;
      end;
      return oldyeah(X, Y, Z); 
  end);
  yeah(4, 6, 9);
```

## clonefunction
Clones the provided function.

| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Function`      | `any`   | The function to clone.                                                                                   |

## Miscellaneous
Synapse-F also supports many Miscellaneous functions you see in many exploits today.

## getnamecallmethod
Returns a string on what namecall was called, this is normally used on ``__namecall`` metatable hooks.

```lua
  local hook;
  hook = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod();
    if Method == "GetService" then
        print("GetService called.")
     end;
  end);
```

## getthreadidentity
Returns the number of the current thread identification level.

## setnamecallmethod
Sets the current ``__namecall`` method to your own.

```lua
  local hook;
  hook = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod();
    if Method == "GetService" then
        setnamecallmethod("FindService");
     end;
  end);
```

## islclosure
Returns ``true`` if the function is made by ``LUA``

## iscclosure
Returns ``true`` if the function was made by ``C`` (In this case it will return true if the function was made internally by FiOne)

## Table
Let's go over the table related functions that Synapse-F provides us.

## isreadonly
Returns ``true`` if the gaven table \ userdata is readonly

```lua
  local Yeah = {};
  table.freeze(Yeah);
  print(isreadonly(Yeah)) --> true
```
| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Table`      | `any`   | The table to check.                                                                                   |


## setreadonly
Sets the gaven table \ userdata to the provided readonly state.

```lua
  local Yeah = {};
  table.freeze(Yeah);
  setreadonly(Yeah, false);
  print(isreadonly(Yeah)) --> false
```
| **Parameter** | **Type**   | **Description**                                                                                                               |
|---------------|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `Table`      | `Table or userdata`   | The table to set.                                                                                   |
| `State`      | `boolean`   | The readonly sate (true or false).                                                                                   |


