return {
  "folke/persistence.nvim",
  opts = function()
    -- local group = vim.api.nvim_create_augroup("user-persistence", { clear = true })
    -- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    -- vim.api.nvim_create_autocmd("User", {
    --   group = group,
    --   pattern = "PersistenceSavePre",
    --   callback = function()
    --     vim.cmd(":Neotree close")
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd("User", {
    --   group = group,
    --   pattern = "PersistenceLoadPost",
    --   callback = function()
    --     vim.cmd(":Neotree show")
    --   end,
    -- })
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceLoadPost",
      callback = function()
        -- function dump(o)
        --   if type(o) == "table" then
        --     local s = "{ "
        --     for k, v in pairs(o) do
        --       if type(k) ~= "number" then
        --         k = '"' .. k .. '"'
        --       end
        --       s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        --     end
        --     return s .. "} "
        --   else
        --     return tostring(o)
        --   end
        -- end
        local test_buffers = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)")
        local next = next
        if next(test_buffers) ~= nil then
          -- print(dump(test_buffers))
          for _, v in pairs(test_buffers) do
            -- or we can use vim.fn.getcwd() instead of LazyVim.root()
            -- print(v, LazyVim.root(), vim.fn.bufname(v))
            if vim.api.nvim_buf_get_name(v) == LazyVim.root() then
              -- print(v, vim.fn.bufname(v), dump(vim.fn.getbufvar(v, "")))
              local cmdstr = ":silent! bw!" .. " " .. v
              vim.cmd(cmdstr)
            end
          end
        end
      end,
    })
    -- Auto delete [No Name] and directory buffers.
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceLoadPost",
      callback = function()
        local buffers = vim.fn.filter(
          vim.fn.range(1, vim.fn.bufnr("$")),
          'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])'
        )
        if next(buffers) == nil then
          return
        end
        local cmdstr = ":silent! bw!"
        for _, v in pairs(buffers) do
          cmdstr = cmdstr .. " " .. v
        end
        vim.cmd(cmdstr)
      end,
    })
  end,
}
