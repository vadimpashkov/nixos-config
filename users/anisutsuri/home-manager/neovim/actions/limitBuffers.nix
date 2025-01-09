{
  # TODO: Тут баг
  programs.nixvim.extraConfigLua = ''
    local function limit_buffers()
      local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      if #buffers > 2 then
        vim.cmd('bdelete ' .. buffers[1].bufnr)
      end
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      callback = limit_buffers,
      desc = "Ограничение количества буферов до двух",
    })
  '';
}
