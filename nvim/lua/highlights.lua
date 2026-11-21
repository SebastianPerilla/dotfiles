return {
  -- line numbers (you already did this)
  LineNr = { fg = "#aaaaaa" },
  CursorLineNr = { fg = "#ffffff", bold = true },

  -- DAP breakpoint signs
  DapBreakpoint = {
    fg = "#ff5555",    -- bright red
    bold = true,
  },
  DapBreakpointCondition = {
    fg = "#ffb86c",    -- orange/yellow
    bold = true,
  },
  DapBreakpointRejected = {
    fg = "#ff5555",
    bg = "#444444",    -- optional: background to stand out
  },
  DapLogPoint = {
    fg = "#50fa7b",    -- green
    bold = true,
  },
  SignColum = {
      big = "NONE",
  }
}

