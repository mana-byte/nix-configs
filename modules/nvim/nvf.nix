{inputs, ...}: {
  systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
  perSystem = {pkgs, ...}: {
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
                  mode = ["n"];
                  action = ":UndotreeToggle<CR>";
                  silent = true;
                  desc = "Toggle undotree";
                }

                # Splits
                {
                  key = "<c-l>"; # split vertical
                  mode = ["n"];
                  action = ":vsplit<CR>";
                  silent = true;
                  desc = "Vertical split";
                }
                {
                  key = "<c-h>"; # split horizontal
                  mode = ["n"];
                  action = ":split<CR>";
                  silent = true;
                  desc = "Horizontal split";
                }

                # Formatting (Conform)
                {
                  key = "<space>ff";
                  mode = ["n"];
                  action = ":lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
                  silent = true;
                  desc = "Format buffer";
                }

                # File explorer (oil)
                {
                  key = "-";
                  mode = ["n"];
                  action = ":Oil<CR>";
                  silent = true;
                  desc = "Open Oil";
                }

                # Noice dismiss
                {
                  key = "<leader>nd";
                  mode = ["n"];
                  action = ":NoiceDismiss<CR>";
                  silent = true;
                  desc = "Dismiss notifications";
                }

                # Telescope (core pickers beyond module-provided mappings)
                {
                  key = "<leader>fo";
                  mode = ["n"];
                  action = ":Telescope oldfiles<CR>";
                  silent = true;
                  desc = "Recent files";
                }
                {
                  key = "<leader>fh";
                  mode = ["n"];
                  action = ":Telescope help_tags<CR>";
                  silent = true;
                  desc = "Help tags";
                }
                {
                  key = "<leader>fr";
                  mode = ["n"];
                  action = ":Telescope resume<CR>";
                  silent = true;
                  desc = "Resume last Telescope";
                }
                {
                  key = "<leader>fs";
                  mode = ["n"];
                  action = ":Telescope grep_string<CR>";
                  silent = true;
                  desc = "Grep string under cursor";
                }

                # LSP helpers
                {
                  key = "<leader>rn";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.rename()<CR>";
                  silent = true;
                  desc = "LSP Rename";
                }
                {
                  key = "<leader>ca";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.code_action()<CR>";
                  silent = true;
                  desc = "Code Action";
                }
                {
                  key = "<leader>gd";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.definition()<CR>";
                  silent = true;
                  desc = "Go to Definition";
                }
                {
                  key = "<leader>gr";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.references()<CR>";
                  silent = true;
                  desc = "References";
                }
                {
                  key = "<leader>gi";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.implementation()<CR>";
                  silent = true;
                  desc = "Implementation";
                }
                {
                  key = "<leader>gs";
                  mode = ["n"];
                  action = ":lua vim.lsp.buf.signature_help()<CR>";
                  silent = true;
                  desc = "Signature Help";
                }
                {
                  key = "<C-t>";
                  mode = ["n"];
                  action = ":Trouble<CR>";
                  silent = true;
                  desc = "Open Trouble";
                }

                # Diagnostics navigation
                {
                  key = "<leader>dn";
                  mode = ["n"];
                  action = ":lua vim.diagnostic.goto_next({ float = true })<CR>";
                  silent = true;
                  desc = "Next diagnostic";
                }
                {
                  key = "<leader>dp";
                  mode = ["n"];
                  action = ":lua vim.diagnostic.goto_prev({ float = true })<CR>";
                  silent = true;
                  desc = "Prev diagnostic";
                }
                {
                  key = "<leader>dl";
                  mode = ["n"];
                  action = ":lua vim.diagnostic.setloclist()<CR>";
                  silent = true;
                  desc = "Diagnostics to loclist";
                }
                {
                  key = "<leader>we";
                  mode = ["n"];
                  action = ":WindowsEqualize<CR>";
                  silent = true;
                  desc = "Equalize windows";
                }
                {
                  key = "<leader>wm";
                  mode = ["n"];
                  action = ":WindowsMaximize<CR>";
                  silent = true;
                  desc = "Maximises current window";
                }
                {
                  key = "<leader>mv";
                  mode = ["n"];
                  action = ":Markview<CR>";
                  silent = true;
                  desc = "Toggle Markdown view";
                }
                {
                  key = "<leader>gg";
                  mode = ["n"];
                  action = ":Git<CR>";
                  silent = true;
                  desc = "Open Git interface";
                }
              ];

              git.enable = true;
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
                relativenumber = true;
                number = true;
                signcolumn = "yes";
                termguicolors = true; # True color
                updatetime = 300; # Faster CursorHold
                scrolloff = 1; # Context lines around cursor
                splitbelow = true; # New horizontal splits below
                splitright = true; # New vertical splits to the right
                timeoutlen = 400; # Faster mapped sequence timeout
                ignorecase = true; # Case-insensitive search
                smartcase = true; # Override ignorecase if uppercase in search
              };
              clipboard.enable = true; # System clipboard integration

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
                    packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
                    setup = {
                      fzf = {
                        fuzzy = true;
                        case_mode = "smart_case"; # Added smarter case handling
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
              filetree.nvimTree.enable = true;

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
                motion.leap = {
                  enable = true;
                  mappings = {
                    leapForwardTo = "s";
                    leapBackwardTo = "S";
                    leapFromWindow = "<leader>s";
                  };
                };
                surround.enable = true;
                ccc = {
                  enable = true;
                  mappings.quit = "q";
                };
              };
              terminal.toggleterm.enable = true;

              binds.whichKey.enable = true;
              notes.todo-comments.enable = true;

              ui.noice = {
                enable = true;
                setupOpts.presets = {
                  bottom_search = false;
                  command_palette = true;
                };
              };
              notify.nvim-notify.enable = true; # for noice notifications

              visuals = {
                nvim-web-devicons.enable = true;
              };

              formatter = {
                conform-nvim = {
                  enable = true;
                  setupOpts.formatters_by_ft = {
                    lua = ["stylua"];
                    python = ["black"];
                    nix = ["alejandra"];
                    javascript = ["biome"];
                    typescript = ["biome"];
                    javascriptreact = ["biome"]; # eslint removed (handled by LSP diagnostics if desired)
                    typescriptreact = ["biome"]; # eslint removed
                  };
                };
              };

              dashboard.alpha = {
                enable = true;
                theme = "theta";
              };

              # Autocompletion & snippets
              autocomplete = {
                # blink-cmp = {
                #   enable = true;
                #   friendly-snippets.enable = true;
                #   mappings = {
                #     next = "<c-n>";
                #     previous = "<c-p>";
                #   };
                # };
                nvim-cmp = {
                  enable = true;
                  mappings = {
                    next = "<c-n>";
                    previous = "<c-p>";
                  };
                };
              };
              ui.borders.plugins.nvim-cmp.enable = true; # nvim cmp borders

              lsp.trouble.enable = true;
              comments.comment-nvim.enable = true;
              autopairs.nvim-autopairs.enable = true;

              assistant = {
                copilot = {
                  enable = true;
                  cmp.enable = true;
                  setupOpts.suggestion.enabled = false;
                };
                # avante-nvim.enable = true;
              };

              languages = {
                enableTreesitter = true;
                nix.enable = true;
                lua.enable = true;
                python.enable = true;
                ts.enable = true; # Provides TypeScript/TSX; adjust if module separates ts/tsx
                bash.enable = true;
                yaml = {
                  enable = true;
                  lsp.enable = true;
                };
                markdown = {
                  enable = true;
                  extensions.markview-nvim.enable = true;
                  format.enable = true;
                };
              };
            };

            vim.extraPlugins = {
              windows = {
                # for windows animation and better split handling
                package = pkgs.vimPlugins.windows-nvim;
                setup = ''
                  vim.o.winwidth = 10
                  vim.o.winminwidth = 10
                  vim.o.equalalways = false
                  require('windows').setup()
                '';
              };

              lensline-nvim = {
                # for git commit history in statusline
                package = pkgs.vimPlugins.lensline-nvim;
                setup = ''
                  require("lensline").setup()
                '';
              };

              smear-cursor-nvim = {
                # for git commit history in statusline
                package = pkgs.vimPlugins.smear-cursor-nvim;
                # setup = ''
                #   require('smear_cursor').enabled = true
                #   require('smear_cursor').setup({
                #        cursor_color = "#ff4000",
                #        particles_enabled = true,
                #        stiffness = 0.5,
                #        trailing_stiffness = 0.2,
                #        trailing_exponent = 5,
                #        damping = 0.6,
                #        gradient_exponent = 0,
                #        gamma = 1,
                #        never_draw_over_target = true, -- if you want to actually see under the cursor
                #        hide_target_hack = true,       -- same
                #        particle_spread = 1,
                #        particles_per_second = 500,
                #        particles_per_length = 50,
                #        particle_max_lifetime = 800,
                #        particle_max_initial_velocity = 20,
                #        particle_velocity_from_cursor = 0.5,
                #        particle_damping = 0.15,
                #        particle_gravity = -50,
                #        min_distance_emit_particles = 0,
                #   })
                # '';
                setup = ''
                  require('smear_cursor').enable = true
                  require('smear_cursor').setup({
                      stiffness = 0.8,                      -- 0.6      [0, 1]
                      trailing_stiffness = 0.6,             -- 0.45     [0, 1]
                      stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
                      trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
                      damping = 0.95,                       -- 0.85     [0, 1]
                      damping_insert_mode = 0.95,           -- 0.9      [0, 1]
                      distance_stop_animating = 0.5,        -- 0.1      > 0
                  })
                '';
              };

              tiny-inline-diagnostic = {
                package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
                setup = ''
                  require('tiny-inline-diagnostic').setup({
                    preset = "classic",
                  })
                  vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
                '';
              };
            };
          }
        ];
      }).neovim;
  };
}
