local flags
flags = {
  NAME = "Clouds_Flags",
  DEBUG = false,-- Clouds.DEBUG,
  LEVEL_CURRENT = Clouds.LEVEL_CURRENT,
  LEVEL_LOG = Clouds.LEVEL_LOG,
}
_G.Clouds.Flags = flags

local _t
_t = {
  NAME = "base",
  gen_msg = Clouds.Base.module_gen_msg(flags),
}

_t.module = Clouds.Flags
Clouds.Flags.base = _t
