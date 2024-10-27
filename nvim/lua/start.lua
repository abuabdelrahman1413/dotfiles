vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- تثبيت مدير الحزم Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- أحدث إصدار مستقر
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  spec = {
    { import = "plugins" }  -- تحميل جميع الملفات الموجودة داخل مجلد plugins
  }
})

