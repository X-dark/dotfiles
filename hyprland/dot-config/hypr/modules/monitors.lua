-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    -- mode = "3440x1440@164.90",
    -- mode = "3440x1440@59.97",
    position = "auto",
    scale    = 1,
    vrr      = 1,
    bitdepth = 10,
    -- bitdepth = 8,
    cm       = "auto",
    -- cm       = "hdr",
    sdr_min_luminance = 0.005,
    sdr_max_luminance = 200,
})

hl.config({
  render = {
    cm_auto_hdr = 1,
    direct_scanout = 1,
  }
})
