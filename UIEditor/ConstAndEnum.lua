--Output(pcall(dofile, "Interface\\UIEditor\\ConstAndEnum.lua"))
--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\ConstAndEnum.lua" ��ʼ���� ...]] .. "\n"))

UIEditor = UIEditor or {}

---------------------------------------------------------------------------------------------------------------
-- ͨ���������x
---------------------------------------------------------------------------------------------------------------
UIEditor.szINIPath = "Interface\\UIEditor\\UIEditor.ini"			-- INI λ��
UIEditor.nTreeUndoLimited = 9999									-- �ɳ��N�Δ�

---------------------------------------------------------------------------------------------------------------
-- ���N������
---------------------------------------------------------------------------------------------------------------
UIEditor.tEventIndex = {											-- �¼����x�� bit ӳ���
	KeyDown = 13,
	KeyUp = 14,
	
	MouseLDown = 1,
	MouseLUp = 3,
	MouseLClick = 5,
	MouseLDBClick = 7,
	MouseLDrag = 20,
	
	MouseRDown = 2,
	MouseRUp = 4,
	MouseRClick = 6,
	MouseRDBClick = 8,
	MouseRDrag = 19,
	
	MouseMDown = 15,
	MouseMUp = 16,
	MouseMClick = 17,
	MouseMDBClick = 18,
	MouseMDrag = 21,
	
	MouseEnterLeave = 9,
	MouseArea = 10,
	MouseMove = 11,
	MouseHover = 22,
	MouseScroll = 12,
}

UIEditor.tWindowLayers = {											-- ���w Layer ��
	"Lowest",
	"Lowest1",
	"Lowest2",
	"Normal",
	"Normal1",
	"Normal2",
	"Topmost",
	"Topmost1",
	"Topmost2",
	"Texture",
}

UIEditor.tTreeNodeTypes = {											-- ���w Type ��
	"Frame",			-- ������
	
	"WndWindow",		-- �鴰��
	"WndScrollBar",		-- ������
	"WndButton",		-- ��ť
	"WndCheckBox",		-- ��ѡ��
	"WndEdit",			-- �����
	"WndPage",			-- ��ǩҳ��
	"WndPageSet",		-- ��ǩҳ�漯
	"WndMiniMap",		-- С��ͼ
	"WndScene",			-- 3D����
	"WndWebPage",		-- ��Ƕ��ҳ

	"Null",				-- �����
	"Text",				-- �ı����
	"Image",			-- ͼƬ���
	"Shadow",			-- ��Ӱ���
	"Animate",			-- �������
	"Box",				-- �������
	"Scene",			-- �������
	"TreeLeaf",			-- ���ڵ����
	"Handle"			-- �������
}

UIEditor.tImageTypes = {											-- �DƬ Type ��
	"һ��D��", "�ٷֱȣ�����", "�ٷֱȣ�����", "�ٷֱȣ�����", "�ٷֱȣ�����", "�ٷֱȣ��DȦ",
	"�����D�D��", "���·��D�D��", "���ҷ��D�D��", "���Ƿ��D�D��", "�Ōm�D��", "���������m", "���������m", 

	["һ��D��"] = 0,
	["�ٷֱȣ�����"] = 1,
	["�ٷֱȣ�����"] = 2,
	["�ٷֱȣ�����"] = 3,
	["�ٷֱȣ�����"] = 4,
	["�ٷֱȣ��DȦ"] = 5,
	["�����D�D��"] = 6,
	["���·��D�D��"] = 7,
	["���ҷ��D�D��"] = 8,
	["���Ƿ��D�D��"] = 9,
	["�Ōm�D��"] = 10,
	["���������m"] = 11,
	["���������m"] = 12,
}

UIEditor.tTextHAlignTypes = {										-- �ı�ˮƽ���R Type ��
	"ˮƽ���R", "ˮƽ����", "ˮƽ�Ҍ��R", 

	["ˮƽ���R"] = 0,
	["ˮƽ����"] = 1,
	["ˮƽ�Ҍ��R"] = 2,
}

UIEditor.tTextVAlignTypes = {										-- �ı���ֱ���R Type ��
	"��ֱ�ό��R", "��ֱ����", "��ֱ���R", 

	["��ֱ�ό��R"] = 0,
	["��ֱ����"] = 1,
	["��ֱ���R"] = 2,
}

UIEditor.tImageTXTTitle = {											-- ͼƬ�ļ�֡��Ϣ��ı�ͷ����
	{f = "i", t = "Farme"},				-- ͼƬ֡ ID
	{f = "i", t = "Left"},				-- ֡λ��: �����������(Xλ��)
	{f = "i", t = "Top"},				-- ֡λ��: ���붥������(Yλ��)
	{f = "i", t = "Width"},				-- ֡���
	{f = "i", t = "High"},				-- ֡�߶�
	{f = "s", t = "File"},				-- ֡��Դ�ļ�(������)
}

