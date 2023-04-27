function prequire(module_name)
  local available, module = pcall(require, module_name)
  if available then
    return module, true
  else
    -- local home = os.getenv('HOME') --[[@as string]]
    -- local source = debug.getinfo(2, "S").source:sub(2) :gsub(home, '~')
    -- local msg = string.format('"%s" requested in "%s" not available', module_name, source)
    -- vim.schedule(function() vim.notify_once(msg, vim.log.levels.WARN) end)

    return nil, false
  end
end

local os_sep = package.config:sub(1, 1)
local api = vim.api
local fn = vim.fn
local bo = vim.bo

if not pcall(require, 'heirline') then return end

local dap = prequire('dap')
local devicons = prequire('nvim-web-devicons')
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local status_utils = require("user.heirline.util")
local icons = status_utils.icons
local mode = status_utils.mode

local theme = require('user.heirline.themes.gruvbox-material')
local hl = theme.highlight
local heir_colors = theme.colors
local lsp_colors = theme.lsp_colors
local Navic = {
   static = {
      -- create a type highlight map
      type_hl = {
         File = 'Directory',
         Module = 'Include',
         Namespace = 'TSNamespace',
         Package = 'Include',
         Class = 'Struct',
         Method = '@method',
         Property = 'TSProperty',
         Field = 'TSField',
         Constructor = 'TSConstructor',
         Enum = 'TSField',
         Interface = 'Type',
         Function = 'Keyword',
         Variable = 'TSVariable',
         Constant = 'Constant',
         String = 'String',
         Number = 'Number',
         Boolean = 'Boolean',
         Array = 'TSField',
         Object = 'Type',
         Key = 'TSKeyword',
         Null = 'Comment',
         EnumMember = 'TSField',
         Struct = 'Struct',
         Event = 'Keyword',
         Operator = 'Operator',
         TypeParameter = 'Type',
      },
   },
   condition = function(self)
      local navic_status_ok, navic = pcall(require, "nvim-navic")
      if not navic_status_ok then
        return false
      end

      if not navic.is_available() then
         return false
      end

      local data = navic.get_data() or {}
      if vim.tbl_isempty(data) then
         return false
      end
      local children = {}
      -- create a child for each level
      for i, d in ipairs(data) do
         local child = {
            {
               provider = d.icon,
               hl = function ()
                 return self.type_hl[d.type]
               end
            },
            {
               provider = d.name,
               -- highlight icon only or location name as well
               -- hl = self.type_hl[d.type],
            },
         }
         -- add a separator only if needed
         if 1 < #data and i < #data then

            table.insert(child, {
               provider = ' > ',
               hl = function ()
                 return {fg = hl.Navic.Separator.fg, bg = utils.get_highlight("Statusline").bg}
               end

            })
         end
         table.insert(children, child)
      end
      -- instantiate the new child, overwriting the previous one
      self[1] = self:new(children, 1)
      return true
   end,
}

local priority = {
  CurrentPath = 60,
  Git = 40,
  WorkDir = 25,
  Lsp = 10,
}

--[[ =========================================================================j ]]
local LeftCap = {
  provider = '▌',
  -- provider = '',
  hl = function()
    return { fg = hl.Mode.normal.fg, bg = utils.get_highlight("Statusline").bg }
  end
}

local Align, Space, Null, ReadOnly
do
  Null = { provider = '' }

  Align = { provider = '%=' }

  Space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end
  })

  ReadOnly = {
    condition = function() return not bo.modifiable or bo.readonly end,
    provider = icons.padlock,
    hl = function()
      return { fg = hl.ReadOnly.fg, bg = utils.get_highlight("Statusline").bg }
    end
  }
end

local VimMode
do
  local NormalModeIndicator = {
    Space,
    {
      fallthrough = false,
      ReadOnly,
      {
        provider = icons.circle,
        hl = function()
          if bo.modified then
            return { fg = heir_colors.red, bg = utils.get_highlight("Statusline").bg }
          else
            return { fg = hl.Mode.normal.fg, bg = utils.get_highlight("Statusline").bg }
          end
        end
      }
    },
    Space
  }

  local ActiveModeIndicator = {
    condition = function(self)
      return self.mode ~= 'normal'
    end,
    hl = function()
      return { bg = utils.get_highlight("Statusline").bg }
    end,
    utils.surround(
      { icons.powerline.left_rounded, icons.powerline.right_rounded },
      function(self) -- color
        return hl.Mode[self.mode].bg
      end,
      {
        {
          fallthrough = false,
          ReadOnly,
          { provider = icons.circle }
        },
        Space,
        {
          provider = function(self)
            return status_utils.mode_lable[self.mode]
          end,
        },
        hl = function(self)
          return hl.Mode[self.mode]
        end
      }
    )
  }

  VimMode = {
    init = function(self)
      self.mode = mode[fn.mode(1)] -- :h mode()
    end,
    condition = function() return bo.buftype == '' end,
    {
      fallthrough = false,
      ActiveModeIndicator,
      NormalModeIndicator,
    }
  }
