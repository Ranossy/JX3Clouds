--Output(pcall(dofile, "Interface\\UIEditor\\Base.lua"))
--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\Base.lua" ��ʼ���� ...]] .. "\n"))

UIEditor = UIEditor or {}

---------------------------------------------------------------------------------------------------------------
-- �¼���ռ̎��
---------------------------------------------------------------------------------------------------------------
UIEditor.bCheckBoxSystemAction = false								-- ̎�ϵ�y��ӄt���|�l�¼�

---------------------------------------------------------------------------------------------------------------
-- ���N�֏����P
---------------------------------------------------------------------------------------------------------------
UIEditor.tUndoTableCache = nil										-- �Á��R�r������Ҫ����Ĵ����N����
UIEditor.nUndoStackLevel = 1										-- ��ǰ�ĳ��N�����e
UIEditor.tUndoStack = {}											-- ��ǰ�ĳ��N��������

function UIEditor.SaveTable()
	local dir = "interface\\UIEditor\\examples\\"
	local filename = UIEditor.tUndoStack[UIEditor.nUndoStackLevel][1].tChild[1].szName
	SaveLUAData(dir.."LastOpen",filename.."\t"..UIEditor.nUndoStackLevel)
	SaveLUAData(dir..filename..".tmp",UIEditor.tUndoStack)
	SaveLUAData(dir..filename..".end",{UIEditor.tUndoStack[UIEditor.nUndoStackLevel]})
	SaveLUAData(dir..filename..".inic",UIEditor.CalculateINIText())
end

function UIEditor.SaveTableTmp()
	local dir = "interface\\UIEditor\\examples\\"
	local filename = UIEditor.tUndoStack[UIEditor.nUndoStackLevel][1].tChild[1].szName
	SaveLUAData(dir..filename..".1.end",{UIEditor.tUndoStack[UIEditor.nUndoStackLevel]})
	SaveLUAData(dir..filename..".1.inic",UIEditor.CalculateINIText())
end

function UIEditor.LoadTable()
	local dir = "interface\\UIEditor\\examples\\"
	local filename = LoadLUAData(dir.."LastOpen")
	if filename then
		local f,level = filename:match("^(.-)\t(.*)$")
		filename = f or filename
		level = f and tonumber(level) or level
		local t=LoadLUAData(dir..filename..".tmp") or LoadLUAData(dir..filename..".end")
		if t then
			UIEditor.tUndoStack = t
			UIEditor.nUndoStackLevel = level and level<=#t and level or #t
			UIEditor.RefreshTree()
			return
		else
			str=LoadLUAData(dir..filename..".inic")
			if str then
				t=UIEditor.CalculateTreeNode(str)
				if t then
					UIEditor.tUndoStack = {t}
					UIEditor.nUndoStackLevel = 1
					UIEditor.RefreshTree()
					return
				end
			end
		end
	end
	UIEditor.nUndoStackLevel = 1
	UIEditor.tUndoStack[UIEditor.nUndoStackLevel] = {}
	table.insert(UIEditor.tUndoStack[UIEditor.nUndoStackLevel], {
		nLevel = -1,
		tChild = {
			{
				nLevel = 0,
				szType = "Frame",
				szName = "UIEditor",
				szLayer = "Topmost",
				tChild = {
					{
						nLevel = 1,
						szType = "Handle",
						szName = "Handle_Main",
						tChild = {
						},
					},
				},
			},
		},
	})
	table.insert({}, {
		nLevel = -1,
		tChild = {
			{
				nLevel = 0,
				szType = "Frame",
				szName = "UIEditor",
				szLayer = "Topmost",
				tChild = {
					{
						nLevel = 1,
						szType = "Handle",
						szName = "Handle_Main",
						nLeft = 100,
						nTop = 100,
						tChild = {
							{
								nLevel = 2,
								szType = "Image",
								szName = "Image_Test",
								nLeft = 100,
								nTop = 100,
								nWidth = 40,
								nHeight = 40,
								szImagePath = "ui/Image/UICommon/CommonPanel",
								tChild = {
								},
							},
							{
								nLevel = 2,
								szType = "Text",
								szName = "Text",
								tChild = {
								},
							},
							{
								nLevel = 2,
								szType = "Text",
								szName = "Text_1",
								nLeft = 100,
								nTop = 200,
								nWidth = 100,
								nHeight = 100,
								tChild = {
								},
							},
							{
								nLevel = 2,
								szType = "Text",
								szName = "Text_2",
								tChild = {
								},
							},
							{
								nLevel = 2,
								szType = "Text",
								szName = "Text_6",
								nLeft = 300,
								nTop = 300,
								nWidth = 200,
								nHeight = 200,
								tChild = {
								},
							},
						},
					},
				},
			},
		},
	})

	UIEditor.RefreshTree()
