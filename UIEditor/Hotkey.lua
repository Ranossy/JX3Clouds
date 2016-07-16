Hotkey.AddBinding("UIEditor_ShowHide", "�_�����P�]����", "�����澎݋����",
	function()
		local frame = Station.Lookup("Topmost/UIEditor")
		if frame and frame:IsVisible() then
			UIEditor.ClosePanel(true)
		else
			UIEditor.OpenPanel()
		end
	end, nil)

Hotkey.AddBinding("UIEditor_Undo", "���������N", "",
	function()
		UIEditor.RefreshTree(-1)
	end, nil)

Hotkey.AddBinding("UIEditor_Redo", "�������֏�", "",
	function()
		UIEditor.RefreshTree(1)
	end, nil)

Hotkey.AddBinding("UIEditor_Refresh", "������ˢ��", "",
	function()
		UIEditor.RefreshTree()
	end, nil)

Hotkey.AddBinding("UIEditor_PosLeft", "λ�ã�����", "",
	function()
		UIEditor.ModifyPosOrSize(-1, "Edit_SC_PosX", true)
		UIEditor.szPressDownName = "Edit_SC_PosX"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = -1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_PosRight", "λ�ã�����", "",
	function()
		UIEditor.ModifyPosOrSize(1, "Edit_SC_PosX", true)
		UIEditor.szPressDownName = "Edit_SC_PosX"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = 1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_PosUp", "λ�ã�����", "",
	function()
		UIEditor.ModifyPosOrSize(-1, "Edit_SC_PosY", true)
		UIEditor.szPressDownName = "Edit_SC_PosY"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = -1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_PosDown", "λ�ã�����", "",
	function()
		UIEditor.ModifyPosOrSize(1, "Edit_SC_PosY", true)
		UIEditor.szPressDownName = "Edit_SC_PosY"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = 1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_SizeWLeft", "�ߴ硤���ȣ�����", "",
	function()
		UIEditor.ModifyPosOrSize(1, "Edit_SC_SizeW", true)
		UIEditor.szPressDownName = "Edit_SC_SizeW"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = 1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_SizeWRight", "�ߴ硤���ȣ��p��", "",
	function()
		UIEditor.ModifyPosOrSize(-1, "Edit_SC_SizeW", true)
		UIEditor.szPressDownName = "Edit_SC_SizeW"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = -1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_SizeHDown", "�ߴ硤�߶ȣ�����", "",
	function()
		UIEditor.ModifyPosOrSize(1, "Edit_SC_SizeH", true)
		UIEditor.szPressDownName = "Edit_SC_SizeH"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = 1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)

Hotkey.AddBinding("UIEditor_SizeHUp", "�ߴ硤�߶ȣ��p��", "",
	function()
		UIEditor.ModifyPosOrSize(-1, "Edit_SC_SizeH", true)
		UIEditor.szPressDownName = "Edit_SC_SizeH"
		UIEditor.nPressDownFrame = 10
		UIEditor.nPressDownValue = -1
	end,
	function()
		if UIEditor.szPressDownName ~= "" then
			UIEditor.RecordPosOrSize()

			UIEditor.szPressDownName = ""
			UIEditor.nPressDownFrame = 0
			UIEditor.nPressDownValue = 0
		end
	end)