UIEditor.szColorFileName = "Interface/UIEditor/Misc/Color.txt"
UIEditor.tColorTXTTitle = {											-- �ɫ�ļ�֡��Ϣ��ı�ͷ����
	{f = "i", t = "index"},				-- �ɫ����
	{f = "s", t = "name"},				-- �ɫ����
	{f = "i", t = "r"},					-- �ɫ R ֵ
	{f = "i", t = "g"},					-- �ɫ G ֵ
	{f = "i", t = "b"},					-- �ɫ B ֵ
}

UIEditor.tImageFileBaseNameList = {									-- ͼƬ�ļ��б�, Ŀǰ��ʱֻ֧���ֶ�ά���˱�
	Button = {
		"UI/Image/Button/CommonButton_1",
		"UI/Image/Button/FrendnpartyButton",
		"UI/Image/Button/ShopButton",
		"UI/Image/Button/SystemButton",
		"UI/Image/Button/SystemButton_1",
	},
	
	ChannelsPanel = {
		"UI/Image/ChannelsPanel/b",
		"UI/Image/ChannelsPanel/Button",
		"UI/Image/ChannelsPanel/Channels1",
		"UI/Image/ChannelsPanel/Channels2",
		"UI/Image/ChannelsPanel/Channels3",
		"UI/Image/ChannelsPanel/Channels4",
		"UI/Image/ChannelsPanel/Channels5",
		"UI/Image/ChannelsPanel/Channels6",
		"UI/Image/ChannelsPanel/Channels7",
		"UI/Image/ChannelsPanel/Channels8",
		"UI/Image/ChannelsPanel/Channels9",
		"UI/Image/ChannelsPanel/NewChannels",
		"UI/Image/ChannelsPanel/NewChannels2",
	},
	
	Common = {
		"UI/Image/Common/Animate",
		"UI/Image/Common/Box",
		"UI/Image/Common/CommonPanel",
		"UI/Image/Common/CoverShadow",
		"UI/Image/Common/DialogueLabel",
		"UI/Image/Common/KeynotesPanel",
		"UI/Image/Common/Logo",
		"UI/Image/Common/Mainpanel_1",
		"UI/Image/Common/MatrixAni",
		"UI/Image/Common/MatrixAni_1",
		"UI/Image/Common/MatrixAni_2",
		"UI/Image/Common/Money",
		"UI/Image/Common/ProgressBar",
		"UI/Image/Common/TempBox",
		"UI/Image/Common/TextShadow",
	},
	
	Minimap = {
		"UI/Image/Minimap/Mapmark",
		"UI/Image/Minimap/Minimap",
		"UI/Image/Minimap/Minimap2",
	},
	
	QuestPanel = {
		"UI/Image/QuestPanel/QuestPanel",
		"UI/Image/QuestPanel/QuestPanelButton",
		"UI/Image/QuestPanel/QuestPanelPart",
	},
	
	TargetPanel = {
		"UI/Image/TargetPanel/CangjianAnimation1",
		"UI/Image/TargetPanel/CangjianAnimation2",
		"UI/Image/TargetPanel/Player",
		"UI/Image/TargetPanel/Target",
	},
	
	UICommon = {
		"UI/Image/UICommon/Commonpanel",
		"UI/Image/UICommon/Commonpanel2",
		"UI/Image/UICommon/Commonpanel4",
		"UI/Image/UICommon/Commonpanel5",
		"UI/Image/UICommon/CompassPanel",
		"UI/Image/UICommon/FEPanel",
		"UI/Image/UICommon/FEPanel3",
		"UI/Image/UICommon/HelpPanel",
		"UI/Image/UICommon/LoginCommon",
		"UI/Image/UICommon/LoginSchool",
		"UI/Image/UICommon/MailCommon",
		"UI/Image/UICommon/PasswordPanel",
		"UI/Image/UICommon/ScienceTreeNode",
		"UI/Image/UICommon/Talk_Face",
	},
	
	Misc = {
		"UI/Image/ChatPanel/EditBox",
		"UI/Image/Cursor/Arrowimg",
		"UI/Image/Helper/Help",
		"UI/Image/Helper/Help��bg",
		"UI/Image/Item_Pic/266",
		"UI/Image/Login/CharButton",
		"UI/Image/LootPanel/LootPanel",
		"UI/Image/MiddleMap/MapWindow",
		"UI/Image/QuicklySetPanel/QuicklySetPanel1",
	},
}