end

function UIEditor.UndoScopeStart(tNodeInfo)							-- �_ʼӛ� Undo ��Ϣ
	UIEditor.tUndoTableCache = UIEditor.CloneTable(UIEditor.tUndoStack[UIEditor.nUndoStackLevel])
	UIEditor.tUndoTableCache.szSelectedNodeName = nil
	if not UIEditor.tUndoTableCache.szSelectedNodeName then
		return
	end

	if not tNodeInfo and UIEditor.treeNodeSelected and UIEditor.treeNodeSelected.tInfo then
		tNodeInfo = UIEditor.treeNodeSelected.tInfo
	end
	if tNodeInfo then
		UIEditor.tUndoTableCache.szSelectedNodeName = tNodeInfo.szName
	end
end

function UIEditor.UndoScopeEnd(szRefreshExpandName)					-- �Y��ӛ� Undo ��Ϣ
	UIEditor.tUndoStack[UIEditor.nUndoStackLevel].szSelectedNodeName = nil
	if UIEditor.treeNodeSelected and UIEditor.treeNodeSelected.tInfo then
		UIEditor.tUndoStack[UIEditor.nUndoStackLevel].szSelectedNodeName = UIEditor.treeNodeSelected.tInfo.szName
	end

	UIEditor.tUndoStack[UIEditor.nUndoStackLevel + 1] = UIEditor.tUndoStack[UIEditor.nUndoStackLevel]
	UIEditor.tUndoStack[UIEditor.nUndoStackLevel] = UIEditor.tUndoTableCache
	UIEditor.nUndoStackLevel = UIEditor.nUndoStackLevel + 1

	for i = (UIEditor.nUndoStackLevel + 1), #UIEditor.tUndoStack do
		UIEditor.tUndoStack[i] = nil
	end
	if UIEditor.nUndoStackLevel > UIEditor.nTreeUndoLimited then
		table.remove(UIEditor.tUndoStack, 1)
		UIEditor.nUndoStackLevel = UIEditor.nTreeUndoLimited
	end
	UIEditor.tUndoTableCache = nil

	UIEditor.RefreshTree(nil, szRefreshExpandName)
	UIEditor.GridLineEnable(UIEditor.bGridLineEnable)
	UIEditor.SaveTable()
end

---------------------------------------------------------------------------------------------------------------
-- ���̎��
---------------------------------------------------------------------------------------------------------------
function UIEditor.CloneTable(tSource)								-- ��¡һ�� table ��, ȥ�������P�S, ����ȫ�µĔ������g
	if not tSource then
		return
	end

	local tResult = {}
	for key, value in ipairs(tSource) do
		if type(value) == "table" then
			table.insert(tResult, UIEditor.CloneTable(value))
		else
			table.insert(tResult, value)
		end
	end
	for key, value in pairs(tSource) do
		if not tResult[key] then
			if type(value) == "table" then
				tResult[key] = UIEditor.CloneTable(value)
			else
				tResult[key] = value
			end

		end
	end

	return tResult
end

function UIEditor.UInt2BitTable(nUInt)								-- ��һ�������D�Q��λ��, ���������ƺ�λ��С��������
	local tBitTab = {}
	local nUInt4C = nUInt
	if nUInt4C > (2 ^ 24) then
		return
	end

	for i = 1, 32 do
		local nValue = math.fmod(nUInt4C, 2)
		nUInt4C = math.floor(nUInt4C / 2)
		table.insert(tBitTab, nValue)
		if nUInt4C == 0 then
			break
		end
	end
	return tBitTab