end

local FileNameBlock, CurrentPath, FileName
do
  local FileIcon = {
    condition = function()
      return not ReadOnly.condition()
    end,
    init = function(self)
      local filename = self.filename
      local extension = fn.fnamemodify(filename, ':e')
      self.icon, self.icon_color = devicons.get_icon_color(
        filename, extension, { default = true })
    end,
    provider = function(self)
      if self.icon then return self.icon .. ' ' end
    end,
    hl = function(self)
      --[[ return { fg = self.icon_color, bg = utils.get_highlight("Statusline").bg } ]]
      return { fg = self.icon_color, bg = heir_colors.black }
    end
  }

  local WorkDir = {
    condition = function(self)
      if bo.buftype == '' then
        return self.pwd
      end
    end,
    hl = function()
      --[[ return { fg = hl.WorkDir.fg, bg = utils.get_highlight("Statusline").bg, bold = true } ]]
      return { fg = hl.WorkDir.fg, bg = heir_colors.black }
    end,
    flexible = priority.WorkDir,
    { provider = function(self) return self.pwd end },
    { provider = function(self) return fn.pathshorten(self.pwd) end },
    Null
  }

  CurrentPath = {
    condition = function(self)
      if bo.buftype == '' then
        return self.current_path
      end
    end,
    hl = function()
      --[[ return { bg = utils.get_highlight("Statusline").bg, bold = true } ]]
      return { bg = heir_colors.black, bold = true }
    end,
    flexible = priority.CurrentPath,
    { provider = function(self) return self.current_path end, },
    { provider = function(self) return fn.pathshorten(self.current_path, 2) end, },
    { provider = '' },
  }

  FileName = {
    provider = function(self) return self.filename end,
    hl = function()
      --[[ return { fg = utils.get_highlight("Statusline").fg, bg = utils.get_highlight("Statusline").bg } ]]
      return { bg = heir_colors.black }
    end
  }

  FileNameBlock = {
    { FileIcon, WorkDir, CurrentPath, FileName },
    -- This means that the statusline is cut here when there's not enough space.
    { provider = '%<' }
  }
end

local FileProperties = {
  condition = function(self)
    self.filetype = bo.filetype

    local encoding = (bo.fileencoding ~= '' and bo.fileencoding) or vim.o.encoding
    self.encoding = encoding or nil

    local fileformat = bo.fileformat
    -- if fileformat == 'dos' then
    --    fileformat = ' '
    -- elseif fileformat == 'mac' then
    --    fileformat = ' '
    -- else  -- unix'
    --    fileformat = ' '
    --    -- fileformat = nil
    -- end

    if fileformat == 'dos' then
      fileformat = 'CRLF'
    elseif fileformat == 'mac' then
      fileformat = 'CR'
    else -- 'unix'
      fileformat = 'LF'
    end

    self.fileformat = fileformat
    return true
    --[[ return self.fileformat or self.encoding ]]
  end,
  provider =
  function(self)
    local sep = (self.fileformat and self.encoding) and ' ' or ''
    return table.concat { '[', self.fileformat or '', sep, self.encoding or '', ']' }
  end,
  hl = hl.FileProperties,
}

Indicator = {
  fallthrough = false,
  VimMode
}

local Ruler = {
  -- :help 'statusline'
  -- ------------------
  -- %-2 : make item takes at least 2 cells and be left justified
  -- %l  : current line number
  -- %L  : number of lines in the buffer
  -- %c  : column number
  -- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
  provider = ' %9(%l:%L%)  %-3(%c%V%) ',
  hl = function()
    return {bg = utils.get_highlight("StatusLine").bg, bold = true }
  end,
}

local ScrollPercentage = {
  condition = function() return conditions.width_percent_below(4, 0.035) end,
  -- %P  : percentage through file of displayed window
  provider = ' %3(%P%) ',
  hl = { fg = hl.StatusLine.fg, bg = utils.get_highlight("Statusline").bg }
}

