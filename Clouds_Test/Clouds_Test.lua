--ע��������Ĭ�ϲ�����Ҫ�ֶ������
--�޸�function Clouds_Test.test()������
--Ȼ���½��� /Clouds_Test
--�����ļ���ǵ�ʹ�ú� /ReloadUI �����ݼ�������
--ʹ�ú� /SwitchDebug �򿪹رյ�����Ϣ
--������˻�������Ӧ��ر�����������ԣ������Ǻ��ӣ�
--��ϸ�Ķ�ע�ͣ�������������������

Clouds_Test = {
	version = "0.1",
	DebugOn = false,--��Ϊtrueʱ����lua���󱨾�����������������lua��������ʹ��
}
--һ�㶼��Ѳ�����г��˱���(local)�ı����������������ж���������һ��table�﷽�����
--���table��������ö�һ�޶�

function Clouds_Test.Msg(szMsg)
	OutputMessage("MSG_SYS","[Test]"..szMsg:gsub("\n","").."\n")
end
--e.g. Clouds_Test.Msg("�����ǵ�����Ϣ version:"..Clouds_Test.version)

function Clouds_Test.Msgs(szMsg)
	OutputMessage("MSG_SYS","[Test]"..szMsg.."\n")
end

function Clouds_Test.test()
	local me = GetClientPlayer()
	Clouds_Test.Msg("��ӭ["..me.szName.."]ʹ�����Ƶ�����")

	--TODO: your code added here
	--����: �������������
	--1.���Լ���Ŀ���ְҵ�ǡ����֡�ʱ���ĶԷ�����ʦ��Ҫ[��������]ô~��
	--2.�����ڶ�����˵������ͷ�������Ӷ���ô�ۿ�����[���ң�]����
	--����������á���ݶ���������һ��������������ɿ��Ե㿪�鿴���Ե���ʽ
	--���ҡ��滻���ҵ����֣���������һ�������ӵ���ʽ

end

function Clouds_Test.timer()
	--Clouds_Test.Msg("timer @ "..GetLogicFrameCount())
	--�������ÿ�뱻����һ�Σ���������԰�����һ��ע�͵���ˢ������Ը���ʱ׼��CSA~��
end

function Clouds_Test.Reload()
	Clouds_Test.Msg("Reloading@"..GetLogicFrameCount())
	ReloadUIAddon()
end

Hotkey.AddBinding("Test_Reload", "��������","���Ե�����",function()
	Clouds_Test.Reload()
end,nil)
Hotkey.Set("Test_Reload",1,458944,true,true,true)
--�������������ȼ����õģ����������xlsx��UI�ӿ�һ����ע���ж�����
--Ĭ���ȼ���Ctrl+Shift+Alt+Oem3������1�Ա��Ǹ���
--����ʹ������ȼ�������ʹ�ú� /script Clouds_Test.Reload() �� /ReloadUI
--����ʾ���Կ���������ǰ/���������
--����ȼ�������˵������ʧ�ܣ��﷨�������������ʱ����

local tErr={}
--����Ǳ��ر����������˱������������ִ�������������㷨����һ���ķ�ˢ������
function Clouds_Test.ShowError(szErr)
	if not Clouds_Test.DebugOn then
		return
	end
	szErr = szErr or arg0
	local count=tErr[szErr] or 0
	tErr[szErr]=count+1
	if count<10 or (count<1000 and count%100==0) or count%1000==0 then
		Clouds_Test.Msgs(szErr)
	end
end

function Clouds_Test.ChangeDebug()
	Clouds_Test.DebugOn =  not Clouds_Test.DebugOn
	--not nil == true
	--not Clouds_Test == false
	Clouds_Test.Msg(("������ [%s]"):format(Clouds_Test.DebugOn and "��" or "��"))
	--����������д�� string.format("������ [%s] @ %d","��",GetLogicFrameCount())
	--��printf�﷨����
end

AppendCommand("Clouds_Test", Clouds_Test.test)
AppendCommand("ReloadUI", Clouds_Test.Reload)
AppendCommand("SwitchDebug", Clouds_Test.ChangeDebug)
--������������������
--������������ /Clouds_Test ������ Clouds_Test.test()
--��������ͬ��(������ /roll)
--������������xlsx��ȫ�ֽӿ��ҵ�
--��������������޸ģ�ע�������������ͻ��

--������������һ������Ǵ�����ص�
--�ȿ�����Сѩ�ģ�һ������������
function Clouds_Test.OnFrameCreate()
	this:RegisterEvent("CALL_LUA_ERROR")
end

function Clouds_Test.OnFrameBreathe()
	if GetLogicFrameCount()%16==0 then
		Clouds_Test.timer()
	end
end

function Clouds_Test.OnEvent(event)
	if event=="CALL_LUA_ERROR" then
		Clouds_Test.ShowError(arg0)
	end
end

Wnd.OpenWindow("interface\\Clouds_Test\\Clouds_Test.ini","Clouds_Test")

Clouds_Test.Msg("�������")
--�����������м�����ɲ���������
--��Ȼ�����﷨����
--�﷨�������ͨ��SciTe�����а�ť������
