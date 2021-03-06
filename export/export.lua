function export_OnLoad()
	SlashCmdList["export"] = export_SlashCommand
	SLASH_export1 = "/export"
end


function export_SlashCommand(msg)
	if msg == "csv" then
		export_csv()
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - |cff9482c9csv|r: export as csv")
	end
end

function export_OnEvent()
end

function export_csv()
	exportDB = {}
	exportCSV = ""
	delimeter = ","

	for i = 1, GetNumGuildMembers(true) do
		local name, _, _, _, class, _, note, officernote, _, _ = GetGuildRosterInfo(i)
		
		exportDB[i] = {}	
		exportDB[i].name = name
		exportDB[i].note = string.gsub(note,delimeter,";")
		exportDB[i].officernote = string.gsub(officernote,delimeter,";")
	end
	
	guild = GetGuildInfo("player")
--	exportDB_text = "export for " .. guild .. " at " .. date("%y-%m-%d %H:%M:%S") .. ",,\r\n" .. "name,note,officernote\r\n"
	exportDB_text = "name".. delimeter .. "note" .. delimeter .. "officernote" .. "\r"
	exportCSV = "name".. delimeter .. "note" .. delimeter .. "officernote" .. "\n"
	
	table.sort(exportDB, function(a,b) return a.name < b.name end)
		
	for i in exportDB do
		exportDB_text = exportDB_text .. exportDB[i].name .. delimeter .. exportDB[i].note .. delimeter .. exportDB[i].officernote
		exportCSV = exportCSV .. exportDB[i].name .. delimeter .. exportDB[i].note .. delimeter .. exportDB[i].officernote
	end
	
	export_ExportFrameEditBox1:SetFont("Fonts\\FRIZQT__.TTF", "8")
	export_ExportFrameEditBox1Left:Hide()
	export_ExportFrameEditBox1Middle:Hide()
	export_ExportFrameEditBox1Right:Hide()
	export_ExportFrameEditBox1:SetText(exportDB_text)
		
	ShowUIPanel(export_ExportFrame, 1)
	
	DEFAULT_CHAT_FRAME:AddMessage("exported to WTF\\Account\\ACCOUNTNAME\\SavedVariables\\exportDB.lua", 1, 1, 0)
	DEFAULT_CHAT_FRAME:AddMessage("Reload UI or Logout to save the file", 1, 1, 0)
end