local fnimagepath,fnrimagepath = function(s)return s and s..".UITex" or "" end,function(s)return s and s:sub(1,-7) end
local fnimagetype,fnrimagetype = function(s)return s and UIEditor.tImageTypes[s] or 0 end,function(n)return UIEditor.tImageTypes[n+1]end
local fnhaligntype,fnrhaligntype = function(s)return s and UIEditor.tTextHAlignTypes[s] or 0 end,function(n)return n and UIEditor.tTextHAlignTypes[n+1] end
local fnvaligntype,fnrvaligntype = function(s)return s and UIEditor.tTextVAlignTypes[s] or 0 end,function(n)return n and UIEditor.tTextVAlignTypes[n+1] end
local fnbooltobin,fnbintobool = function(b)return b and 1 or 0 end,function(n)return n and n~=0 and true or false end
local fnnbooltobin,fnbintonbool = function(b)return b and 0 or 1 end,function(n)return not(n and n~=0 and true or false) end

UIEditor.tNodeInfoDefault = {
	{"Left",	"Common",	"nLeft",	0},
	{"Top",		"Common",	"nTop",		0},
	{"Width",	"Common",	"nWidth",	0},
	{"Height",	"Common",	"nHeight",	0},

	{"DragAreaLeft",		"Wnd",	"nDragAreaLeft",		0},	
	{"DragAreaTop",			"Wnd",	"nDragAreaTop",			0},
	{"DragAreaWidth",		"Wnd",	"nDragAreaWidth",		0},
	{"DragAreaHeight",		"Wnd",	"nDragAreaHeight",		0},
	{"AnimateStartPosX",	"Wnd",	"nAnimateStartPosX",	0},
	{"AnimateStartPosY",	"Wnd",	"nAnimateStartPosY",	0},
	{"AnimateEndPosX",		"Wnd",	"nAnimateEndPosX",		0},
	{"AnimateEndPosY",		"Wnd",	"nAnimateEndPosY",		0},
	{"AnimateTimeSpace",	"Wnd",	"nAnimateTimeSpace",	0},
	{"AnimateMoveSpeed",	"Wnd",	"nAnimateMoveSpeed",	0},
	
	{"._Comment",	"CommonNonZero",	"szComment",	""},

	{"$Tip",		"Tip",		"szTip",		""},
	{"ShowTipType",	"Tip",		"nShowTipType",	0},
	{"OrgTip",		"Tip",		"nOrgTip",		1},

	{"EventID",		"CommonNonZero",	"nEventID",		0},
	{"Alpha",		"CommonNonZero",	"nAlpha",		0},
	{"Image",		"CommonNonZero",	"szImagePath",	nil,	fnimagepath,	fnrimagepath},
	{"Frame",		"CommonOption",		"nFrame",		0},
	{"Group",		"CommonOption",		"nAniGroup",	-1},
	{"ImageType",	"CommonNonZero",	"szImageType",	0,	fnimagetype,	fnrimagetype},
	{"FontSpacing",	"CommonOption",		"nFontSpacing",	nil},
	{"RowSpacing",	"CommonOption",		"nRowSpacing",	nil},
	{"FontScheme",	"CommonOption",		"nFontScheme",	nil},

	{"HAlign",	"CommonNonZero",	"szHAlignType",	0,	fnhaligntype,	fnrhaligntype},
	{"VAlign",	"CommonNonZero",	"szVAlignType",	0,	fnvaligntype,	fnrvaligntype},

	{"$Text",			"Text",	"szText",			""},
	{"OrgText",			"Text",	"nOrgText",			1},
	{"ShowAll",			"Text",	"bShowAll",			0,	fnbooltobin,	fnbintobool},
	{"AutoEtc",			"Text",	"bAutoEtc",			0,	fnbooltobin,	fnbintobool},
	{"CenterEachRow",	"Text",	"bCenterEachRow",	0,	fnbooltobin,	fnbintobool},
	{"MultiLine",		"Text",	"bMultiLine",		0,	fnbooltobin,	fnbintobool},
	{"MlAutoAdj",		"Text",	"bMlAutoAdj",		0,	fnbooltobin,	fnbintobool},
	{"RichText",		"Text",	"bNoRichText",		0,	fnnbooltobin,	fnbintonbool},

	{"PosType",				"Handle",	"nPosType",				0},
	{"HandleType",			"Handle",	"nHandleType",			0},
	{"FirstItemPosType",	"Handle",	"nFirstItemPosType",	0},

	{"ShadowColor",		"CommonOption",	"szColorName",	nil},
}

--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\ConstAndEnum.lua" ������� ...]] .. "\n"))
