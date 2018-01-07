include("workshop_config.lua");

print("[WORKSHOP LINKER] Querying workshop collection:");

function TryLinkAddons(CollectionIDParam)
	print("[WORKSHOP LINKER] Requesting workshop collection. [" .. CollectionIDParam .. "] ");
	local PostFields = {};
	PostFields["collectioncount"] = "1";
	PostFields["publishedfileids[0]"] = CollectionIDParam;
	http.Post( "http://api.steampowered.com/ISteamRemoteStorage/GetCollectionDetails/V0001?format=json", PostFields, OnHTTPSuccess, OnHTTPFailure );
end

function OnHTTPSuccess( responseText, contentLength, responseHeaders, statusCode )

	file.Delete("workshoplinker/workshoplinker.txt");
	file.CreateDir( "workshoplinker/");
	file.Write("workshoplinker/workshoplinker.txt", ""); 
	print("[WORKSHOP LINKER] Success!");
	local CollectionTable = util.JSONToTable(responseText);
	for key,value in pairs(CollectionTable.response.collectiondetails[1].children) do
		resource.AddWorkshop( value.publishedfileid ) 
		file.Append("workshoplinker/workshoplinker.txt", value.publishedfileid .. "\n"); -- Save this shit to file because the HTTP module is not avalible when the server starts up >.<
		print("[WORKSHOP LINKER] Adding: " .. value.publishedfileid);
	end
	print("[WORKSHOP LINKER] Done!");
	timer.Stop( "workshoplinker" );

end

function OnHTTPFailure( errorMessage )
	print("[WORKSHOP LINKING ERROR] HTTP RESPONSE FAILED: " .. errorMessage);
end

-- Retry for the collection
timer.Create("workshoplinker", 5, 0, function()
	TryLinkAddons(CollectionID);
end);

file.CreateDir( "workshoplinker/");
-- Load our collection list from file
if(file.Exists("workshoplinker/workshoplinker.txt", "DATA")) then
	local CollectionData = file.Read( "workshoplinker/workshoplinker.txt", "DATA" )
	local CollectionTable = string.Split(CollectionData, "\n");
	for key, value in pairs(CollectionTable) do
		resource.AddWorkshop( value );
		print("[WORKSHOP LINKER] Adding from file: " .. value);
	end
end

TryLinkAddons(CollectionID);
