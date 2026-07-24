-- Compatibility shims for Neovim 0.11+ API deprecations
-- Loaded before plugins so all third-party code gets the fix automatically

if vim.fn.has('nvim-0.11') == 1 then
  -- vim.tbl_flatten -> vim.iter():flatten():totable()
  -- Deprecated in 0.11, removed in 0.13
  vim.tbl_flatten = function(t)
    return vim.iter(t):flatten(math.huge):totable()
  end

  -- vim.str_utfindex old signature -> new signature
  -- Old: vim.str_utfindex(s, index) returns (utf32, utf16)
  -- New: vim.str_utfindex(s, encoding, index) returns single value
  -- Deprecated in 0.11, removed in 1.0
  local _str_utfindex = vim.str_utfindex
  vim.str_utfindex = function(s, ...)
    local args = { ... }
    if type(args[1]) == 'number' then
      local utf32 = _str_utfindex(s, 'utf-32', args[1])
      local utf16 = _str_utfindex(s, 'utf-16', args[1])
      return utf32, utf16
    end
    return _str_utfindex(s, ...)
  end
end
