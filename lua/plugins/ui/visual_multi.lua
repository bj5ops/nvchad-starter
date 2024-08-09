return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "mg979/vim-visual-multi",
      branch = "master",
      event = { "BufReadPost", "BufNewFile" },
      init = function()
        vim.g.VM_default_mappings = 0
        vim.g.VM_maps = {
          ["Find Under"] = "",
        }
        vim.g.VM_add_cursor_at_pos_no_mappings = 1
      end,
      keys = function()
        local map = vim.keymap.set

        local function visual_cursor_with_delay()
          -- Execute the vim-visual-multi cursor command
          vim.cmd 'silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"'
          -- Introduce delay via VimScript's sleep (set to 500 milliseconds here)
          vim.cmd "sleep 200m"
          -- Press: "A" in normal mode after the delay
          vim.cmd 'silent! execute "normal! A"'
        end

        -- map("n", "<C-n>", "<Plug>VM-Find-Next")
        -- map("n", "<C-p>", "<Plug>VM-Find-Prev")
        map("n", "<leader>vr", "<Plug>(VM-Start-Regex-Search)", { desc = "visual multi regex search" })
        map("n", "<leader>va", "<Plug>(VM-Select-All)<Tab>", { desc = "visual multi select all" })
        map("n", "<leader>vp", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "visual multi add cursor at pos" })
        map("v", "<leader>vc", visual_cursor_with_delay, { desc = "visual multi visual cursor" })
        map("n", "<leader>vo", "<Plug>(VM-Toggle-Mappings)", { desc = "visual multi toggle mappings" })
      end,
    }
  end

  return plugin
end
