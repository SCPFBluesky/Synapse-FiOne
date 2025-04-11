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

Returns a table of the `roblox` environment table.

---

### `getreg`

Returns a table of the LUA registry.

---

## 🧠 Metatable Functions

### `getrawmetatable`

Returns the metatable of a table or userdata, even if the metatable has the `__metatable` metamethod.

| **Parameter** | **Type**             | **Description** |
|---------------|----------------------|-----------------|
| `Object`      | `userdata or table`  | The target.     |

```lua
local raw = getrawmetatable(game)
table.foreach(raw, print)
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
local hook
hook = hookmetamethod(game, "__index", function(Self, ...)
    
end)
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
local hook
hook = hooknamecallmethod(game, function(Self, ...)
    
end)
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
local function yeah(X, Y, Z)
  print("Our x", X)
end

local oldyeah
oldyeah = hookfunction(yeah, function(X, Y, Z)
  if X == 4 then
    X = 3
  end
  return oldyeah(X, Y, Z)
end)

yeah(4, 6, 9)
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

Returns the name of the called method, typically used with `__namecall` hooks.

```lua
local hook
hook = hookmetamethod(game, "__namecall", function(Self, ...)
  local Method = getnamecallmethod()
  if Method == "GetService" then
    print("GetService called.")
  end
end)
```

---

### `getthreadidentity`

Returns the number of the current thread identification level.

---

### `setnamecallmethod`

Sets the current `__namecall` method to your own.

```lua
local hook
hook = hookmetamethod(game, "__namecall", function(Self, ...)
  local Method = getnamecallmethod()
  if Method == "GetService" then
    setnamecallmethod("FindService")
  end
end)
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

![image](https://github.com/user-attachments/assets/85cf423c-888e-4ea8-9666-01a40369224c)

