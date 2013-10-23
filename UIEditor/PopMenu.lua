--Output(pcall(dofile, "Interface\\UIEditor\\PopMenu.lua"))
OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\PopMenu.lua" ��ʼ���� ...]] .. "\n"))

UIEditor = UIEditor or {}

---------------------------------------------------------------------------------------------------------------
-- �九�c���I�ˆ�
---------------------------------------------------------------------------------------------------------------
function UIEditor.PopTreeNodeMenu(treeNode)
	if not treeNode then
		return
	end
	local tNodeInfo = treeNode.tInfo
	if not tNodeInfo then
		return
	end
	local szTreeNodeType = tNodeInfo.szType
	if not szTreeNodeType then
		return
	end
	
	local tOptions = {}
	if szTreeNodeType == "Frame" or szTreeNodeType:match("^Wnd") then
		table.insert(tOptions, {
			szOption = "������Ӵ��ڣ�",
			{szOption = "�鴰�ڡ�����WndWindow", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndWindow") end},
			{szOption = "������������WndScrollBar", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndScrollBar") end},
			{szOption = "��ť��������WndButton", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndButton") end},
			{szOption = "��ѡ�򡡡���WndCheckBox", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndCheckBox") end},
			{szOption = "����򡡡���WndEdit", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndEdit") end},
			{szOption = "��ǩҳ�桡��WndPage", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndPage") end},
			{szOption = "��ǩҳ�漯��WndPageSet", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndPageSet") end},		
			{szOption = "С��ͼ������WndMiniMap", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndMiniMap") end},		
			{szOption = "������������WndScene", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndScene") end},
			{szOption = "��Ƕ��ҳ����WndWebPage", fnAction = function() UIEditor.AppendTreeNode(treeNode, "WndWebPage") end},
		})
		
		-- ֻ��ӵ��һ�����������
		local bEnableHandle = true
		if tNodeInfo.tChild then
			for i = 1, #tNodeInfo.tChild do
				if tNodeInfo.tChild[i].szType == "Handle" then
					bEnableHandle = false
					break
				end
			end
		end
		table.insert(tOptions, {
			szOption = "��������������", bDisable = not bEnableHandle, r = 255, g = 255, b = 255, fnAction = function() UIEditor.AppendTreeNode(treeNode, "Handle") end
		})
	end
	
	if szTreeNodeType == "Frame" then
		table.insert(tOptions, {
			szOption = "�����Ĵ��ڲ㼶��",
			{szOption = "Lowest", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Lowest") end},
			{szOption = "Lowest1", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Lowest1") end},
			{szOption = "Lowest2", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Lowest2") end},
			{szOption = "Normal", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Normal") end},
			{szOption = "Normal1", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Normal1") end},
			{szOption = "Normal2", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Normal2") end},
			{szOption = "Topmost", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Topmost") end},		
			{szOption = "Topmost1", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Topmost1") end},		
			{szOption = "Topmost2", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Topmost2") end},
			{szOption = "Texture", fnAction = function() UIEditor.ModifyWindowLayer(treeNode, "Texture") end},
		})
		table.insert(tOptions, {
			bDevide = true
		})
	end

	if szTreeNodeType == "Handle" then
		table.insert(tOptions, {
			szOption = "����������",
			{szOption = "�����������Null", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Null") end},
			{szOption = "�ı��������Text", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Text") end},
			{szOption = "ͼƬ�������Image", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Image") end},
			{szOption = "��Ӱ�������Shadow", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Shadow") end},
			{szOption = "�����������Animate", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Animate") end},
			{szOption = "�����������Box", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Box") end},
			{szOption = "�����������Scene", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Scene") end},		
			{szOption = "���ڵ������TreeLeaf", fnAction = function() UIEditor.AppendTreeNode(treeNode, "TreeLeaf") end},		-- TODO: ֻ����������Ӧ���������
			{szOption = "�����������Handle", fnAction = function() UIEditor.AppendTreeNode(treeNode, "Handle") end},
		})
		table.insert(tOptions, {
			bDevide = true
		})
	end
	
	table.insert(tOptions, {
		szOption = "����춵׌�", r = 150, g = 150, b = 255, fnAction = function() UIEditor.MoveTreeNode(treeNode, -999) end
	})
	
	table.insert(tOptions, {
		szOption = "�����플�", r = 150, g = 255, b = 150, fnAction = function() UIEditor.MoveTreeNode(treeNode, 999) end
	})	
	
	table.insert(tOptions, {
		szOption = "������λ��", r = 255, g = 255, b = 255, fnAction = function() UIEditor.MoveTreeNode(treeNode, -1) end
	})
	
	table.insert(tOptions, {
		szOption = "������λ��", r = 255, g = 255, b = 255, fnAction = function() UIEditor.MoveTreeNode(treeNode, 1) end
	})	
	
	table.insert(tOptions, {
		szOption = "��ɾ���ڵ�", r = 255, g = 50, b = 75, fnAction = function() UIEditor.DeleteTreeNode(treeNode) end
	})
	
	table.insert(tOptions, {
		bDevide = true
	})

	table.insert(tOptions, {
		szOption = "�����ƽڵ�", bDisable = (treeNode.szType == "Frame"), fnAction = function() UIEditor.CopyTreeNode(treeNode) end
	})
	
	table.insert(tOptions, {
		szOption = "��ճ���ڵ�", bDisable = not UIEditor.tCopyTableCache, fnAction = function() UIEditor.PasteTreeNode(treeNode) end
	})
		
	local nX, nY = Cursor.GetPos(true)
	tOptions.x, tOptions.y = nX + 15, nY + 15
	PopupMenu(tOptions)
end

---------------------------------------------------------------------------------------------------------------
-- �ڽ��澎݋�������I�x��ؼ��Ĳˆ�, ��͸���п��ܵĈDƬ���߃���, ����ͷ�
---------------------------------------------------------------------------------------------------------------
function UIEditor.PopControlSelectMenu()
	if not UIEditor.handleUITree then
		return
	end

	local nHandleX, nHandleY = UIEditor.handleHoverSelectEffect:GetRelPos()
	local nMouseX, nMouseY = Cursor.GetPos()
	local nMouseInnerX, nMouseInnerY = nMouseX - nHandleX, nMouseY - nHandleY
	
	local tResult = {}
	local tResultArray = {}
	local nCount = UIEditor.handleUITree:GetItemCount()
	for i = 0, nCount - 1 do
		local treeNode = UIEditor.handleUITree:Lookup(i)
		if treeNode and treeNode.tInfo then
			local tNodeInfo = treeNode.tInfo
			local nX = tNodeInfo.nX or 0
			local nY = tNodeInfo.nY or 0
			local nW = tNodeInfo.nWidth or 0
			local nH = tNodeInfo.nHeight or 0

			local nShownX, nShownY = UIEditor.CalculateShownPos(treeNode)
			--if nMouseInnerX >= nX and nMouseInnerX <= nX + nW and nMouseInnerY >= nY and nMouseInnerY <= nY + nH then
			if nMouseInnerX >= nShownX and nMouseInnerX <= nShownX + nW and nMouseInnerY >= nShownY and nMouseInnerY <= nShownY + nH then
				tResult[tNodeInfo.szType] = tResult[tNodeInfo.szType] or {}
				tResult[tNodeInfo.szType][tNodeInfo.szName] = treeNode
				table.insert(tResultArray, treeNode)
			end
		end
	end

	local tOptions = {}
	if #tResultArray == 0 then
		return
	elseif #tResultArray <= 10 then
		for i = 1, #tResultArray do
			table.insert(tOptions, {
				szOption = tResultArray[i].tInfo.szName or "[δ֪�ؼ�]", fnAction = function()
					UIEditor.SelectTreeNode(tResultArray[i])
				end
			})
		end
	else
		for szKey, tValue in pairs(tResult) do
			local t = {
				szOption = szKey, r = 200, g = 150, b = 255,
			}
			for szControlName, treeNode in pairs(tValue) do
				table.insert(t, {
					szOption = szControlName, fnAction = function()
						UIEditor.SelectTreeNode(treeNode)
					end
				})
			end
			table.insert(tOptions, t)
		end		
	end

	tOptions.x, tOptions.y = nMouseX + 15, nMouseY + 15
	PopupMenu(tOptions)
end

---------------------------------------------------------------------------------------------------------------
-- �@�ǈDƬ�ļ��x��ˆ�
---------------------------------------------------------------------------------------------------------------
function UIEditor.PopImageSelectMenu()
	local tOptions = {}
	for szKey, tValue in pairs(UIEditor.tImageFileBaseNameList) do
		local t = {
			szOption = szKey, r = 200, g = 150, b = 255,
		}
		for i = 1, #tValue do
			table.insert(t, {
				szOption = tValue[i], fnAction = function()
					if not UIEditor.treeNodeSelected then
						return
					end
					UIEditor.UndoScopeStart()
					UIEditor.treeNodeSelected.tInfo.szImagePath = tValue[i]
					UIEditor.UndoScopeEnd(UIEditor.treeNodeSelected.tInfo.szName)
				end
			})
		end
		table.insert(tOptions, t)
	end
	
	local nX, nY = Cursor.GetPos()
	tOptions.x, tOptions.y = nX + 15, nY + 15
	PopupMenu(tOptions)
end

---------------------------------------------------------------------------------------------------------------
-- �@�ǈDƬ����x��ˆ�
---------------------------------------------------------------------------------------------------------------
function UIEditor.PopImageTypeMenu()
	local tOptions = {}
	for i = 1, #UIEditor.tImageTypes do
		table.insert(tOptions, {
			szOption = UIEditor.tImageTypes[i], fnAction = function()
				if not UIEditor.treeNodeSelected then
					return
				end
				UIEditor.UndoScopeStart()
				UIEditor.treeNodeSelected.tInfo.szImageType = UIEditor.tImageTypes[i]
				UIEditor.UndoScopeEnd(UIEditor.treeNodeSelected.tInfo.szName)
			end,
		})		
	end

	local nX, nY = Cursor.GetPos()
	tOptions.x, tOptions.y = nX + 15, nY + 15
	PopupMenu(tOptions)
end

---------------------------------------------------------------------------------------------------------------
-- �@�ǹ��ܹ����x��ˆ�
---------------------------------------------------------------------------------------------------------------
function UIEditor.PopToolMenu()
	local tOptions = {
		{szOption = "�_��߅���@ʾ��HelpGridLine��", bMCheck = true, bChecked = UIEditor.bGridLineEnable, fnAction = function()
			UIEditor.bGridLineEnable = not UIEditor.bGridLineEnable
			UIEditor.GridLineEnable(UIEditor.bGridLineEnable)
			GetPopupMenu():Hide()
		end},
	}

	local nX, nY = Cursor.GetPos()
	tOptions.x, tOptions.y = nX + 15, nY + 15
	PopupMenu(tOptions)
end

function UIEditor.PopFileMenu()
	local tOptions = {
		{szOption = "�鿴INI�ı�����", fnAction = function()
			UIEditor.wndINI:Show()
			UIEditor.editINI:SetText(UIEditor.CalculateINIText())
			GetPopupMenu():Hide()
		end},
	}

	local nX, nY = Cursor.GetPos()
	tOptions.x, tOptions.y = nX + 15, nY + 15
	PopupMenu(tOptions)
end

OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\PopMenu.lua" ������� ...]] .. "\n"))
