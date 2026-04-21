-- 彩虹缩进线插件配置
Ice.plugins["indent-blankline"] = {
  "lukas-reineke/indent-blankline.nvim",
  event = "User IceAfter nvim-treesitter",
  main = "ibl",
  opts = {
    indent = {
      char = "╎",
      highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      },
    },
    whitespace = {
      highlight = {
        "Whitespace",
      },
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      char = "·",
      highlight = { "Normal" },
    },
    exclude = {
      filetypes = {
        "help",
        "dashboard",
        "nvim-tree",
        "toggleterm",
        "markdown",
        "lazy",
        "mason",
      },
    },
  },
  config = function(_, opts)
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup(opts)
  end,
}

-- 终端插件配置（浮动/水平/垂直终端）
Ice.plugins.toggleterm = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",

  keys = {
    { "<leader>mf", "<cmd>ToggleTerm direction=float<CR>",      desc = "Toggle Floating terminal" },
    { "<leader>mh", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Horizontal terminal" },
    { "<leader>mv", "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Toggle Vertical terminal" },
  },

  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return 60
      end
    end,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    hide_numbers = true,
    shade_terminals = false,
  },
}

-- Markdown 渲染插件配置（关闭 LaTeX 渲染）
Ice.plugins.render_markdown = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "md" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  init = function()
    vim.g.render_markdown_enabled = true
  end,

  opts = {
    enabled = true,
    max_file_size = 10.0,
    debounce = 100,
    preset = 'none',
    markdown_query = [[
        (atx_heading [
            (atx_h1_marker)
            (atx_h2_marker)
            (atx_h3_marker)
            (atx_h4_marker)
            (atx_h5_marker)
            (atx_h6_marker)
        ] @heading)

        (thematic_break) @dash

        (fenced_code_block) @code

        [
            (list_marker_plus)
            (list_marker_minus)
            (list_marker_star)
        ] @list_marker

        (task_list_marker_unchecked) @checkbox_unchecked
        (task_list_marker_checked) @checkbox_checked

        (block_quote) @quote

        (pipe_table) @table
    ]],
    markdown_quote_query = [[
        [
            (block_quote_marker)
            (block_continuation)
        ] @quote_marker
    ]],
    inline_query = [[
        (code_span) @code

        (shortcut_link) @shortcut

        [(inline_link) (full_reference_link) (image)] @link
    ]],
    log_level = 'error',
    file_types = { 'markdown' },
    render_modes = { 'n', 'c' },
    acknowledge_conflicts = false,
    anti_conceal = {
        enabled = true,
        above = 0,
        below = 0,
    },
    latex = {
        enabled = false,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        top_pad = 0,
        bottom_pad = 0,
    },
    heading = {
        enabled = true,
        sign = true,
        position = 'overlay',
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        signs = { '󰫎 ' },
        width = 'full',
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_prefix = false,
        above = '▄',
        below = '▀',
        backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
        },
        foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
        },
    },
    code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
        disable_background = { 'diff' },
        width = 'full',
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = 'thin',
        above = '▄',
        below = '▀',
        highlight = 'RenderMarkdownCode',
        highlight_inline = 'RenderMarkdownCodeInline',
    },
    dash = {
        enabled = true,
        icon = '─',
        width = 'full',
        highlight = 'RenderMarkdownDash',
    },
    bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        left_pad = 0,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
    },
    checkbox = {
        enabled = true,
        unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
        },
        checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
        },
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
        },
    },
    quote = {
        enabled = true,
        icon = '▋',
        repeat_linebreak = true,
        highlight = 'RenderMarkdownQuote',
    },
    pipe_table = {
        enabled = true,
        preset = 'round',
        style = 'full',
        cell = 'padded',
    },
  },

  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
  },
}

-- ==============================================
-- LSP 语言服务配置
-- ==============================================

