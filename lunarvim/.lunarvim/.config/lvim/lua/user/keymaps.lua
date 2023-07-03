-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.visual_mode["<A-j>"] = ":m .+1<CR>=="
lvim.keys.visual_mode["<A-k>"] = ":m .-2<CR>=="

lvim.keys.normal_mode["<leader>rr"] = "viwP"
-- Visual Block --
-- Move text up and down
lvim.keys.visual_block_mode["K"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_block_mode["J"] = ":move '>+1<CR>gv-gv"

lvim.keys.visual_block_mode["<A-k>"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_block_mode["<A-j>"] = ":move '>+1<CR>gv-gv"

-- Resize with arrows
lvim.keys.normal_mode["<A-j>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<A-k>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<A-h>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["<A-l>"] = ":vertical resize +2<CR>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["<tab>"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }

lvim.keys.normal_mode["<A-j>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<A-k>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<A-h>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["<A-l>"] = ":vertical resize +2<CR>"

lvim.keys.normal_mode["yow"] = ":set wrap!<cr>"
lvim.keys.normal_mode["yoc"] = ":set cursorline!<cr>"
lvim.keys.normal_mode["yoh"] = ":set hlsearch!<cr>"
lvim.keys.normal_mode["yol"] = ":set list!<cr>"
lvim.keys.normal_mode["yoi"] = ":set ignorecase!<cr>"
lvim.keys.normal_mode["yon"] = ":set number!<cr>"
lvim.keys.normal_mode["yor"] = ":set relativenumber!<cr>"
lvim.keys.normal_mode["yos"] = ":set spell!<cr>"
lvim.keys.normal_mode["you"] = ":set cursorcolumn!<cr>"
lvim.keys.normal_mode["yov"] = ":set virtualedit!<cr>"
