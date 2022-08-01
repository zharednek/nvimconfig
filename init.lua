-- // Packages
require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter'
    use 'kyazdani42/nvim-tree.lua'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'tamton-aquib/staline.nvim'
    --use 'neovim/nvim-lspconfig'
    --use 'williamboman/nvim-lsp-installer'
    use {'catppuccin/nvim', as = "catppuccin" }

    require("packer").sync()
end)

-- // Setup
local set = vim.opt
local bind = vim.api.nvim_set_keymap

local setts = { noremap = true, silent = true, }
local cat_setts = { "italic" }
local servers = { 'sumneko_lua', 'pyright', 'tsserver', 'clangd' }

vim.g.mapleader = ' '
vim.g.catppuccin_flavour = "macchiato"

-- // Options
set.fileencoding = "utf-8"
set.clipboard = "unnamedplus"
set.showmode = false
set.hidden = true
set.mouse = "a"

set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.autoindent = true
set.smartindent = true

set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true

set.number = true
set.wrap = false
set.scrolloff = 5
set.sidescrolloff = 7

-- // Keybindings

vim.g.mapleader = ' '

-- Editing

bind("n", "<c-s>", ":w<CR>", {})
bind("i", "<c-s>", "<Esc>:w<CR>a", {})

-- Window navigation
bind("n", "<c-j>", "<c-w>j", setts)
bind("n", "<c-h>", "<c-w>h", setts)
bind("n", "<c-k>", "<c-w>k", setts)
bind("n", "<c-l>", "<c-w>l", setts)

bind("n", "<leader>e", ":NvimTreeToggle<CR>", setts)

-- // Package setup
--[[local function on_attach(self, bufnr)
    local function nmap(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
    vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
    end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", 'v:lua.vim.lsp.omnifunc')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd',vim.lsp.buf.definition)
    nmap('gi',vim.lsp.buf.implementation)
    nmap('K',vim.lsp.buf.hover)
    nmap('<c-k>',vim.lsp.buf.signature_help)
    nmap('gD',vim.lsp.buf.declaration)
    nmap('<leader>D',vim.lsp.buf.type_definition)
    nmap('<leader>wa',vim.lsp.buf.add_workspace_folder)
    nmap('<leader>wr',vim.lsp.buf.remove_workspace_folder)
    nmap('<leader>wl',function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    
    vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format or vim.lsp.buf.formatting, { desc = "Format current buffer with LSP" })
end]]

require("indent_blankline").setup {
    char = "❘",
    show_trailing_blankline_indent = false,
}

require("nvim-tree").setup {
    open_on_setup = true,
    sort_by = "name",
    diagnostics = {
        enable = true,
    },
}

require("nvim-treesitter.configs").setup {
    ensure_installed = {'c', 'cpp', 'lua', 'javascript', 'python'},
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = { enable = true },
}

require("stabline").setup {
    style = "slant",
    bg = "#93c379",
    fg = "black",
    stab_right = "",
}

require("staline").setup {
    sections = {
        left = { "  ", "mode", " ", "branch", " ", "lsp" },
        mid = {},
        right = { "file_name", "line_column" },
    },
    mode_colors = {
        i = "#d4be98",
        n = "#8fbf7f",
        c = "#93c379",
        v = "#fc802d",
    },
    defaults = {
        true_colors = true,
        line_column = " [%l/%L] :%c ",
        branch_symbol = " ",
    },
}

--[[require("nvim-lsp-installer").setup {
    ensure_installer = servers,
)]]

require("catppuccin").setup {
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.1,
    },
    transparent_background = true,
    term_colors = false,
    styles = {
        comments = cat_setts,
        loops = cat_setts,
        functions = cat_setts,
        keywords = cat_setts,
        booleans = { "bold" },
        types = { "bold" },
    },
    nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = true,
    },
}
vim.cmd("colorscheme catppuccin")