Ice.lsp.pyright.enabled = true      -- Python
Ice.lsp.clangd.enabled = true       -- C/C++
Ice.lsp["html-lsp"].enabled = true  -- HTML
Ice.lsp["css-lsp"].enabled = true   -- CSS
Ice.lsp["json-lsp"].enabled = true  -- JSON
Ice.lsp["typescript-language-server"].enabled = true  -- TypeScript/JavaScript
Ice.lsp["emmet-ls"].enabled = true  -- Emmet
Ice.lsp.tinymist.enabled = true     -- Typst

-- ==============================================
-- 编辑器基础设置
-- ==============================================

-- 界面显示
vim.opt.termguicolors = true     -- 启用真彩色
vim.opt.number = true            -- 显示行号
vim.opt.relativenumber = true    -- 显示相对行号
vim.opt.cursorline = true        -- 高亮当前行
vim.opt.wrap = false             -- 不换行
vim.opt.scrolloff = 10           -- 滚动时保留上下文
vim.opt.sidescrolloff = 10       -- 水平滚动保留上下文
vim.opt.fillchars = { eob = " " }-- 隐藏行尾波浪号

-- 缩进设置（4空格）
vim.opt.tabstop = 4              -- Tab 显示宽度
vim.opt.shiftwidth = 4           -- 自动缩进宽度
vim.opt.softtabstop = 4          -- 编辑模式 Tab 宽度
vim.opt.expandtab = true         -- Tab 转空格
vim.opt.smartindent = true       -- 智能缩进
vim.opt.autoindent = true        -- 自动缩进

-- 搜索设置
vim.opt.ignorecase = true        -- 忽略大小写
vim.opt.smartcase = true         -- 智能大小写匹配
vim.opt.hlsearch = true          -- 高亮搜索结果
vim.opt.incsearch = true         -- 增量搜索

-- UI 配置
vim.opt.signcolumn = "yes"       -- 显示签名列
vim.opt.colorcolumn = "100"      -- 第100列标记线
vim.opt.showmatch = true         -- 高亮匹配括号
vim.opt.cmdheight = 1            -- 命令行高度
vim.opt.completeopt = "menuone,noinsert,noselect"  -- 补全选项
vim.opt.showmode = false         -- 不显示模式
vim.opt.pumheight = 10           -- 补全菜单高度
vim.opt.pumblend = 10            -- 补全菜单透明度
vim.opt.winblend = 0             -- 窗口透明度
vim.opt.conceallevel = 0         -- 不隐藏特殊字符
vim.opt.lazyredraw = true        -- 延迟重绘
vim.opt.synmaxcol = 300          -- 语法高亮最大列数

-- 持久化设置
local undodir = vim.fn.expand("~/.local/undodir")
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, "p") end
vim.opt.backup = false           -- 禁用备份
vim.opt.writebackup = false      -- 写入时禁用备份
vim.opt.swapfile = false         -- 禁用交换文件
vim.opt.undofile = true          -- 启用持久化撤销
vim.opt.undodir = undodir        -- 撤销文件目录
vim.opt.updatetime = 300         -- 更新延迟
vim.opt.timeoutlen = 500         -- 按键超时
vim.opt.ttimeoutlen = 50         -- 终端按键超时

-- 文件与编辑
vim.opt.autoread = true          -- 自动读取外部修改
vim.opt.autowrite = false        -- 禁用自动写入
vim.opt.hidden = true            -- 允许隐藏缓冲区
vim.opt.errorbells = false       -- 禁用错误铃声
vim.opt.backspace = "indent,eol,start"  -- Backspace 行为
vim.opt.autochdir = false        -- 不自动切换目录
vim.opt.iskeyword:append("-")    -- 连字符作为单词一部分
vim.opt.path:append("**")        -- 搜索路径
vim.opt.selection = "inclusive"  -- 选择模式
vim.opt.mouse = "a"              -- 启用鼠标
vim.opt.clipboard:append("unnamedplus")  -- 系统剪贴板
vim.opt.modifiable = true        -- 可修改
vim.opt.encoding = "utf-8"       -- 编码

