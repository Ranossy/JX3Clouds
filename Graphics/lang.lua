local _t
_t = {
  NAME = "lang",
  -- strings = {},
  L = function(name)
    return _t.strings[name]
  end,
}

_t.module = Clouds.Graphics
Clouds.Graphics.lang = _t
Clouds.Base.base.gen_all_msg(_t)

_t.strings = {
  All = "����",
  Combat = "ս��",
  Raid = "�Ŷ�",
  Other = "����",
  EasyManagerTitle = "���Ʋ����",
  EasyManagerBtnTipTitle = "���Ʋ������",
  EasyManagerBtnTipDesc = "����������Դ򿪲����������",
}