end

function UIEditor.BitTable2UInt(tBitTab)							-- ��һ��λ���D�Q��һ������
	local nUInt = 0
	for i = 1, 24 do
		nUInt = nUInt + (tBitTab[i] or 0) * (2 ^ (i - 1))
	end
	return nUInt
end

function UIEditor.ModifyEventID(nEventID, nBitIndex, bEnable)		-- �޸�һ�� EventID ��ĳλ��ֵ
	nEventID = nEventID or 0
	local tBitTab = UIEditor.UInt2BitTable(nEventID)
	if bEnable then
		tBitTab[nBitIndex] = 1
	else
		tBitTab[nBitIndex] = 0
	end
	return UIEditor.BitTable2UInt(tBitTab)
end

function UIEditor.GetEventIDState(nEventID, nBitIndex)				-- �@ȡһ�� EventID ��ĳλ��ֵ
	nEventID = nEventID or 0
	local tBitTab = UIEditor.UInt2BitTable(nEventID)
	return tBitTab[nBitIndex] or 0
end

---------------------------------------------------------------------------------------------------------------
-- �DƬ̎�����P����
---------------------------------------------------------------------------------------------------------------
function UIEditor.GetImageFrameInfo(szImageInfoFileName)			-- ͨ��ͼƬ�ļ�֡��Ϣ���ļ�����ȡ��Ϣ
	return KG_Table.Load(szImageInfoFileName, UIEditor.tImageTXTTitle, FILE_OPEN_MODE.NORMAL)
end

---------------------------------------------------------------------------------------------------------------
-- �ɫ̎�����P����
---------------------------------------------------------------------------------------------------------------
function UIEditor.GetColorFrameInfo()								-- �ɫ��Ϣ
	return KG_Table.Load(UIEditor.szColorFileName, UIEditor.tColorTXTTitle, FILE_OPEN_MODE.NORMAL)
end

---------------------------------------------------------------------------------------------------------------
-- IO���P����
---------------------------------------------------------------------------------------------------------------

function UIEditor.RefreshTreeLevel(tree)
	if type(tree)~="table" then
		return
	end
	for _,v in pairs(tree.tChild) do
		if type(v)=="table" then
			v.nLevel = tree.nLevel + 1
			UIEditor.RefreshTreeLevel(v)
		end
	end
end

function UIEditor.CalculateTreeNode(str)
	local t,i = {},{}
	local tree = {
		nLevel = -1,
		tChild = {
		--[[{
				nLevel = 0,
				szType = "Frame",
				szName = "UIEditor",
				szLayer = "Topmost",
				tChild = {
					{
						nLevel = 1,
						szType = "Handle",
						szName = "Handle_Main",
						tChild = {
						},
					},
				},
			},]]
		},
	}
	local tnoderev = {}
	for _,v in ipairs(UIEditor.tNodeInfoDefault) do
		tnoderev[v[1]]={v[3],v[5]}
	end
	local section
	for line in (str.."\n"):gmatch("(.-)\n") do
		local s = line:match("^%[([^%]]+)%]$")
		if s then
			section = s
			t[section] = t[section] or {szName=section,tChild = {}}
			i[section] = {}
			table.insert(i,section)
		end
		if line:match("^;") or line:match("^#") then
			line = ""
		end
		local key, value = line:match("^([._$%w]+)%s-=%s-(.+)$")
		if key and value then
			local trev=tnoderev[key]
			if tonumber(value) and (not trev or trev[1]:sub(1,2)~="sz") then value = tonumber(value) end
			--if value == "true" then value = true end
			--if value == "false" then value = false end
			if key == "._WndType" then
				t[section].szType = value=="WndFrame" and "Frame" or value
			elseif trev then
				
				if trev[2] then
					t[section][trev[1]]=trev[2][2](value)
				else
					t[section][trev[1]]=value
				end
			else
				t[section][key] = value
			end
			--table.insert(i[section],key)
		end
	end
	for _,sec in ipairs(i) do
		local tt=t[sec]
		local parent = tt["._Parent"]
		if t[parent] then
			table.insert(t[parent].tChild,tt)
		else
			table.insert(tree.tChild,tt)
			tt.szLayer = parent
		end
		tt["._Parent"]=nil
	end
	UIEditor.RefreshTreeLevel(tree)
	return {tree}