-- 代码折叠（Treesitter）
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- 窗口分割
vim.opt.splitbelow = true        -- 向下分割
vim.opt.splitright = true        -- 向右分割

-- 命令行补全
vim.opt.wildmenu = true          -- 命令行菜单
vim.opt.wildmode = "longest:full,full"  -- 补全模式

-- 差异比较
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000


-- 全局诊断配置
vim.diagnostic.config({
  -- 关闭行尾飘字
  virtual_text = false,

  -- 开启下一行显示错误
  virtual_lines = true,

  -- 保留左侧标记和下划线
  signs = true,
  underline = true,

  -- 悬浮窗口样式
  float = {
    border = "rounded",
    source = "always",
  },
})

-- ==============================================
-- 快捷键配置
-- ==============================================

vim.g.mapleader = " "      -- 定义 leader 键
vim.g.maplocalleader = " " -- 定义局部 leader 键


-- 可选：按 gl 查看当前行详细错误
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- 导航移动
vim.keymap.set("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true, silent = true, desc = "Up (wrap-aware)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- 窗口导航
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- 窗口管理
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Buffer 管理
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Prev buffer" })

-- 编辑操作
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yank" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yank" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- 工具函数
vim.keymap.set("n", "<leader>cc", ":nohlsearch<CR>", { desc = "Clear search" })
vim.keymap.set("n", "<leader>pa", function() local p = vim.fn.expand("%:p"); vim.fn.setreg("+", p); print("file:", p) end, { desc = "Copy file path" })
vim.keymap.set("n", "<leader>td", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle diagnostics" })

-- ==============================================
-- 自动命令配置
-- ==============================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- 保存前自动格式化
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = { "*.lua", "*.py", "*.go", "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.scss", "*.html", "*.sh", "*.bash", "*.zsh", "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable or vim.api.nvim_buf_get_name(args.buf) == "" then return end
        local has_formatter = false
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
            if c.server_capabilities.documentFormattingProvider then has_formatter = true break end
        end
        if not has_formatter then return end
        local null_ls_client = nil
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
            if c.name == "null-ls" then null_ls_client = c break end
        end
        pcall(vim.lsp.buf.format, {
            bufnr = args.buf, timeout_ms = 2000,
            filter = function(c) return null_ls_client and c.name == "null-ls" or c.server_capabilities.documentFormattingProvider end
        })
    end,
})

-- 复制时高亮
vim.api.nvim_create_autocmd("TextYankPost", { group = augroup, callback = function() vim.hl.on_yank() end })

-- 恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        if vim.o.diff then return end
        local last_pos = vim.api.nvim_buf_get_mark(0, '"')
        local row = last_pos[1]
        if row >= 1 and row <= vim.api.nvim_buf_line_count(0) then pcall(vim.api.nvim_win_set_cursor, 0, last_pos) end
    end,
})

-- Markdown/text 自动换行和拼写检查
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})

-- ==============================================
-- Neovide GUI 配置
-- ==============================================

if vim.g.neovide then
    vim.o.guifont = "Monaco Nerd Font Mono:h16"  -- 字体
    vim.opt.linespace = 6                        -- 行间距
    vim.g.neovide_scale_factor = 1.0             -- 缩放因子
    vim.g.neovide_remember_window_size = true    -- 记住窗口大小
    vim.g.neovide_opacity = 0.8                  -- 窗口透明度
    vim.g.neovide_window_blurred = true          -- 窗口模糊
    vim.g.neovide_text_gamma = 0.8               -- 文字伽马值
    vim.g.neovide_text_contrast = 0.15           -- 文字对比度
    vim.g.neovide_padding_top = 12               -- 顶部边距
    vim.g.neovide_padding_bottom = 12            -- 底部边距
    vim.g.neovide_padding_left = 12              -- 左边距
    vim.g.neovide_padding_right = 12             -- 右边距
    vim.g.neovide_cursor_animation_length = 0.06 -- 光标动画长度
    vim.g.neovide_cursor_trail_size = 0.3        -- 光标拖尾大小
end
