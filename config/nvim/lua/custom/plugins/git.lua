return {
  {
    "airblade/vim-gitgutter",
    event = "BufReadPre", -- Load on buffer read for performance
    config = function()
      -- Optional: Customize vim-gitgutter settings
      vim.g.gitgutter_enabled = 1              -- Enable gitgutter by default
      vim.g.gitgutter_signs = 1                -- Show signs in the sign column
      vim.g.gitgutter_highlight_lines = 0      -- Disable line highlighting (optional)
      vim.g.gitgutter_highlight_linenrs = 0    -- Disable line number highlighting
      vim.g.gitgutter_async = 1                -- Run diffs asynchronously
      vim.g.gitgutter_sign_priority = 6        -- Set sign priority
      vim.g.gitgutter_max_signs = 500          -- Limit signs for large files
      vim.g.gitgutter_preview_win_floating = 1 -- Use floating window for previews (Neovim)

      -- Custom signs (optional, requires Nerd Font or UTF-8 terminal)
      vim.g.gitgutter_sign_added = '+'
      vim.g.gitgutter_sign_modified = '>'
      vim.g.gitgutter_sign_removed = '-'
      vim.g.gitgutter_sign_removed_first_line = '^'
      vim.g.gitgutter_sign_modified_removed = '<'

      -- Key mappings for gitgutter
      vim.keymap.set('n', ']h', '<Plug>(GitGutterNextHunk)', { desc = 'Next git hunk' })
      vim.keymap.set('n', '[h', '<Plug>(GitGutterPrevHunk)', { desc = 'Previous git hunk' })
      vim.keymap.set('n', '<leader>hp', '<Plug>(GitGutterPreviewHunk)', { desc = 'Preview git hunk' })
      vim.keymap.set('n', '<leader>hs', '<Plug>(GitGutterStageHunk)', { desc = 'Stage git hunk' })
      vim.keymap.set('n', '<leader>hu', '<Plug>(GitGutterUndoHunk)', { desc = 'Undo git hunk' })

      -- Update signs when saving
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          vim.cmd("GitGutter")
        end,
      })

      -- Set updatetime for faster sign updates (default is 4000ms)
      vim.opt.updatetime = 250
    end,
  },
}
