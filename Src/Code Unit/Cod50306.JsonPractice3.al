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


}
