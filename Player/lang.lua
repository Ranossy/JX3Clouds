-- config: gbk --

local _t
_t = {
  NAME = "lang",
  -- strings = {},
  L = function(name)
    return _t.strings[name] or name
  end,
}

_t.module = Clouds_Player
Clouds_Player.lang = _t
_t.module.base.gen_all_msg(_t)

_t.strings = {
  BattleLog = "ս����¼",
  BattleLogTitle = "ս����¼�鿴",
  BattleLogOpen = "<��>"
}