local DapMessages = {
  -- display the dap messages only on the debugged file
  condition = function()
    -- local session = dap_available and dap.session()
    local session = dap.session()
    if session then
      local filename = api.nvim_buf_get_name(0)
      if session.config then
        local progname = session.config.program
        return filename == progname
      end
    end
    return false
  end,
  provider = function()
    return ' ' .. dap.status() .. ' '
  end,
  hl = function()
    return {fg = hl.DapMessages.fg, bg = utils.get_highlight("StatusLine").bg, bold = true }
  end,
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    -- error_icon = '󰂭 ',
    error_icon = fn.sign_getdefined('DiagnosticSignError')[1].text,
    warn_icon  = fn.sign_getdefined('DiagnosticSignWarn')[1].text,
    info_icon  = fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    hint_icon  = fn.sign_getdefined('DiagnosticSignHint')[1].text,
  },
  init = function(self)
    self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      if self.errors > 0 then
        return table.concat { self.error_icon, self.errors, ' ' }
      end
    end,
    hl = function()
      return {fg = hl.Diagnostic.error.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  },
  {
    provider = function(self)
      if self.warnings > 0 then
        return table.concat { self.warn_icon, self.warnings, ' ' }
      end
    end,
    hl = function()
      return {fg = hl.Diagnostic.warn.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  },
  {
    provider = function(self)
      if self.info > 0 then
        return table.concat { self.info_icon, self.info, ' ' }
      end
    end,
    hl = function()
      return {fg = hl.Diagnostic.info.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  },
  {
    provider = function(self)
      if self.hints > 0 then
        return table.concat { self.hint_icon, self.hints, ' ' }
      end
    end,
    hl = function()
      return {fg = hl.Diagnostic.hint.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  },
  Space(2)
}

local Git
do
  local GitBranch = {
    condition = conditions.is_git_repo,
    init = function(self)
      self.git_status = vim.b.gitsigns_status_dict
    end,
    hl = function()
      return {fg = hl.Git.branch.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
    provider = function(self)
      return table.concat { ' ', self.git_status.head }
    end,
  }

  local GitChanges = {
    condition = function(self)
      if conditions.is_git_repo() then
        self.git_status = vim.b.gitsigns_status_dict
        local has_changes = self.git_status.added ~= 0 or
            self.git_status.removed ~= 0 or
            self.git_status.changed ~= 0
        return has_changes
      end
    end,
    provider = '  ',
    -- hl = hl.Git.branch
    -- hl = hl.Git.changed
    -- hl = hl.Git.added
    -- hl = hl.Git.removed
    hl = function()
      return {fg = hl.Git.dirty.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  }

  Git = { GitBranch, GitChanges, Space }
end

local Lsp
do
  local LspIndicator = {
    provider = icons.circle_small .. ' ',
    hl = hl.LspIndicator
  }

  local LspServer = {
    Space,
    {
      provider = function(self)
        local names = self.lsp_names
        if #names == 1 then
          names = names[1]
        else
          -- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
          names = table.concat(names, ', ')
        end
        return names
      end,
    },
    Space(2),
    hl = function()
      return {fg = hl.LspServer.fg, bg = utils.get_highlight("StatusLine").bg }
    end,
  }

  Lsp = {
    condition = conditions.lsp_attached,
    init = function(self)
      local names = {}
      for _, server in pairs(vim.lsp.buf_get_clients(0)) do
        table.insert(names, server.name)
      end
      self.lsp_names = names
    end,
    hl = function(self)
      local color
      for _, name in ipairs(self.lsp_names) do
        if lsp_colors[name] then
          color = lsp_colors[name]
          break
        end
      end
      if color then
        return { fg = color, bg = utils.get_highlight("StatusLine").bg, bold = true, force = true }
      else
        return { fg = hl.LspServer.fg, bg = utils.get_highlight("StatusLine").bg }
      end
    end,
    flexible = priority.Lsp,

    LspServer,
    LspIndicator
  }
end

local StatusLine = {
  init = function(self)
    local pwd = fn.getcwd(0) -- Present working directory.
    local current_path = api.nvim_buf_get_name(0)
    local filename

    if current_path == "" then
      pwd = fn.fnamemodify(pwd, ':~')
      current_path = nil
      filename = ' [No Name]'
    elseif current_path:find(pwd, 1, true) then
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h')
      pwd = fn.fnamemodify(pwd, ':~') .. os_sep
      if current_path == '.' then
        current_path = nil
      else
        current_path = current_path .. os_sep
      end
    else
      pwd = nil
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h') .. os_sep
    end

    self.pwd = pwd
    self.current_path = current_path -- The opened file path relevant to pwd.
    self.filename = filename
  end,
  { LeftCap,
    VimMode,
    Space,
    --[[ FileNameBlock, ]]
    Navic,
    Space(4),
    Align,
    DapMessages,
    Diagnostics,
    Git,
    Lsp,
    FileProperties,
    Ruler,
    ScrollPercentage },
}

local Winbar = {
  init = function(self)
    local pwd = fn.getcwd(0) -- Present working directory.
    local current_path = api.nvim_buf_get_name(0)
    local filename

    if current_path == "" then
      pwd = fn.fnamemodify(pwd, ':~')
      current_path = nil
      filename = ' [No Name]'
    elseif current_path:find(pwd, 1, true) then
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h')
      pwd = fn.fnamemodify(pwd, ':~') .. os_sep
      if current_path == '.' then
        current_path = nil
      else
        current_path = current_path .. os_sep
      end
    else
      pwd = nil
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h') .. os_sep
    end

    self.pwd = pwd
    self.current_path = current_path -- The opened file path relevant to pwd.
    self.filename = filename
  end,
  LeftCap,
  Space,
  FileNameBlock
}



require("heirline").setup({
  statusline = StatusLine,
  winbar =  Winbar,
  hl = function ()
    return { fg = hl.StatusLine.fg, bg = utils.get_highlight("StatusLine").bg, bold = true, force = true }
  end
})
