--Output(pcall(dofile, "Interface\\UIEditor\\UIContent.lua"))
--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\UIContent.lua" ��ʼ���� ...]] .. "\n"))

UIEditor = UIEditor or {}

---------------------------------------------------------------------------------------------------------------
-- ���澎݋����ͨ��׃�����x
---------------------------------------------------------------------------------------------------------------
UIEditor.imageDraggingNodeMask = nil
UIEditor.nDraggingNodeMaskPreRecordX = 0
UIEditor.nDraggingNodeMaskPreRecordY = 0
UIEditor.nDraggingNodeMaskPreRecordMX = 0
UIEditor.nDraggingNodeMaskPreRecordMY = 0
UIEditor.nDraggingNodeMaskAbsX = 0
UIEditor.nDraggingNodeMaskAbsY = 0
UIEditor.bDraggingNodeMaskSizeMode = false

UIEditor.TempInfoBarText = ""							-- ���½ǵ���Ϣ����
UIEditor.bGridLineEnable = false						-- �Ƿ��@ʾ�ؼ���С�ľW��

---------------------------------------------------------------------------------------------------------------
-- ���澎݋����ϵ�y���{
---------------------------------------------------------------------------------------------------------------
function UIEditor.OnFrameRender_UIContent()
	if UIEditor.imageDraggingNodeMask then
		local nMouseX, nMouseY = Cursor.GetPos()
		local nW, nH = UIEditor.imageDraggingNodeMask:GetSize()
		local nWHandle, nHHandle = UIEditor.handleUIContent:GetSize()

		if not UIEditor.bDraggingNodeMaskSizeMode then
			local nHandleX, nHandleY = UIEditor.imageDraggingNodeMask.nHandleX, UIEditor.imageDraggingNodeMask.nHandleY

			-- �s�����
			local bOutbounds = false
			if nMouseX < nHandleX then
				bOutbounds = true
				nMouseX = nHandleX
			elseif nMouseX > nHandleX + nWHandle then
				bOutbounds = true
				nMouseX = nHandleX + nWHandle
			end
			if nMouseY < nHandleY then
				bOutbounds = true
				nMouseY = nHandleY
			elseif nMouseY > nHandleY + nHHandle then
				bOutbounds = true
				nMouseY = nHandleY + nHHandle
			end
			if bOutbounds then
				Cursor.SetPos(nMouseX, nMouseY)
			end

			local nX, nY = math.floor(nMouseX - UIEditor.nDraggingNodeMaskAbsX), math.floor(nMouseY - UIEditor.nDraggingNodeMaskAbsY)
			UIEditor.imageDraggingNodeMask:SetRelPos(nX, nY)

			-- Ӌ�㌍�H�ı���������, �@ʾλ��Ҫ�pȥ���и����c������
			if UIEditor.treeNodeSelected then
				local nRecordX, nRecordY = UIEditor.CalculateRecordPos(UIEditor.treeNodeSelected, nX, nY)
				UIEditor.TempInfoBarText = ("�ؼ��{����{X= %d, Y= %d}, {W= %d, H= %d}, {ShownX= %d, ShownY= %d}"):format(nRecordX, nRecordY, nW, nH, nX, nY)
			else
				UIEditor.TempInfoBarText = "�ؼ��{�����]���x����Ч�Ŀؼ����c��̎��Y�������F���}��"
			end
		else	-- ��׃��С��̎��
			local nXBak, nYBak = UIEditor.imageDraggingNodeMask.nXBak, UIEditor.imageDraggingNodeMask.nYBak
			local nWBak, nHBak = UIEditor.imageDraggingNodeMask.nWBak, UIEditor.imageDraggingNodeMask.nHBak
			local nHandleX, nHandleY = UIEditor.imageDraggingNodeMask.nHandleX, UIEditor.imageDraggingNodeMask.nHandleY
			local nXAttach = UIEditor.imageDraggingNodeMask.nXAttach
			local nYAttach = UIEditor.imageDraggingNodeMask.nYAttach

			-- �s�����
			local bOutbounds = false
			if nMouseX < nHandleX then
				bOutbounds = true
				nMouseX = nHandleX
			elseif nMouseX > nHandleX + nWHandle then
				bOutbounds = true
				nMouseX = nHandleX + nWHandle
			end
			if nMouseY < nHandleY then
				bOutbounds = true
				nMouseY = nHandleY
			elseif nMouseY > nHandleY + nHHandle then
				bOutbounds = true
				nMouseY = nHandleY + nHHandle
			end
			if bOutbounds then
				Cursor.SetPos(nMouseX, nMouseY)
			end

			local nXNew, nYNew = nXBak, nYBak
			local nWNew, nHNew = nW, nH
			if nXAttach == 1 then
				if nMouseX < nXBak + nHandleX then
					bOutbounds = true
					nMouseX = nXBak + nHandleX
				end
				nWNew = nMouseX - nXBak - nHandleX
			elseif nXAttach == -1 then
				if nMouseX > nXBak + nHandleX + nWBak then
					bOutbounds = true
					nMouseX = nXBak + nHandleX + nWBak
				end
				nXNew = nMouseX - nHandleX
				nWNew = nWBak - nXNew + nXBak
			end

			if nYAttach == 1 then
				if nMouseY < nYBak + nHandleY then
					bOutbounds = true
					nMouseY = nYBak + nHandleY
				end
				nHNew = nMouseY - nYBak - nHandleY
			elseif nYAttach == -1 then
				if nMouseY > nYBak + nHandleY + nHBak then
					bOutbounds = true
					nMouseY = nYBak + nHandleY + nHBak
				end
				nYNew = nMouseY - nHandleY
				nHNew = nHBak - nYNew + nYBak
			end
			if bOutbounds then
				Cursor.SetPos(nMouseX, nMouseY)
			end

			UIEditor.imageDraggingNodeMask:SetRelPos(nXNew, nYNew)
			UIEditor.imageDraggingNodeMask:SetSize(nWNew, nHNew)

			-- Ӌ�㌍�H�ı���������, �@ʾλ��Ҫ�pȥ���и����c������
			if UIEditor.treeNodeSelected then
				local nRecordX, nRecordY = UIEditor.CalculateRecordPos(UIEditor.treeNodeSelected, nXNew, nYNew)
				UIEditor.TempInfoBarText = ("�ؼ��{����{X= %d, Y= %d}, {W= %d, H= %d}, {ShownX= %d, ShownY= %d}"):format(nRecordX, nRecordY, nWNew, nHNew, nXNew, nYNew)
			else
				UIEditor.TempInfoBarText = "�ؼ��{�����]���x����Ч�Ŀؼ����c��̎��Y�������F���}��"
			end
		end

		UIEditor.handleHoverSelectEffect:FormatAllItemPos()
	end

	UIEditor.handleBG:Lookup("Text_TempInfoBar"):SetText(UIEditor.TempInfoBarText)
end

function UIEditor.OnItemLButtonDown_UIContent()
	local szName = this:GetName()

	if szName == "Image_SelectedNodeMask" then
		UIEditor.nDraggingNodeMaskPreRecordX, UIEditor.nDraggingNodeMaskPreRecordY = this:GetRelPos()
		UIEditor.nDraggingNodeMaskPreRecordMX, UIEditor.nDraggingNodeMaskPreRecordMY = Cursor.GetPos()
		if UIEditor.imageDraggingNodeMask then
			UIEditor.imageDraggingNodeMask = nil

			-- Ӌ�㌍�H�ı���������, λ��Ҫ�pȥ���и����c������
			if UIEditor.treeNodeSelected then
				local nRecordX, nRecordY = UIEditor.CalculateRecordPos(UIEditor.treeNodeSelected, UIEditor.nDraggingNodeMaskPreRecordX, UIEditor.nDraggingNodeMaskPreRecordY)

				-- ̎�� MASK ��λ��
				UIEditor.wndSCPos:Lookup("Edit_SC_PosX"):SetText(nRecordX)
				UIEditor.wndSCPos:Lookup("Edit_SC_PosY"):SetText(nRecordY)
				-- ̎�� MASK �Ĵ�С
				local nW, nH = this:GetSize()
				UIEditor.wndSCSize:Lookup("Edit_SC_SizeW"):SetText(nW)
				UIEditor.wndSCSize:Lookup("Edit_SC_SizeH"):SetText(nH)

				-- �������˺ʹ�С
				UIEditor.RecordPosOrSize()
				UIEditor.TempInfoBarText = ""
			else
				UIEditor.TempInfoBarText = "�ؼ��{�����]���x����Ч�Ŀؼ����c���ؼ�λ�ñ���ʧ����"
			end
		end
	end
end

function UIEditor.OnItemLButtonClick_UIContent()
	local szName = this:GetName()

	if szName:match("^FrameSelection_") or szName:match("^AniGroupSelection_") then
		UIEditor.wndSICommon:Lookup("Edit_SI_Frame"):SetText(this.nFrameIndex or this.nAniGroup or -1)

		if UIEditor.treeNodeSelected then
			UIEditor.treeNodeSelected.tInfo.nImageWOrg = this.nW or 0
			UIEditor.treeNodeSelected.tInfo.nImageHOrg = this.nH or 0
			UIEditor.UndoScopeStart()
			if UIEditor.treeNodeSelected.tInfo.szType == "Image" then
				UIEditor.treeNodeSelected.tInfo.nFrame = this.nFrameIndex or 0
			else
				UIEditor.treeNodeSelected.tInfo.nAniGroup = this.nAniGroup or -1
			end
			UIEditor.UndoScopeEnd()
		end

		if IsCtrlKeyDown() then
			UIEditor.wndSCSize:Lookup("Edit_SC_SizeW"):SetText(this.nW)
			UIEditor.wndSCSize:Lookup("Edit_SC_SizeH"):SetText(this.nH)
			UIEditor.RecordPosOrSize()
		elseif UIEditor.treeNodeSelected then
			UIEditor.RefreshTree(nil, UIEditor.treeNodeSelected.tInfo.szName)
		end

		UIEditor.CloseAllSelector()
	elseif szName:match("^FontDummy_") then
		UIEditor.wndSTCommon:Lookup("Edit_ST_FontScheme"):SetText(this.nFontScheme or 0)

		if UIEditor.treeNodeSelected then
			UIEditor.UndoScopeStart()
			UIEditor.treeNodeSelected.tInfo.nFontScheme = this.nFontScheme or nil
			UIEditor.UndoScopeEnd()
			UIEditor.RefreshTree(nil, UIEditor.treeNodeSelected.tInfo.szName)
		end

		UIEditor.CloseAllSelector()
	elseif szName:match("^ShadowDummy_") then
		UIEditor.wndSSCommon:Lookup("", "Shadow_ColorShow"):SetShadowColor(this.szColorName or "black")

		if UIEditor.treeNodeSelected then
			UIEditor.UndoScopeStart()
			UIEditor.treeNodeSelected.tInfo.szColorName = this.szColorName or "black"
			UIEditor.UndoScopeEnd()
			UIEditor.RefreshTree(nil, UIEditor.treeNodeSelected.tInfo.szName)
		end

		UIEditor.CloseAllSelector()
	end
end

function UIEditor.OnItemRButtonDown_UIContent()
	local szName = this:GetName()

	if szName == "Image_SelectedNodeMask" and UIEditor.imageDraggingNodeMask then
		-- ȡ��Mask��ק
		UIEditor.imageDraggingNodeMask:SetRelPos(UIEditor.imageDraggingNodeMask.nXBak, UIEditor.imageDraggingNodeMask.nYBak)
		UIEditor.imageDraggingNodeMask.nXBak, UIEditor.imageDraggingNodeMask.nYBak = 0, 0
		UIEditor.imageDraggingNodeMask:SetSize(UIEditor.imageDraggingNodeMask.nWBak, UIEditor.imageDraggingNodeMask.nHBak)
		UIEditor.imageDraggingNodeMask.nWBak, UIEditor.imageDraggingNodeMask.nHBak = 0, 0
		UIEditor.imageDraggingNodeMask:SetAlpha(150)
		UIEditor.imageDraggingNodeMask = nil
		UIEditor.handleHoverSelectEffect:FormatAllItemPos()
	end
end

function UIEditor.OnItemRButtonClick_UIContent()
	local szName = this:GetName()

	if szName == "Image_SelectedNodeMask" or szName == "Handle_HoverSelectEffect" then
		UIEditor.PopControlSelectMenu()
	end
end

function UIEditor.OnItemMouseEnter_UIContent()
	local szName = this:GetName()

	if szName:match("^FrameSelection_") or szName:match("^AniGroupSelection_") then
		UIEditor.imageHoverBox:Show()
		UIEditor.imageHoverBox:SetSize(this.nW, this.nH)
		UIEditor.imageHoverBox:SetRelPos(this.nX, this.nY)
		UIEditor.handleHoverSelectEffect:FormatAllItemPos()

		if IsCtrlKeyDown() then
			local nMouseX, nMouseY = Cursor.GetPos()
			local szTipInfo =
				"<Text>text=" .. EncodeComponentsString("�� ֡��ţ�") .. " font=162 </text>" ..
					"<Text>text=" .. EncodeComponentsString(this.nFrameIndex or this.nAniGroup) .. " font=100 </text>" ..
				"<Text>text=" .. EncodeComponentsString("\n�� ֡��ȣ�") .. " font=162 </text>" ..
					"<Text>text=" .. EncodeComponentsString(this.nW) .. " font=162 </text>" ..
				"<Text>text=" .. EncodeComponentsString("\n�� ֡�߶ȣ�") .. " font=162 </text>" ..
					"<Text>text=" .. EncodeComponentsString(this.nH) .. " font=162 </text>"
			OutputTip(szTipInfo, 1000, {nMouseX, nMouseY, 0, 0})
		end

		this:SetAlpha(255)
		UIEditor.TempInfoBarText = ("�� ֡��ţ�%d���� ֡��ȣ�%d���� ֡�߶ȣ�%d����%s��"):format(this.nFrameIndex or this.nAniGroup, this.nW, this.nH, "��סCtrl�x���ʹ�����x�DƬĬ�J�ߴ�")
	elseif szName:match("^ShadowDummy_") then
		UIEditor.imageHoverBox:Show()
		UIEditor.imageHoverBox:SetSize(this.nW, this.nH)
		UIEditor.imageHoverBox:SetRelPos(this.nX, this.nY)
		UIEditor.handleHoverSelectEffect:FormatAllItemPos()

		local nMouseX, nMouseY = Cursor.GetPos()
		local szTipInfo =
			"<Text>text=" .. EncodeComponentsString("�� �ɫ���Q��") .. " font=162 </text>" ..
				"<Text>text=" .. EncodeComponentsString(this.szColorName) .. " font=100 </text>" ..
			"<Text>text=" .. EncodeComponentsString("\n�� RGB��") .. " font=162 </text>" ..
				"<Text>text=" .. EncodeComponentsString("(" .. this.nRed .. ", " .. this.nGreen .. ", " .. this.nBlue .. ")") .. " font=162 </text>"
		OutputTip(szTipInfo, 1000, {nMouseX, nMouseY, 0, 0})

		UIEditor.TempInfoBarText = ("�� �ɫ���Q��%s���� RGB��(%d, %d, %d)"):format(this.szColorName, this.nRed, this.nGreen, this.nBlue)
	elseif szName == "Image_SelectedNodeMask" then
		this:SetAlpha(250)
	end
end

function UIEditor.OnItemMouseLeave_UIContent()
	local szName = this:GetName()

	if szName:match("^FrameSelection_") or szName:match("^AniGroupSelection_") then
		UIEditor.imageHoverBox:Hide()
		this:SetAlpha(200)
		UIEditor.TempInfoBarText = ""
	elseif szName:match("^ShadowDummy_") then
		UIEditor.imageHoverBox:Hide()
		UIEditor.TempInfoBarText = ""
	elseif szName == "Image_SelectedNodeMask" then
		if not UIEditor.imageDraggingNodeMask then
			this:SetAlpha(150)
		end
	end

	HideTip()
end

function UIEditor.OnItemLButtonDrag_UIContent()
	local szName = this:GetName()

	if szName == "Image_SelectedNodeMask" then
		-- �Д����τ�λ��߀�Ǹ�׃��С
		UIEditor.bDraggingNodeMaskSizeMode = IsCtrlKeyDown()

		local nHandleX, nHandleY = UIEditor.handleHoverSelectEffect:GetRelPos()
		local nMouseX, nMouseY = UIEditor.nDraggingNodeMaskPreRecordMX, UIEditor.nDraggingNodeMaskPreRecordMY

		UIEditor.imageDraggingNodeMask = this
		this.nXBak, this.nYBak = UIEditor.nDraggingNodeMaskPreRecordX, UIEditor.nDraggingNodeMaskPreRecordY
		this.nWBak, this.nHBak = this:GetSize()
		this.nHandleX, this.nHandleY = nHandleX, nHandleY
		this.nMouseXBak, this.nMouseYBak = nMouseX, nMouseY

		UIEditor.nDraggingNodeMaskAbsX, UIEditor.nDraggingNodeMaskAbsY = nMouseX - UIEditor.nDraggingNodeMaskPreRecordX, nMouseY - UIEditor.nDraggingNodeMaskPreRecordY

		this.nMouseInnerX, this.nMouseInnerY = UIEditor.nDraggingNodeMaskAbsX - nHandleX, UIEditor.nDraggingNodeMaskAbsY - nHandleY

		-- �@�eӋ����ק���
		this.nXAttach = 0
		this.nYAttach = 0
		if UIEditor.bDraggingNodeMaskSizeMode then
			if this.nWBak - this.nMouseInnerX <= 10 then
				this.nXAttach = 1
			elseif this.nMouseInnerX <= 10 then
				this.nXAttach = -1
			end
			if this.nHBak - this.nMouseInnerY <= 10 then
				this.nYAttach = 1
			elseif this.nMouseInnerY <= 10 then
				this.nYAttach = -1
			end

			if this.nXAttach == 0 and this.nYAttach == 0 then
				UIEditor.bDraggingNodeMaskSizeMode = false
			end
		end
	end
end

function UIEditor.OnItemLButtonDragEnd_UIContent()
	local szName = this:GetName()

	if szName == "Image_SelectedNodeMask" then
		local nX, nY = this:GetRelPos()
		local nW, nH = this:GetSize()
		UIEditor.imageDraggingNodeMask = nil

		-- Ӌ�㌍�H�ı���������, λ��Ҫ�pȥ���и����c������
		if UIEditor.treeNodeSelected then
			local nRecordX, nRecordY = UIEditor.CalculateRecordPos(UIEditor.treeNodeSelected, nX, nY)

			-- ̎��λ��
			UIEditor.wndSCPos:Lookup("Edit_SC_PosX"):SetText(nRecordX)
			UIEditor.wndSCPos:Lookup("Edit_SC_PosY"):SetText(nRecordY)
			-- ̎��ߴ�
			UIEditor.wndSCSize:Lookup("Edit_SC_SizeW"):SetText(nW)
			UIEditor.wndSCSize:Lookup("Edit_SC_SizeH"):SetText(nH)

			-- �������˺ʹ�С
			UIEditor.RecordPosOrSize()

			UIEditor.TempInfoBarText = ""
		else
			UIEditor.TempInfoBarText = "�ؼ��{�����]���x����Ч�Ŀؼ����c���ؼ�λ�ñ���ʧ����"
		end
	end
end

---------------------------------------------------------------------------------------------------------------
-- ���澎݋���ڹ��ܺ���
---------------------------------------------------------------------------------------------------------------
function UIEditor.GridLineEnable(bEnable)
	UIEditor.bGridLineEnable = bEnable

	UIEditor.handleHelpGridLine:Clear()
	if UIEditor.bGridLineEnable then					-- ̎�� GridLine ���@ʾ, �������е� GridLine
		local nCount = UIEditor.handleUITree:GetItemCount()
		for i = 0, nCount - 1 do
			local treeNode = UIEditor.handleUITree:Lookup(i)
			if treeNode and treeNode.tInfo then
				local nShownX, nShownY = UIEditor.CalculateShownPos(treeNode)
				local nW, nH = treeNode.tInfo.nWidth, treeNode.tInfo.nHeight
				local grid = UIEditor.handleHelpGridLine:AppendItemFromIni(UIEditor.szINIPath, "Image_GridLineDummy", "GridLine_" .. i)
				grid:SetRelPos(nShownX, nShownY)
				grid:SetSize(nW, nH)
			end
		end
		UIEditor.handleHelpGridLine:FormatAllItemPos()
	end
end

-- ���㵱ǰ�ؼ���ʵ����ʾ����, �����ʾ���������Լ����Լ������и��ؼ�һ����������������
function UIEditor.CalculateShownPos(treeNode, nRecordX, nRecordY)
	if not treeNode then
		return
	end
	local tNodeInfo = treeNode.tInfo
	if not tNodeInfo then
		return
	end

	local nShownX, nShownY = nRecordX or tNodeInfo.nLeft or 0, nRecordY or tNodeInfo.nTop or 0
	local parent = treeNode.parent
	for k = 0, 15 do
		if parent then
			local tParentNodeInfo = parent.tInfo
			if tParentNodeInfo then
				nShownX, nShownY = nShownX + (tParentNodeInfo.nLeft or 0), nShownY + (tParentNodeInfo.nTop or 0)
			end
			parent = parent.parent
		else
			break
		end
	end

	return nShownX, nShownY
end

-- ���㵱ǰ�ؼ��ı�������
function UIEditor.CalculateRecordPos(treeNode, nShownX, nShownY)
	if not treeNode then
		return
	end
	local tNodeInfo = treeNode.tInfo
	if not tNodeInfo then
		return
	end

	local nRecordX, nRecordY = nShownX or 0, nShownY or 0
	local parent = treeNode.parent
	for k = 0, 15 do
		if parent then
			local tParentNodeInfo = parent.tInfo
			if tParentNodeInfo then
				nRecordX, nRecordY = nRecordX - (tParentNodeInfo.nLeft or 0), nRecordY - (tParentNodeInfo.nTop or 0)
			end
			parent = parent.parent
		else
			break
		end
	end

	return nRecordX, nRecordY
end

-- �������ڵ㴴��һ����Ӧ�Ŀؼ���ʾ����
function UIEditor.AppendUIContent(node)
	local tNodeInfo = node.tInfo
	if not tNodeInfo then
		return
	end

	local nShownX, nShownY = UIEditor.CalculateShownPos(node)

	local szType = tNodeInfo.szType
	if (szType == "Image" or szType == "WndButton" or szType == "WndCheckBox") and tNodeInfo.szImagePath and tNodeInfo.szImagePath ~= "" then
		local nImageIndex = UIEditor.handleUIContent:GetItemCount()
		UIEditor.handleUIContent:AppendItemFromString(("<image>w=%s h=%s path=\"%s.UITex\" frame=%s eventid=277 name=\"%s\" </image>"):format(tNodeInfo.nWidth or 0, tNodeInfo.nHeight or 0, tNodeInfo.szImagePath or "", tNodeInfo.nFrame or 0, "UIContent_" .. nImageIndex))
		local img = UIEditor.handleUIContent:Lookup(nImageIndex)
		if img then
			img:SetRelPos(nShownX, nShownY)
			img:SetAlpha(tNodeInfo.nAlpha or 255)
			img:SetImageType(UIEditor.tImageTypes[tNodeInfo.szImageType] or 0)
		end
	elseif szType == "Animate" and tNodeInfo.szImagePath and tNodeInfo.szImagePath ~= "" then
		local nIndex = UIEditor.handleUIContent:GetItemCount()
		local ani = UIEditor.handleUIContent:AppendItemFromIni(UIEditor.szINIPath, "Animate", "UIContent_" .. nIndex)
		if ani then
			ani:SetImagePath(tNodeInfo.szImagePath .. ".UITex")
			ani:SetGroup(tNodeInfo.nAniGroup or -1)
			ani:SetRelPos(nShownX, nShownY)
			ani:SetSize(tNodeInfo.nWidth or 0, tNodeInfo.nHeight or 0)
			ani:SetAlpha(tNodeInfo.nAlpha or 255)
		end
	elseif szType == "Text" or szType == "WndEdit" then
		local nIndex = UIEditor.handleUIContent:GetItemCount()
		local text = UIEditor.handleUIContent:AppendItemFromIni(UIEditor.szINIPath, "Text", "UIContent_" .. nIndex)
		if text then
			local szText = tNodeInfo.szText or ""
			szText = szText:gsub("\\n", "\n")
			text:SetText(szText)

			text:SetRelPos(nShownX, nShownY)
			text:SetSize(tNodeInfo.nWidth or 0, tNodeInfo.nHeight or 0)
			text:SetAlpha(tNodeInfo.nAlpha or 255)
			text:SetFontSpacing(tNodeInfo.nFontSpacing or 0)
			text:SetRowSpacing(tNodeInfo.nRowSpacing or 0)
			text:SetFontScheme(tNodeInfo.nFontScheme or 0)

			text:SetHAlign(UIEditor.tTextHAlignTypes[tNodeInfo.szHAlignType] or 0)
			text:SetVAlign(UIEditor.tTextVAlignTypes[tNodeInfo.szVAlignType] or 0)

			text:SetCenterEachLine(tNodeInfo.bCenterEachRow or false)
			text:SetMultiLine(tNodeInfo.bMultiLine or false)
			text:SetRichText(not tNodeInfo.bNoRichText or true)
		end
	elseif szType == "Shadow" then
		local nIndex = UIEditor.handleUIContent:GetItemCount()
		local shadow = UIEditor.handleUIContent:AppendItemFromIni(UIEditor.szINIPath, "Shadow", "UIContent_" .. nIndex)
		if shadow then
			shadow:SetRelPos(nShownX, nShownY)
			shadow:SetSize(tNodeInfo.nWidth or 0, tNodeInfo.nHeight or 0)

			shadow:SetShadowColor(tNodeInfo.szColorName or "black")
			shadow:SetAlpha(tNodeInfo.nAlpha or 255)
		end
	end
end

function UIEditor.LoadUITexToImageSelectorPanel(szBaseName, bIsAni)
	UIEditor.handleImageSelector:Clear()
	UIEditor.handleUIContent:Hide()
	UIEditor.imageSelectedMask:Hide()

	if not szBaseName then
		return
	end
	local tInfo = UIEditor.GetImageFrameInfo(szBaseName .. ".txt")
	if not tInfo then
		return
	end

	if not bIsAni then
		for i = 0, 256 do
			local tLine = tInfo:Search(i)
			if tLine then
				if tonumber(tLine.Width) ~= 0 and tonumber(tLine.High) ~= 0 then
					UIEditor.handleImageSelector:AppendItemFromString(("<image>w=%s h=%s path=\"%s.UITex\" frame=%s eventid=277 name=\"%s\" </image>"):format(tLine.Width, tLine.High, szBaseName, i, "FrameSelection_" .. i))
					local nImageIndex = UIEditor.handleImageSelector:GetItemCount() - 1
					local img = UIEditor.handleImageSelector:Lookup(nImageIndex)

					img.nFrameIndex = i
					img.szBaseFileName = szBaseName
					img.nX = tonumber(tLine.Left)
					img.nY = tonumber(tLine.Top)
					img.nW = tonumber(tLine.Width)
					img.nH = tonumber(tLine.High)

					img:SetRelPos(img.nX, img.nY)
					img:SetAlpha(200)
				end
			else
				break
			end
		end
	else
		local nAniX = 10
		local nAniNextX = nAniX
		local nAniY = 10
		local bHasAni = false
		for i = 0, 9 do
			local ani = UIEditor.handleImageSelector:AppendItemFromIni(UIEditor.szINIPath, "Animate", "AniGroupSelection_" .. i)
			ani:SetImagePath(szBaseName .. ".UITex")
			ani:SetGroup(i)
			ani:AutoSize()
			ani:SetRelPos(nAniX, nAniY)

			local nAniW, nAniH = ani:GetSize()

			ani.nAniGroup = i
			ani.szBaseFileName = szBaseName
			ani.nX = nAniX
			ani.nY = nAniY
			ani.nW = nAniW
			ani.nH = nAniH

			nAniY = nAniY + nAniH + 10
			if nAniNextX <= nAniX + nAniW then
				nAniNextX = nAniX + nAniW + 10
			end
			if nAniY >= 500 then
				nAniX = nAniNextX
				nAniY = 10
			end

			if nAniW > 0 and nAniH > 0 then
				bHasAni = true
			end
		end
		if not bHasAni then
			UIEditor.CloseAllSelector()
		end
	end

	UIEditor.handleImageSelector:FormatAllItemPos()
end

function UIEditor.LoadTextDummyToFontSelectorPanel()
	UIEditor.handleFontSelector:Clear()
	UIEditor.handleUIContent:Hide()
	UIEditor.imageSelectedMask:Hide()

	for i = 0, 255 do
		local text = UIEditor.handleFontSelector:AppendItemFromIni(UIEditor.szINIPath, "Text_SelectorDummy", "FontDummy_" .. i)
		text:SetFontScheme(i)
		text.nFontScheme = i

		local nFS = text:GetFontScheme()
		if nFS == i then
			text:SetText("���w" .. nFS)

			local nX = i % 10 * 80
			local nY = math.floor(i / 10) * 25
			text:SetRelPos(nX, nY)
		else
			text:SetText("")
			text:SetRelPos(4000, 4000)
			text:Hide()
		end
	end

	UIEditor.handleFontSelector:FormatAllItemPos()
end

function UIEditor.LoadColorDummyToFontSelectorPanel()
	UIEditor.handleFontSelector:Clear()
	UIEditor.handleUIContent:Hide()
	UIEditor.imageSelectedMask:Hide()

	local tInfo = UIEditor.GetColorFrameInfo()
	if not tInfo then
		return
	end

	for i = 0, 63 do
		local tLine = tInfo:Search(i)
		if tLine then
			local szColorName = tLine.name
			local r, g, b = tLine.r, tLine.g, tLine.b
			if szColorName then
				local shadow = UIEditor.handleFontSelector:AppendItemFromIni(UIEditor.szINIPath, "Shadow", "ShadowDummy_" .. i)
				shadow:SetShadowColor(szColorName)
				shadow:SetAlpha(255)

				local nX = i % 10 * 60 + 10
				local nY = math.floor(i / 10) * 60 + 10
				shadow:SetRelPos(nX, nY)
				shadow:SetSize(50, 50)

				shadow.szColorName = tLine.name
				shadow.nRed, shadow.nGreen, shadow.nBlue = tLine.r, tLine.g, tLine.b

				shadow.nX = nX
				shadow.nY = nY
				shadow.nW = 50
				shadow.nH = 50
			end
		end
	end

	UIEditor.handleFontSelector:FormatAllItemPos()
end

--OutputMessage("MSG_SYS", "[UIEditor] " .. tostring([["Interface\UIEditor\UIContent.lua" ������� ...]] .. "\n"))