end

function UIEditor.CalculateINIText()
	if not UIEditor.handleUITree then
		return szBaseName
	end

	local szINI = "# UIEditor by Danexx [QQ:24713503]\n"
	local nCount = UIEditor.handleUITree:GetItemCount()
	for i = 0, nCount - 1 do
		local treeNode = UIEditor.handleUITree:Lookup(i)
		if treeNode and treeNode.tInfo then
			local tNodeInfo = treeNode.tInfo
			szINI = szINI .. "[" .. tNodeInfo.szName .. "]\n"

			local szType = tNodeInfo.szType or ""
			local szParent = tNodeInfo.szLayer or ""
			if szType == "Frame" then
				szType = "WndFrame"
			else
				local parent = treeNode.parent
				szParent = tNodeInfo.szLayer or ""
				if parent and parent.tInfo then
					szParent = parent.tInfo.szName or ""
				end
			end
			szINI = szINI .. "._WndType=" .. szType .. "\n"
			szINI = szINI .. "._Parent=" .. szParent .. "\n"

			--Rebuild by Clouds,
			--UIEditor.tNodeInfoDefault in ConstAndEnum.lua
			--almost the same as the following statements
			--the table is {ininame, type, nodename, default, transfunc}
			local function getwndtype(mm)
				local c = mm:match("Nonzero$") or mm:match("Default$") or mm:match("Option$")
				for i,v in ipairs(UIEditor.tTreeNodeTypes) do
					if mm:find(v)==1 then
						return v,c or "Option"
					end
				end
				for i,v in pairs(UIEditor.tTreeNodeTypes) do
					if type(i)=="string" and mm:find(i)==1 then
						return i,c or "Option"
					end
				end
				if mm:find("Common")==1 then
					return "Common",c or "Option"
				elseif mm:find("Tip")==1 then
					return "Tip","Nonzero"
				end
				return mm,"Option"
			end
			local function cantp(tp,szType)
				if tp=="Tip" or tp=="Common" or tp=="Frame" then
					return true
				end
				if szType==tp then
					return true
				end
				local tps = UIEditor.tTreeNodeTypes[tp]
				for _,v in ipairs(tps or {}) do
					if v==szType then
						return true
					end
				end
				return false
			end
			local function cantc(tc,val)
				if tc=="Option" and type(val)=="nil" then
					return false
				elseif tc=="Nonzero" and (type(val)=="nil" or val==0 or val=="") then
					return false
				end
				return true
			end
			for _,v in ipairs(UIEditor.tNodeInfoDefault) do
				local mode,val=v[2],tNodeInfo[v[3]]
				for mm in (mode.."|"):gmatch("(.-)|") do
					local tp,tc=getwndtype(mm)
					if tp=="Tip" and (not tNodeInfo.szTip or tNodeInfo.szTip=="") then
						--continue
					elseif tp=="Frame" and szType~="WndFrame" then
						--continue
					elseif not cantp(tp,szType) then
						--continue
					elseif not cantc(tc,val) then
						--continue
					else
						if v[3]:find("b")==1 and not v[5] then--bool
							v[5]=fnbooltobin
						end
						if type(v[5])=="table" and type(v[5][1])=="function" then
							val = v[5][1](val)
						elseif type(v[5])=="function" then
							val = v[5](val)
						end
						if cantc(tc,val) then
							szINI = szINI .. v[1] .. "=" .. tostring(val or v[4]) .. "\n"
							break
						end
					end
				end
			end
		--[[
			szINI = szINI .. "Left=" .. (tNodeInfo.nLeft or 0) .. "\n"
			szINI = szINI .. "Top=" .. (tNodeInfo.nTop or 0) .. "\n"
			szINI = szINI .. "Width=" .. (tNodeInfo.nWidth or 0) .. "\n"
			szINI = szINI .. "Height=" .. (tNodeInfo.nHeight or 0) .. "\n"

			if szType:match("^Wnd") then
				szINI = szINI .. "DragAreaLeft=0\n" ..
					"DragAreaTop=0\n" ..
					"DragAreaWidth=0\n" ..
					"DragAreaHeight=0\n" ..
					"AnimateStartPosX=0\n" ..
					"AnimateStartPosY=0\n" ..
					"AnimateEndPosX=0\n" ..
					"AnimateEndPosY=0\n" ..
					"AnimateTimeSpace=0\n" ..
					"AnimateMoveSpeed=0\n"
			end

			-- Comment
			if tNodeInfo.szComment and tNodeInfo.szComment ~= "" then
				szINI = szINI .. "._Comment=" .. (tNodeInfo.szComment or "") .. "\n"
			end

			-- TIP
			if tNodeInfo.szTip and tNodeInfo.szTip ~= "" then
				szINI = szINI .. "$Tip=" .. (tNodeInfo.szTip or "") .. "\n"
				szINI = szINI .. "ShowTipType=0\n"
				szINI = szINI .. "OrgTip=1\n"
			end

			-- EventID
			if tNodeInfo.nEventID and tNodeInfo.nEventID ~= 0 then
				szINI = szINI .. "EventID=" .. tNodeInfo.nEventID .. "\n"
			end

			if tNodeInfo.nAlpha and tNodeInfo.nAlpha ~= 0 then
				szINI = szINI .. "Alpha=" .. tNodeInfo.nAlpha .. "\n"
			end

			if tNodeInfo.szImagePath and tNodeInfo.szImagePath ~= "" then
				szINI = szINI .. "Image=" .. tNodeInfo.szImagePath .. ".UITex\n"
			end
			if tNodeInfo.nFrame then
				szINI = szINI .. "Frame=" .. (tNodeInfo.nFrame or 0) .. "\n"
			end
			if tNodeInfo.nAniGroup then
				szINI = szINI .. "Group=" .. (tNodeInfo.nAniGroup or -1) .. "\n"
			end
			if UIEditor.tImageTypes[tNodeInfo.szImageType] then
				szINI = szINI .. "ImageType=" .. (UIEditor.tImageTypes[tNodeInfo.szImageType] or 0) .. "\n"
			end

			if tNodeInfo.nFontSpacing then
				szINI = szINI .. "FontSpacing=" .. tNodeInfo.nFontSpacing .. "\n"
			end
			if tNodeInfo.nRowSpacing then
				szINI = szINI .. "RowSpacing=" .. tNodeInfo.nRowSpacing .. "\n"
			end
			if tNodeInfo.nFontScheme then
				szINI = szINI .. "FontScheme=" .. tNodeInfo.nFontScheme .. "\n"
			end

			if UIEditor.tTextHAlignTypes[tNodeInfo.szHAlignType] then
				szINI = szINI .. "HAlign=" .. UIEditor.tTextHAlignTypes[tNodeInfo.szHAlignType] .. "\n"
			end
			if UIEditor.tTextVAlignTypes[tNodeInfo.szVAlignType] then
				szINI = szINI .. "VAlign=" .. UIEditor.tTextVAlignTypes[tNodeInfo.szVAlignType] .. "\n"
			end

			if szType == "Text" then
				szINI = szINI .. "$Text=" .. (tNodeInfo.szText or "") .. "\n"
				szINI = szINI .. "OrgText=1\n"

				for _,v in ipairs({
					"ShowAll",
					"AutoEtc",
					"CenterEachRow",
					"MultiLine",
					"MlAutoAdj",
					"RichText",
				}) do
					szINI = szINI .. ("%s=%d\n"):format(v,(tNodeInfo["b"..v] and not tNodeInfo["bNo"..v]) and 1 or 0)
				end
			end

			if szType == "Handle" then
				szINI = szINI .. "PosType=0\n"
				szINI = szINI .. "HandleType=0\n"
				szINI = szINI .. "FirstItemPosType=0\n"
			end

			if tNodeInfo.szColorName then
				szINI = szINI .. "ShadowColor=" .. tNodeInfo.szColorName .. "\n"
			end
			]]
		end
		szINI = szINI .. "\n"
	end

	--UIEditor.editINI:SetText(szINI)
	return szINI
end



--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\Base.lua" ������� ...]] .. "\n"))
