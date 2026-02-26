-- ==================================================================================================
-- Title: nvim-web-devicons configuration
-- About: This file configures the nvim-web-devicons plugin to add custom icons for file types.
-- ==================================================================================================

return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").set_icon({
      gql = {
        icon = "",
        color = "#e535ab",
        cterm_color = "199",
        name = "GraphQL",
      },
    })
  end,
}
