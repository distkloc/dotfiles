local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.ambiwidth = "single"
opt.wildmenu = true
opt.cmdheight = 1
opt.laststatus = 2
opt.showcmd = true

opt.ignorecase = true 
opt.smartcase = true

opt.hidden = true

opt.backup = true
opt.backupdir = os.getenv("HOME") .. '/.vim/backup'

opt.winblend = 20
opt.pumblend = 20
opt.termguicolors = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.number = true
opt.cursorline = true
opt.wrap = false

opt.nrformats = "bin,hex"
opt.swapfile = false

opt.history = 1000
opt.fixendofline = true

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]


vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('v', 'jk', '<Esc>', { silent = true })
vim.keymap.set('c', 'jk', '<C-c>', { silent = true })

-- ビジュアルモードでペースト時に削除したテキストをレジスタに残さない
vim.keymap.set('v', 'p', '"_dP', { silent = true })

-- ビジュアルモードで削除時にレジスタに入れない
vim.keymap.set('v', 'd', '"_d', { silent = true })
vim.keymap.set('v', 'x', '"_x', { silent = true })
