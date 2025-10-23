codeunit 50309 "Employe DetailsJson"
{
    procedure GetAllEmployeesAsJSON(): Text
    var
        EmpRec: Record "Employe DetailssA";
        JsonObj: JsonObject;
        JsonArray: JsonArray;
        RecRefL: RecordRef;
        FieldRefL: FieldRef;
        i: Integer;
    begin
        if EmpRec.FindSet() then begin
            repeat
                Clear(JsonObj);
                Clear(RecRefL);
                Clear(FieldRefL);
                RecRefL.GetTable(EmpRec);
                for i := 1 to RecRefL.FieldCount do begin
                    FieldRefL := RecRefL.FieldIndex(i);
                    JsonObj.Add(FieldRefL.Name, Format(FieldRefL.Value));
                end;
                JsonArray.Add(JsonObj);
            until EmpRec.Next() = 0;
        end;
        Message(Format(JsonArray));
        exit(Format(JsonArray));
    end;
}

