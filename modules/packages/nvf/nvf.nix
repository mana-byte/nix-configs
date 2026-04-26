{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      #app
      apps.nvf = {
        program = self'.packages.nvf;
        meta = {
          description = "Nvim configured with the nvf configuration";
        };
      };

      # package
      packages.nvf =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              vim = {
                package = pkgs.neovim-unwrapped;

                keymaps = [
                  # Undo tree
                  {
                    key = "<leader>u";
                    mode = [ "n" ];
                    action = ":UndotreeToggle<CR>";
                    silent = true;
                    desc = "Toggle undotree";
                  }

                  # Splits
                  {
                    key = "<c-l>"; # split vertical
                    mode = [ "n" ];
                    action = ":vsplit<CR>";
                    silent = true;
                    desc = "Vertical split";
                  }
                  {
                    key = "<c-h>"; # split horizontal
                    mode = [ "n" ];
                    action = ":split<CR>";
                    silent = true;
                    desc = "Horizontal split";
                  }

                  # Formatting (Conform)
                  {
                    key = "<space>ff";
                    mode = [ "n" ];
                    action = ":lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
                    silent = true;
                    desc = "Format buffer";
                  }

                  # File explorer (oil, neotree)
                  {
                    key = "-";
                    mode = [ "n" ];
                    action = ":Oil<CR>";
                    silent = true;
                    desc = "Open Oil";
                  }
                  {
                    key = "<leader>-";
                    mode = [ "n" ];
                    action = ":Neotree toggle<CR>";
                    silent = true;
                    desc = "Open neotree";
                  }
                  {
                    key = "<leader>;";
                    mode = ["n"];
                    action = ":lua require('dropbar.api').pick()<CR>";
                    silent = true;
                    desc = "Pick from dropbar";
                  }

                  # Noice dismiss (noice)
                  {
                    key = "<leader>nd";
                    mode = [ "n" ];
                    action = ":NoiceDismiss<CR>";
                    silent = true;
                    desc = "Dismiss notifications";
                  }

                  # Telescope (core pickers beyond module-provided mappings)
                  {
                    key = "<leader>fo";
                    mode = [ "n" ];
                    action = ":Telescope oldfiles<CR>";
                    silent = true;
                    desc = "Recent files";
                  }
                  {
                    key = "<leader>fh";
                    mode = [ "n" ];
                    action = ":Telescope help_tags<CR>";
                    silent = true;
                    desc = "Help tags";
                  }
                  {
                    key = "<leader>fr";
                    mode = [ "n" ];
                    action = ":Telescope resume<CR>";
                    silent = true;
                    desc = "Resume last Telescope";
                  }
                  {
                    key = "<leader>fs";
                    mode = [ "n" ];
                    action = ":Telescope grep_string<CR>";
                    silent = true;
                    desc = "Grep string under cursor";
                  }

                  # LSP helpers
                  {
                    key = "<leader>rn";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.rename()<CR>";
                    silent = true;
                    desc = "LSP Rename";
                  }
                  {
                    key = "<leader>ca";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.code_action()<CR>";
                    silent = true;
                    desc = "Code Action";
                  }
                  {
                    key = "<leader>gd";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.definition()<CR>";
                    silent = true;
                    desc = "Go to Definition";
                  }
                  {
                    key = "<leader>gr";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.references()<CR>";
                    silent = true;
                    desc = "References";
                  }
                  {
                    key = "<leader>gi";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.implementation()<CR>";
                    silent = true;
                    desc = "Implementation";
                  }
                  {
                    key = "<leader>gs";
                    mode = [ "n" ];
                    action = ":lua vim.lsp.buf.signature_help()<CR>";
                    silent = true;
                    desc = "Signature Help";
                  }
                  {
                    key = "<C-t>";
                    mode = [ "n" ];
                    action = ":Trouble<CR>";
                    silent = true;
                    desc = "Open Trouble";
                  }

                  # Diagnostics navigation
                  {
                    key = "<leader>dn";
                    mode = [ "n" ];
                    action = ":lua vim.diagnostic.goto_next({ float = true })<CR>";
                    silent = true;
                    desc = "Next diagnostic";
                  }
                  {
                    key = "<leader>dp";
                    mode = [ "n" ];
                    action = ":lua vim.diagnostic.goto_prev({ float = true })<CR>";
                    silent = true;
                    desc = "Prev diagnostic";
                  }
                  {
                    key = "<leader>dl";
                    mode = [ "n" ];
                    action = ":lua vim.diagnostic.setloclist()<CR>";
                    silent = true;
                    desc = "Diagnostics to loclist";
                  }

                  # Windows management (windows.nvim)
                  {
                    key = "<leader>we";
                    mode = [ "n" ];
                    action = ":WindowsEqualize<CR>";
                    silent = true;
                    desc = "Equalize windows";
                  }
                  {
                    key = "<leader>wm";
                    mode = [ "n" ];
                    action = ":WindowsMaximize<CR>";
                    silent = true;
                    desc = "Maximises current window";
                  }
                  {
                    key = "<leader>mv";
                    mode = [ "n" ];
                    action = ":Markview<CR>";
                    silent = true;
                    desc = "Toggle Markdown view";
                  }
                  {
                    key = "<leader>gg";
                    mode = [ "n" ];
                    action = ":Git<CR>";
                    silent = true;
                    desc = "Open Git interface";
                  }

                  # pounce/leap (pounce.nvim)
                  {
                    key = "s";
                    mode = [ "n" ];
                    action = ":Pounce<CR>";
                    silent = true;
                    desc = "Jump to a location";
                  }

                  # Additional keymaps can be added here following the same structure
                  {
                    key = "<leader>ss";
                    mode = [ "v" ];
                    action = ":'<,'>sort<CR>";
                    silent = true;
                    desc = "Sort selection";
                  }
                ];

                git = {
                  enable = true;
                  vim-fugitive.enable = true;
                };
                lsp.enable = true;
                lazy.enable = true;

                globals = {
                  mapleader = ",";
                };

                options = {
                  tabstop = 2;
                  shiftwidth = 2;
                  softtabstop = 2;
                  expandtab = true;
                  cursorline = true;
                  number = true;
                  relativenumber = true;
                  signcolumn = "yes";
                  termguicolors = true;
                  updatetime = 400;
                  scrolloff = 1;
                  splitbelow = true;
                  splitright = true;
                  timeoutlen = 400;
                  ignorecase = true;
                  smartcase = true;
                };
                clipboard.enable = true;

                theme = {
                  enable = true;
                  name = "catppuccin";
                  style = "mocha";
                };

                statusline.lualine = {
                  enable = true;
                  theme = "catppuccin";
                };

                telescope = {
                  enable = true;
                  extensions = [
                    {
                      name = "fzf";
                      packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                      setup = {
                        fzf = {
                          fuzzy = true;
                          case_mode = "smart_case";
                        };
                      };
                    }
                  ];
                  mappings = {
                    findFiles = "<leader>ff";
                    buffers = "<leader>fb";
                    gitBranches = "<leader>gb";
                    gitCommits = "<leader>gc";
                    liveGrep = "<leader>fg";
                  };
                };

                filetree.neo-tree = {
                  enable = true;
                };

                utility = {
                  oil-nvim = {
                    enable = true;
                    setupOpts = {
                      view_options = {
                        show_hidden = true;
                      };
                    };
                  };
                  undotree.enable = true;
                  ccc = {
                    enable = true;
                    mappings.quit = "q";
                  };
                  surround.enable = true;
                };
                terminal.toggleterm = {
                  enable = true;
                  mappings.open = "<leader>tt";
                  setupOpts = {
                    winbar.enable = true;
                  };
                };

                binds.whichKey.enable = true;
                notes.todo-comments.enable = true;

                ui.noice = {
                  enable = true;
                  setupOpts.presets = {
                    bottom_search = false;
                    command_palette = true;
                  };
                };

                # for noice notifications
                notify.nvim-notify.enable = true;

                visuals = {
                  nvim-web-devicons.enable = true;
                };

                formatter = {
                  conform-nvim = {
                    enable = true;
                    setupOpts.formatters_by_ft = {
                      lua = [ "stylua" ];
                      python = [ "ruff" ];
                      nix = [ "nixfmt" ];
                      javascript = [ "prettier" ];
                      typescript = [ "prettier" ];
                      javascriptreact = [ "prettier" ];
                      typescriptreact = [ "prettier" ];
                    };
                  };
                };

                mini.starter.enable = true;

                # Autocompletion & snippets
                autocomplete = {
                  nvim-cmp = {
                    enable = true;
                    mappings = {
                      confirm = "<tab>";
                      next = "<c-n>";
                      previous = "<c-p>";
                    };
                  };
                };

                # # nvim cmp borders (can be removed for less visual clutter)
                # ui.borders.plugins.nvim-cmp.enable = true;

                lsp.trouble.enable = true;
                comments.comment-nvim.enable = true;
                autopairs.nvim-autopairs.enable = true;

                assistant = {
                  copilot = {
                    enable = true;
                    cmp.enable = true;
                    setupOpts.suggestion.enabled = false;
                  };

                  avante-nvim = {
                    enable = true;
                    setupOpts = {
                    };
                  };
                };

                treesitter = {
                  enable = true;
                  indent.enable = true;
                  fold = true;
                  context = {
                    enable = true;
                    setupOpts = {
                      max_lines = 4;
                    };
                  };
                };

                languages = {
                  nix = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  lua = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  python = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  yaml = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  ts = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  markdown = {
                    enable = true;
                    extensions.markview-nvim.enable = true;
                    format.enable = true;
                  };
                  bash.enable = true;
                };
              };

              vim.extraPlugins = {

                # simple jump plugin
                pounce-nvim =
                  let
                    pounce = pkgs.vimUtils.buildVimPlugin {
                      pname = "pounce";
                      version = "2026-04-25";
                      src = pkgs.fetchFromGitHub {
                        owner = "rlane";
                        repo = "pounce.nvim";
                        rev = "2e36399ac09b517770c459f1a123e6b4b4c1c171";
                        sha256 = "sha256-PTL0wwUE1sO6YlJNPnlNilKyR5kQDBYXiDM5gh6pkuM=";
                      };
                      meta.homepage = "https://github.com/rlane/pounce.nvim";
                      meta.hydraPlatforms = [ ];
                    };
                  in
                  {
                    package = pounce;
                  };

                # for windows animation and better split handling
                windows = {
                  package = pkgs.vimPlugins.windows-nvim;
                  setup = ''
                    vim.o.winwidth = 10
                    vim.o.winminwidth = 10
                    vim.o.equalalways = false
                    require('windows').setup()
                  '';
                };

                # for git commit history in statusline
                lensline-nvim = {
                  package = pkgs.vimPlugins.lensline-nvim;
                  setup = ''
                    require("lensline").setup()
                  '';
                };

                # for call visual inline diagnostics instead of virtual text
                tiny-inline-diagnostic = {
                  package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
                  setup = ''
                    require('tiny-inline-diagnostic').setup({
                      preset = "classic",
                    })
                    vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
                  '';
                };

                # to hide .env files and other secrets
                cloak-nvim = {
                  package = pkgs.vimPlugins.cloak-nvim;
                  setup = ''
                    require("cloak").setup({
                      enabled = true,
                      cloak_telescope = true,
                    })
                  '';
                };

                # view context more easly
                dropbar-nvim.package = pkgs.vimPlugins.dropbar-nvim;

                auto-session-nvim = {
                  package = pkgs.vimPlugins.auto-session;
                  setup = ''
                    require("auto-session").setup({})
                  '';
                };

                # smear-cursor-nvim = {
                #   # for git commit history in statusline
                #   package = pkgs.vimPlugins.smear-cursor-nvim;
                #   # setup = ''
                #   #   require('smear_cursor').enabled = true
                #   #   require('smear_cursor').setup({
                #   #        cursor_color = "#ff4000",
                #   #        particles_enabled = true,
                #   #        stiffness = 0.5,
                #   #        trailing_stiffness = 0.2,
                #   #        trailing_exponent = 5,
                #   #        damping = 0.6,
                #   #        gradient_exponent = 0,
                #   #        gamma = 1,
                #   #        never_draw_over_target = true, -- if you want to actually see under the cursor
                #   #        hide_target_hack = true,       -- same
                #   #        particle_spread = 1,
                #   #        particles_per_second = 500,
                #   #        particles_per_length = 50,
                #   #        particle_max_lifetime = 800,
                #   #        particle_max_initial_velocity = 20,
                #   #        particle_velocity_from_cursor = 0.5,
                #   #        particle_damping = 0.15,
                #   #        particle_gravity = -50,
                #   #        min_distance_emit_particles = 0,
                #   #   })
                #   # '';
                #   setup = ''
                #     require('smear_cursor').enable = true
                #     require('smear_cursor').setup({
                #         stiffness = 0.8,                      -- 0.6      [0, 1]
                #         trailing_stiffness = 0.6,             -- 0.45     [0, 1]
                #         stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
                #         trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
                #         damping = 0.95,                       -- 0.85     [0, 1]
                #         damping_insert_mode = 0.95,           -- 0.9      [0, 1]
                #         distance_stop_animating = 0.5,        -- 0.1      > 0
                #     })
                #   '';
                # };
              };
            }
          ];
        }).neovim;
    };
}
