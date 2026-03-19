local source = {}

local kind_map = {
  A = 14, -- Keyword
  C = 7,  -- Class
  E = 20, -- EnumMember
  H = 14, -- Keyword
  I = 8,  -- Interface
  K = 9,  -- Module
  L = 14, -- Keyword
  M = 5,  -- Field
  N = 6,  -- Variable
  O = 14, -- Keyword
  P = 9,  -- Module
  R = 14, -- Keyword
  S = 22, -- Struct
  T = 25, -- TypeParameter
  V = 14, -- Keyword
  b = 6,  -- Variable
  c = 21, -- Constant
  d = 14, -- Keyword
  e = 21, -- Constant
  f = 3,  -- Function
  i = 6,  -- Variable
  l = 8,  -- Interface
  m = 9,  -- Module
  n = 6,  -- Variable
  p = 5,  -- Field
  q = 14, -- Keyword
  r = 6,  -- Variable
  t = 3,  -- Function
  w = 5,  -- Field
}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:is_available()
  return vim.bo.filetype == "verilog_systemverilog"
end

function source:get_debug_name()
  return "tags"
end

function source:get_keyword_pattern()
  return [[\k\+]]
end

function source:complete(params, callback)
  local line = params.context.cursor_before_line
  local prefix = line:match("([%w_]+)$")
  if not prefix or #prefix < 2 then
    callback({ items = {}, isIncomplete = false })
    return
  end

  local escaped = vim.fn.escape(prefix, [[\.^$~[]]])
  local matches = vim.fn.taglist("^" .. escaped)
  local seen = {}
  local items = {}

  for _, tag in ipairs(matches) do
    local name = tag.name
    if name and name:find("^" .. prefix) and not seen[name] then
      seen[name] = true
      items[#items + 1] = {
        label = name,
        kind = kind_map[tag.kind] or 1,
        detail = string.format("[tags] %s", tag.filename or ""),
      }
    end

    if #items >= 100 then
      break
    end
  end

  callback({ items = items, isIncomplete = false })
end

return source
