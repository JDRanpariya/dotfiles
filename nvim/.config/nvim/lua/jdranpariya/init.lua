-- Order matters:
-- 1. leader must be set before any keymaps (including plugin specs)
-- 2. options can be set any time but early is cleaner
-- 3. lazy bootstraps and loads plugins last
require("jdranpariya.remap")
require("jdranpariya.set")
require("jdranpariya.lazy")
