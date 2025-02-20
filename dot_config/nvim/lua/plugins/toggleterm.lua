return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup{
      open_mapping = [[<C-_>]],
    }

    local Terminal  = require('toggleterm.terminal').Terminal
    -- Lazygit Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        vim.opt.titlestring = "lazygit"        
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
        -- on close neotree refresh stats files (git icon)
        local state = require("neo-tree.sources.manager").get_state("filesystem")
        require("neo-tree.sources.filesystem.commands").refrsh(state)
      end,
    })
    function _lazygit_toggle()
      lazygit:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
  end
}

