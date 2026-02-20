{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    version.enableNixpkgsReleaseCheck = false;
    globals.mapleader = " ";

    # ── Options ──────────────────────────────────────────────────────────
    opts = {
      autoindent = true;
      smartindent = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      showtabline = 0;
      number = true;
      relativenumber = true;
      numberwidth = 4;
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      hidden = true;
      signcolumn = "yes";
      showmode = false;
      errorbells = false;
      wrap = false;
      cursorline = true;
      fileencoding = "utf-8";
      clipboard = "unnamedplus";
      backup = false;
      writebackup = false;
      swapfile = false;
      scrolloff = 5;
      scrolljump = 5;
      mouse = "a";
      guicursor = "a:block";
      title = true;
    };

    # ── Keymaps ───────────────────────────────────────────────────────────
    keymaps = [
      # NvimTree
      { mode = "n"; key = "<leader>m"; action = ":NvimTreeToggle<CR>"; options = { noremap = true; silent = true; }; }
      # Telescope
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "<leader>fh"; action = ":Telescope help_tags<CR>"; options = { noremap = true; silent = true; }; }
      # Select all
      { mode = "n"; key = "<C-a>"; action = "gg<S-v>G"; options = { noremap = true; silent = true; }; }
      # Tabs
      { mode = "n"; key = "te"; action = ":tabedit"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "<tab>"; action = ":tabnext<Return>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "<S-tab>"; action = ":tabprev<Return>"; options = { noremap = true; silent = true; }; }
      # Split window
      { mode = "n"; key = "ss"; action = ":split<Return>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "sv"; action = ":vsplit<Return>"; options = { noremap = true; silent = true; }; }
      # Move windows
      { mode = "n"; key = "sh"; action = "<C-w>h"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "sk"; action = "<C-w>k"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "sj"; action = "<C-w>j"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "sl"; action = "<C-w>l"; options = { noremap = true; silent = true; }; }
      # Buffers (barbar)
      { mode = "n"; key = "<tab>"; action = "<Cmd>BufferNext<CR>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "qq"; action = "<Cmd>BufferClose<CR>"; options = { noremap = true; silent = true; }; }
      { mode = "n"; key = "qa"; action = ":BufferCloseAllButCurrent<Return>"; options = { noremap = true; silent = true; }; }
    ];

    # ── Colorscheme ───────────────────────────────────────────────────────
    colorschemes.nord = {
      enable = true;
      settings.style = "moon";
      transparent = true;
      styles = {
        functions = {};
      };
    };

    # ── Plugins ───────────────────────────────────────────────────────────
    plugins = {

      # LSP
      lsp = {
        enable = true;
        capabilities = ''
          capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            require('cmp_nvim_lsp').default_capabilities()
          )
        '';
        keymaps = {
          diagnostic = {
            "<space>f" = "setloclist";
          };
          lspBuf = {
            "gD"        = "declaration";
            "gd"        = "definition";
            "K"         = "hover";
            "gi"        = "implementation";
            "gr"        = "references";
            "<space>D"  = "type_definition";
            "<space>rn" = "rename";
            "<space>ca" = "code_action";
            "<space>wa" = "add_workspace_folder";
            "<space>wr" = "remove_workspace_folder";
          };
        };
        servers = {
          ts_ls.enable = true;
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                diagnostics = {
                  globals = [ "vim" ];
                };
                workspace = {
                  library = [
                    "\${pkgs.neovim}/share/nvim/runtime/lua"
                  ];
                };
              };
            };
          };
        };
      };

      # Mason
      mason = {
        enable = true;
      };
      
      # Completion
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-o>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>"  = "cmp.mapping.confirm({ select = true })";
          };
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            { name = "nvim_lsp"; max_item_count = 5; }
            { name = "luasnip";  max_item_count = 3; }
            { name = "path";     max_item_count = 3; }
            { name = "buffer"; }
          ];
        };
      };

      # Snippets
      luasnip.enable = true;
      friendly-snippets.enable = true;

      # Treesitter 
      treesitter = {
        enable = true;
        nixvimInjections = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          c lua vim python css html javascript haskell
        ];
        settings = {
          sync_install = false;
          auto_install = false;
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
        };
      };
      treesitter-context.enable = true;
      
      # File tree
      nvim-tree = {
        enable = true;
        settings = {
          sort = {
            sorter = "case_sensitive";
          };
          view = {
            width = 30;
          };
          renderer = {
            group_empty = true;
          };
          filters = {
            dotfiles = false;
          };
        };
      };
      
      # Telescope
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # Statusline
      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
            theme = "nord";
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            disabled_filetypes = {
              statusline = [];
              winbar = [];
            };
            ignore_focus = [];
            always_divide_middle = true;
            globalstatus = false;
            refresh = {
              statusline = 1000;
              tabline = 1000;
              winbar = 1000;
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ "filename" ];
            lualine_x = [ "encoding" "fileformat" "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
          inactive_sections = {
            lualine_a = [];
            lualine_b = [];
            lualine_c = [ "filename" ];
            lualine_x = [ "location" ];
            lualine_y = [];
            lualine_z = [];
          };
          tabline = {};
          winbar = {};
          inactive_winbar = {};
          extensions = [];
        };
      };

      # Bufferline (barbar)
      barbar.enable = true;

      # Git
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add          = { text = " "; };
            change       = { text = " "; };
            delete       = { text = "󰆴"; };
            topdelete    = { text = "‾"; };
            changedelete = { text = "~"; };
            untracked    = { text = "┆"; };
          };
          signcolumn = true;
          numhl      = false;
          linehl     = false;
          word_diff  = false;
          watch_gitdir = {
            follow_files = true;
          };
          auto_attach = true;
          attach_to_untracked = false;
          current_line_blame = false;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 1000;
            ignore_whitespace = false;
            virt_text_priority = 100;
          };
          current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>";
          sign_priority = 6;
          update_debounce = 100;
          status_formatter = null;
          max_file_length = 40000;
          preview_config = {
            border = "single";
            style = "minimal";
            relative = "cursor";
            row = 0;
            col = 1;
          };
        };
      };

      lazygit.enable = true;

      # DAP (debugging)
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;

      # Trouble
      trouble = {
        enable = true;
        settings = {
          signs = {
            error = "";
            warning = "";
            information = "";
            other = "";
          };
        };
      };
      web-devicons.enable = true;

      # Surround
      nvim-surround.enable = true;

      # Autopairs
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = [ "string" ];
            javascript = [ "template_string" ];
            java = false;
          };
        };
      };

      # Autotag
      ts-autotag.enable = true;

      # Comment
      comment.enable = true;

      # Dashboard
      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
            header = [
              ""
              ""
              "  ██████╗ ██╗    ██╗██╗     ███████╗██╗  ██╗   ██╗ "
              " ██╔═══██╗██║    ██║██║     ██╔════╝██║  ╚██╗ ██╔╝ "
              " ██║   ██║██║ █╗ ██║██║     ███████╗██║   ╚████╔╝  "
              " ██║   ██║██║███╗██║██║     ╚════██║██║    ╚██╔╝   "
              " ╚██████╔╝╚███╔███╔╝███████╗███████║███████╗██║    "
              "  ╚═════╝  ╚══╝╚══╝ ╚══════╝╚══════╝╚══════╝╚═╝    "
              ""
              ""
            ];
            shortcut = [
              {
                desc = "  Files";
                group = "Label";
                action = "Telescope find_files";
                key = "f";
              }
              {
                desc = "󰗼  Exit";
                group = "";
                action = "exit";
                key = "q";
              }
            ];
          };
        };
      };

      # Colorizer
      nvim-colorizer = {
        enable = true;
        settings = {
          filetypes = [
            "*"
            "!vim"
            { css = { rgb_fn = true; }; }
            { html = { names = false; }; }
          ];
          user_default_options = {
            mode = "background";
          };
        };
      };

      # Undotree
      undotree.enable = true;

      # Harpoon
      harpoon.enable = true;

      # Spectre
      nvim-spectre.enable = true;

      # Wilder
      wilder.enable = true;

      #Which-key
      which-key.enable = true;

      #Indent-blankline
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            enabled = true;
            show_start = true;
            show_end = false;
          };
          exclude = {
            filetypes = [
              "help"
              "dashboard"
              "neo-tree"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
            ];
            buftypes = [
              "terminal"
              "nofile"
            ];
          };
        };
      };
    };

    # ── Trouble keymaps (need Lua callbacks) ─────────────────────────────
    extraConfigLua = ''
      -- Disable treesitter highlighting for large files
      require("nvim-treesitter.configs").setup({
        highlight = {
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local filename = vim.api.nvim_buf_get_name(buf)
            if not filename or filename == "" then
              return false
            end
            local ok, stats = pcall(vim.loop.fs_stat, filename)
            if ok and stats and stats.size > max_filesize then
              return true
            end
            return false
          end,
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]

      require("luasnip.loaders.from_vscode").lazy_load()

      -- Autopairs + cmp integration
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- Trouble keymaps
      local trouble = require("trouble")
      vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
      vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
      vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
      vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
      vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
      vim.keymap.set("n", "gR",         function() trouble.toggle("lsp_references") end)
    '';
  };
}
