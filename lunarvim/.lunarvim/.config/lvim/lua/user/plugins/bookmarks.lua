return {
  {
    "crusj/bookmarks.nvim",
    branch = "main",
    opts = {
      keymap = {
        toggle = "m<tab>", -- Toggle bookmarks
        add = "mm", -- Add bookmarks
        jump = "<CR>", -- Jump from bookmarks
        delete = "md", -- Delete bookmarks
        order = "m<space>", -- Order bookmarks by frequency or updated_time
        delete_on_virt = "mr", -- Delete bookmark at virt text line
        show_desc = "mk", -- show bookmark desc
      },
    },

    keys = {
      { "mb", "<cmd>Telescope bookmarks<cr>", desc = "Bookmarks" },
    },
  },
}
