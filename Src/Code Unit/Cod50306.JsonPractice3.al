codeunit 50306 "Json Practice 3"
{
    procedure CreateJsonExample()
    var
        JsonObj: JsonObject;
        JsonArray: JsonArray;
        JsonChildObj: JsonObject;
        JsonText: Text;
    begin
        // 1. String
        JsonObj.Add('name', 'Ajju');

        // 2. Number
        JsonObj.Add('age', 23);

        // 3. Boolean
        JsonObj.Add('isStudent', true);

        // 4. Null
        JsonObj.Add('nickname', '');

        // 5. Object (nested)
        JsonChildObj.Add('title', 'Traffic Control');
        JsonChildObj.Add('status', 'In Progress');
        JsonObj.Add('project', JsonChildObj);

        // 6. Array
        JsonArray.Add('Java');
        JsonArray.Add('Python');
        JsonArray.Add('AL');
        JsonObj.Add('skills', JsonArray);

        // Convert to text and show
        JsonObj.WriteTo(JsonText);
        Message(JsonText);
    end;

    procedure JsonManagement(JsonText: Text)
    var
        JsonManagement: Codeunit "JSON Management";
        objectJsonObject: Codeunit "JSON Management";
        ArrayjsonObject: Codeunit "JSON Management";
        JsontextRec: Text;
        CustName: Text;
        CustNo: Text;
        CustAddress: Text;
        i: Integer;
        ShipToJsonText: Text;
        ShipCode: Text;
        ShipAddress: Text;
        ShipCity: Text;

    begin
        JsonManagement.InitializeObject(JsonText);
        if JsonManagement.GetArrayPropertyValueAsStringByName('Data', JsontextRec) then
            objectJsonObject.InitializeObject(JsontextRec);

        objectJsonObject.GetStringPropertyValueByName('No', CustNo);
        objectJsonObject.GetStringPropertyValueByName('Name', CustName);
        objectJsonObject.GetStringPropertyValueByName('Address', CustAddress);
        Message('Customer No: %1 Name: %2 Address: %3', CustNo, CustName, CustAddress);

        if objectJsonObject.GetArrayPropertyValueAsStringByName('ShipToAddresses', JsontextRec) then
            ArrayjsonObject.InitializeCollection(JsontextRec);

        for i := 0 to ArrayjsonObject.GetCollectionCount() - 1 do begin
            ArrayjsonObject.GetObjectFromCollectionByIndex(ShipToJsonText, i);
            objectJsonObject.InitializeObject(ShipToJsonText);

            objectJsonObject.GetStringPropertyValueByName('Code', ShipCode);
            objectJsonObject.GetStringPropertyValueByName('Address1', ShipAddress);
            objectJsonObject.GetStringPropertyValueByName('City1', ShipCity);

            Message('Ship-to: %1, %2, %3', ShipCode, ShipAddress, ShipCity);
        end;

    end;

    procedure GenerateAppJson()
    var
        JsonObj: JsonObject;
        JsonArray: JsonArray;
        RangeObj: JsonObject;
        ResourcePolicyObj: JsonObject;
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        // Main JSON properties
        JsonObj.Add('id', 'ee873b04-3f0e-45e0-b29');
        JsonObj.Add('name', 'ALExammm');
        JsonObj.Add('publisher', 'Default');
        JsonObj.Add('version', '1.');
        JsonObj.Add('brief', '');
        JsonObj.Add('description', '');
        JsonObj.Add('privacyStatement', '');
        JsonObj.Add('EULA', '');
        JsonObj.Add('help', '');
        JsonObj.Add('url', '');
        JsonObj.Add('logo', '');

        // Platform and app version
        JsonObj.Add('platform', '1.0.0.0');
        JsonObj.Add('application', '25.0.0.0');

        // idRanges as array of object
        Clear(RangeObj);
        RangeObj.Add('from', 50311);
        RangeObj.Add('to', 50400);
        Clear(JsonArray);
        JsonArray.Add(RangeObj);
        JsonObj.Add('idRanges', JsonArray);

        // resourceExposurePolicy object
        Clear(ResourcePolicyObj);
        ResourcePolicyObj.Add('allowDebugging', false);
        ResourcePolicyObj.Add('allowDownloadingSource', false);
        ResourcePolicyObj.Add('includeSourceInSymbolFile', false);
        ResourcePolicyObj.Add('applyToDevExtension', false);
        JsonObj.Add('resourceExposurePolicy', ResourcePolicyObj);

        // Runtime
        JsonObj.Add('runtime', '14.0');

        // Features array
        Clear(JsonArray);
        JsonArray.Add('NoImplicitWith');
        JsonObj.Add('features', JsonArray);

        // Save as file
        FileName := 'app11.json';
        // First I need To Create A Outstream And I need To Write It..
        //"Temp Blob" is a system codeunit in Business Central that acts as a temporary in-memory BLOB storage.
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(Format(JsonObj));
        //Now I need To Read The data Using Instream
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        //It IS For How To Download 
        DownloadFromStream(InStr, '', '', '', FileName);
        Message('app.json file generated successfully!');
    end;



}
