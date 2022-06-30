local status_ok, Hydra = pcall(require, "hydra")
if not status_ok then
  return
end
local git_status_ok, gitsigns = pcall(require, "gitsigns")
if not git_status_ok then
  return
end

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

Hydra({
   hint = hint,
   config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
         position = 'bottom',
         border = 'rounded'
      },
      on_enter = function()
         vim.bo.modifiable = false
         gitsigns.toggle_signs(true)
         gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
         gitsigns.toggle_signs(false)
         gitsigns.toggle_linehl(false)
         gitsigns.toggle_deleted(false)
         vim.cmd 'echo' -- clear the echo area
      end
   },
   mode = {'n','x'},
   body = '\\g',
   heads = {
      { 'J', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 'K', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true } },
      { 'u', gitsigns.undo_stage_hunk },
      { 'S', gitsigns.stage_buffer },
      { 'p', gitsigns.preview_hunk },
      { 'd', gitsigns.toggle_deleted, { nowait = true } },
      { 'b', gitsigns.blame_line },
      { 'B', function() gitsigns.blame_line{ full = true } end },
      { '/', gitsigns.show, { exit = true } }, -- show the base of the file
      { '<Enter>', '<cmd>Neogit<CR>', { exit = true } },
      { 'q', nil, { exit = true, nowait = true } },
   }
})

Hydra({
   config = {
      color = 'teal',
      -- color = 'pink',
      invoke_on_body = true,
      hint = {
         position = 'top',
         -- border = 'rounded'
      },
      on_enter = function()
         -- vim.bo.modifiable = false
      end,
      on_exit = function()
         vim.cmd 'echo' -- clear the echo area
      end
   },
   name = 'nvim-gdb debug',
   mode = {'n','x'},
   body = '\\dd',
   heads = {
      { 'r', ':GdbStart gdb -q ', { desc = 'start gdb'} },
      { 'b', ':GdbBreakpointToggle<CR>', { desc = 'break'} },
      { 'c', ':GdbContinue<CR>', { desc = 'continue'} },
      { 'n', ':GdbNext<CR>', { desc = 'next'} },
      { 's', ':GdbStep<CR>', { desc = 'step'} },
      { 'f', ':GdbFinish<CR>', { desc = 'finish',} },
      { 'L', ':GdbLopenBacktrace<CR>', { desc = 'back trace' } },
      { 'B', ':GdbLopenBreakpoints<CR>', { desc = 'break points' } },
      { 'u', ':GdbFrameUp<CR>', { desc = 'frame up' } },
      { 'd', ':GdbFrameDown<CR>', { desc = 'frame down' } },
      { 'q', nil, { exit = true, nowait = true } },
   }
})

Hydra({
   config = {
      -- color = 'teal',
      color = 'pink',
      -- color = 'amaranth',
      invoke_on_body = true,
      hint = {
         position = 'top',
         -- border = 'rounded'
      },
      on_enter = function()
         -- vim.bo.modifiable = false
      end,
      on_exit = function()
         vim.cmd 'echo' -- clear the echo area
      end
   },
   name = 'nvim-gdb debug',
   mode = {'n','x'},
   body = '\\dt',
   heads = {
      { 'a', ':packadd termdebug<cr>', { desc = 'set termdebug',nowait = true,exit = true} },
      { 'r', ':TermdebugCommand ', { desc = 'term command',nowait = true,exit = true} },
      { 'b', ':Break<CR>', { desc = 'break',nowait = true} },
      { 'n', ':Over<CR>', { desc = 'next',nowait = true} },
      { 's', ':Step<CR>', { desc = 'step',nowait = true} },
      { 'f', ':Finish<CR>', { desc = 'finish',nowait = true} },
      { 'c', ':Continue<CR>', { desc = 'continue',nowait = true} },
      { 'x', ':Stop<CR>', { desc = 'Stop',nowait = true} },
      { 'u', ':clear<CR>', { desc = 'clear break',nowait = true} },
      { 'q', nil, { exit = true, nowait = true } },
   }
})
