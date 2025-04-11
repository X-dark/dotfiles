return {
  {
    'dense-analysis/ale',
    enabled = false,
    config = function()
        -- Configuration goes here.
        local g = vim.g
  
        g.ale_sign_error = '✘'
        g.ale_sign_warning = '⚠'
        -- g.ale_ruby_rubocop_auto_correct_all = 1
  
        -- g.ale_linters = {
        --     ruby = {'rubocop', 'ruby'},
        --     lua = {'lua_language_server'}
        -- }
    end
  },
}
