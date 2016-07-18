local _t
_t = {
  NAME = "lang",
  -- strings = {},
  L = function(name)
    return _t.strings[name]
  end,
}

_t.module = Clouds_Graphics
Clouds_Graphics.lang = _t
_t.Output = Clouds_Graphics.base.gen_msg(_t.NAME)
_t.Output_verbose = function(...) _t.Output(_t.module.LEVEL.VERBOSE, ...) end
_t.Output_ex = function(...) _t.Output(_t.module.LEVEL.VERBOSEEX, ...) end

_t.strings = {
  All = "����",
  Combat = "ս��",
  Raid = "�Ŷ�",
  Other = "����",
  EasyManagerTitle = "���Ʋ����",
  EasyManagerBtnTipTitle = "���Ʋ������",
  EasyManagerBtnTipDesc = "����������Դ򿪲����������",
}
