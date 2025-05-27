# Synapse F (Synapse-FiOne)

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-incomplete-red)
![Language](https://img.shields.io/badge/language-Luau%20%2F%20Lua-yellow)
![Platform](https://img.shields.io/badge/platform-Roblox-blueviolet)

**Synapse F** is a closed-source **INCOMPLETE** Roblox Studio executor.
This project mimics an exploit environment which you would see if you downloaded a high unc exploit like ``Synapse X `` or in today's age ``Wave`` or ``Swift``. **This project is  of course written in pure Luau / Lua**,  with the help of the ``FiOne`` bytecode interpreter.

---

## 📚 Table of Contents

- [Environment Functions](#-environment-functions)
- [Metatable Functions](#-metatable-functions)
- [Hooking Functions](#-hooking-functions)
- [Miscellaneous Functions](#-miscellaneous-functions)
- [Table Functions](#-table-functions)

---

## 🌐 Environment Functions

### `getgenv`

Returns the table of `Synapse F` global environment table.

---

### `getrenv`

Returns a table of the `ROBLOX` environment table.

---

### `getreg`

Returns a table of the LUA registry.

---

## 🧠 Metatable Functions

### `getrawmetatable`

Returns the metatable of a table or userdata, even if the metatable has the `__metatable` metamethod.

| **Parameter** | **Type**             | **Description** |
|---------------|----------------------|-----------------|
| `Object`      | `userdata or table`  | The target table.     |

```lua
local raw = getrawmetatable(game)
table.foreach(raw, print)
```


### `setrawmetatable`

sets the metatable of a table or userdata, even if the metatable has the `__metatable` metamethod.

| **Parameter** | **Type**             | **Description** |
|---------------|----------------------|-----------------|
| `Object`      | `userdata or table`  | The target table.     |
| `New`      | `any` | The new metatable   |


```lua
setrawmetatable(game, {});
print(getmetatable(game)); -> {}
```

---

### `hookmetamethod`

Hooks any specified `metamethod` on any userdata or table. 

| **Parameter**  | **Type**             | **Description**         |
|----------------|----------------------|-------------------------|
| `Object`       | `userdata or table`  | Object to hook.         |
| `Metamethod`   | `string`             | The metamethod to hook. |
| `Closure`      | `any?`               | The new function.       |

```lua
-- Example: making an anti kick
local hook;
hook = hookmetamethod(game, "__namecall", newcclosure(function(Self: Object, ...: any): any?
    local Args: {any} = {...};
    local NAME_CALL_METHOD: string = getnamecallmethod();
    if NAME_CALL_METHOD == "Kick" and Self and typeof(Self) == "Instance" and Self.ClassName == "Player" then 
        return; -- Drop the kick call
    end;
    return hook(Self, unpack(Args));
end));
```

---

### `hooknamecallmethod` / `hooknamecallmetamethod`

Hooks the `__namecall` metamethod of any table or userdata.  
Internally calls `hookmetamethod`.

| **Parameter** | **Type**             | **Description** |
|---------------|----------------------|-----------------|
| `Object`      | `userdata or table`  | Object to hook. |
| `Closure`     | `any?`               | The new function. |

```lua
-- Example: making an anti kick
local hook;
hook = hookmetamethod(game, newcclosure(function(Self: Object, ...: any): any?
    local Args: {any} = {...};
    local NAME_CALL_METHOD: string = getnamecallmethod();
    if NAME_CALL_METHOD == "Kick" and Self and typeof(Self) == "Instance" and Self.ClassName == "Player" then 
        return; -- Drop the kick call
    end;
    return hook(Self, unpack(Args));
end));
```

---

## 🧩 Hooking Functions

### `hookfunction`

Replaces a provided function with your own.  
Returns the old function if you don't want to fully replace it.

| **Parameter** | **Type** | **Description**       |
|---------------|----------|-----------------------|
| `Function`    | `any`    | Function to hook.     |
| `Closure`     | `any?`   | The new function.     |

```lua
local function getPlayerName(isHooked: boolean): string
    if isHooked then
        print("wow we got hooked");
    end;
    return "lol" :: string
end;
print(getPlayerName());
local hook;
hook = hookfunction(getPlayerName, function(isHooked)
    isHooked = true;
    return hook(isHooked) :: string;
end);
print(getPlayerName());
```

---

### `clonefunction`

Clones the provided function.

| **Parameter** | **Type** | **Description**        |
|---------------|----------|------------------------|
| `Function`    | `any`    | Function to clone.     |

---

## 🔧 Miscellaneous Functions

### `getnamecallmethod`

Returns a string of the method that invoked the ``__namecall `` metamethod of the metatable.

```lua
local hook;
hook = hookmetamethod(game, "__namecall", newcclosure(function(Self: Object, ...: any): any
    print(getnamecallmethod());
    return hook(Self, unpack({...})) :: any;
end));
```

---

### `getthreadidentity`

Returns the number of the current thread identification level.

---

### `setnamecallmethod`

Sets the methopd that invoked ```__namecall``` to your own wanted method. 

```lua
local hook
hook = hookmetamethod(game, "__namecall", newcclosure(function(Self: Object, ...: any): any
  local Method: string = getnamecallmethod()
  if Method == "GetService" and Self == game then
    setnamecallmethod("FindService")
  end
  print(getnamecallmethod()); --> "FindService"
  return hook(Self, unpack({...}));
end));
```

---

### `islclosure`

Returns `true` if the function is made by `LUA`.

---

### `iscclosure`

Returns `true` if the function was made by `C`.  
(Internally made by FiOne in this case.)

---

### `newcclosure`

Creates and pushes a new `C` Closure onto the provided function

---

### `getcallingscript`

Gets and returns the ``script`` that is invoking the current ``thread``.

---

## 📂 Table Functions

### `isreadonly`

Returns `true` if the given table or userdata is readonly.

```lua
local Yeah = {}
table.freeze(Yeah)
print(isreadonly(Yeah)) --> true
```

| **Parameter** | **Type** | **Description**     |
|---------------|----------|---------------------|
| `Table`       | `any`    | Table to check.     |

---

### `setreadonly`

Sets the given table or userdata to the specified readonly state.

```lua
local Yeah = {}
table.freeze(Yeah)
setreadonly(Yeah, false)
print(isreadonly(Yeah)) --> false
```

| **Parameter** | **Type**             | **Description**                          |
|---------------|----------------------|------------------------------------------|
| `Table`       | `table or userdata`  | Table to set.                            |
| `State`       | `boolean`            | Readonly state (`true` or `false`).      |

---

![image](https://github.com/user-attachments/assets/139d321b-6961-494f-9311-62dc8525a77d)


