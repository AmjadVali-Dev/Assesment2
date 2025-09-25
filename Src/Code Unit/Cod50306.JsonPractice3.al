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


}
