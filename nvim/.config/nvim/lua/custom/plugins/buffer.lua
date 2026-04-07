return {
    {
        "serhez/bento.nvim",
        opts = {},
        event = 'VeryLazy',
        keys = {
            {
                '<leader>bc',
                function()
                    require("bento").close_all_buffers({ visible = false, locked = false, current = false })
                end,
                desc = 'Close non visible and protected buffers',
            },
        }
    }
}
