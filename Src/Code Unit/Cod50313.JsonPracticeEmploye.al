codeunit 50313 "Json Practice Employe"
{
    procedure ExportEmployeeDetails(): Text
    var
        JsonObject: JsonObject;
        HeaderJsonObject: JsonObject;
        JsonArray: JsonArray;
        EmployeeRec: Record "Employe DetailssA";
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if EmployeeRec.FindSet() then begin
            repeat
                Clear(HeaderJsonObject);
                HeaderJsonObject.Add('EmpID', EmployeeRec.EmpID);
                HeaderJsonObject.Add('EmpName', EmployeeRec.EmpName);
                HeaderJsonObject.Add('Department', EmployeeRec.Department);
                HeaderJsonObject.Add('Salary', EmployeeRec.Salary);
                HeaderJsonObject.Add('JoiningDate', EmployeeRec.JoiningDate);
                HeaderJsonObject.Add('Bonus', EmployeeRec.Bonus);
                HeaderJsonObject.Add('Designation', EmployeeRec.Designation);
                JsonArray.Add(HeaderJsonObject);
            Until EmployeeRec.Next() = 0;
        end;
        JsonObject.Add('Status', 'Success');
        JsonObject.Add('Message', 'Employee data retrieved successfully');
        JsonObject.Add('Data', JsonArray);
        FileName := 'Employee.json';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(Format(JsonObject));
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        DownloadFromStream(InStr, '', '', '', FileName);
        exit(Format(JsonObject));
    end;

    procedure InsertEmployeeFromJson(JsonObjectData: Text[2048])
    var
        EmployeeRec: Record "Employe DetailssA";
        ObjectJSONMgnt: Codeunit "JSON Management";
        EmployeeJsonMgnt: Codeunit "JSON Management";
        ObjectJSONMgntL: Codeunit "JSON Management";
        ArrayTxt: Text;
        EmployeeTxt: Text;
        i: Integer;
        EmpIDL: Text;
        EmpNameL: Text;
        DepartmentL: Text;
        SalaryL: Text;
        JoiningDateL: Text;
        BonusL: Text;
        DesignationL: Text;
    begin
        ObjectJSONMgnt.InitializeObject(JsonObjectData);
        if ObjectJSONMgnt.GetArrayPropertyValueAsStringByName('Data', ArrayTxt) then begin
            EmployeeJsonMgnt.InitializeCollection(ArrayTxt);
            for i := 0 to EmployeeJsonMgnt.GetCollectionCount() - 1 do begin
                EmployeeJsonMgnt.GetObjectFromCollectionByIndex(EmployeeTxt, i);
                ObjectJSONMgnt.InitializeObject(EmployeeTxt);
                EmployeeRec.Init();
                ObjectJSONMgnt.GetStringPropertyValueByName('EmpID', EmpIDL);
                EmployeeRec.EmpID := EmpIDL;
                ObjectJSONMgnt.GetStringPropertyValueByName('EmpName', EmpNameL);
                EmployeeRec.EmpName := EmpNameL;
                ObjectJSONMgnt.GetStringPropertyValueByName('Department', DepartmentL);
                EmployeeRec.Department := DepartmentL;
                ObjectJSONMgnt.GetStringPropertyValueByName('Salary', SalaryL);
                Evaluate(EmployeeRec.Salary, SalaryL);
                ObjectJSONMgnt.GetStringPropertyValueByName('JoiningDate', JoiningDateL);
                Evaluate(EmployeeRec.JoiningDate, JoiningDateL);
                ObjectJSONMgnt.GetStringPropertyValueByName('Bonus', BonusL);
                Evaluate(EmployeeRec.Bonus, BonusL);
                ObjectJSONMgnt.GetStringPropertyValueByName('Designation', DesignationL);
                EmployeeRec.Designation := DesignationL;
                EmployeeRec.Insert();
            end;
        end;
        Message('Employee JSON import completed successfully!');
    end;


    // procedure InsertEmployeeFromJson(JsonObjectData: Text[2048])
    // var
    //     EmployeeRec: Record "Employe DetailssA";
    //     ObjectManagement: Codeunit "JSON Management";
    //     EmployeeManagement: Codeunit "JSON Management";
    //     JsonText: Text;
    //     ArrayText: Text;
    //     i: Integer;
    //     EmpIDL: Text;
    //     EmpNameL: Text;
    //     DepartmentL: Text;
    //     SalaryL: Text;
    //     JoiningDateL: Text;
    //     BonusL: Text;
    //     DesignationL: Text;
    // begin
    //     ObjectManagement.InitializeObject(JsonObjectData);
    //     if ObjectManagement.GetArrayPropertyValueAsStringByName('Data', ArrayText) then begin
    //         EmployeeManagement.InitializeCollection(ArrayText);
    //         for i := 0 to EmployeeManagement.GetCollectionCount() - 1 do begin
    //             EmployeeManagement.GetObjectFromCollectionByIndex(JsonText, i);
    //             ObjectManagement.InitializeObject(JsonText);
    //             EmployeeRec.Init();
    //             ObjectManagement.GetArrayPropertyValueAsStringByName('EmpID', EmpIDL);
    //             EmployeeRec.EmpID := EmpIDL;
    //             ObjectManagement.GetStringPropertyValueByName('EmpName', EmpNameL);
    //             EmployeeRec.EmpName := EmpNameL;
    //             ObjectManagement.GetStringPropertyValueByName('Department', DepartmentL);
    //             EmployeeRec.Department := DepartmentL;
    //             ObjectManagement.GetStringPropertyValueByName('Salary', SalaryL);
    //             Evaluate(EmployeeRec.Salary, SalaryL);
    //             ObjectManagement.GetStringPropertyValueByName('JoiningDate', JoiningDateL);
    //             Evaluate(EmployeeRec.JoiningDate, JoiningDateL);
    //             ObjectManagement.GetStringPropertyValueByName('Bonus', BonusL);
    //             Evaluate(EmployeeRec.Bonus, BonusL);
    //             ObjectManagement.GetStringPropertyValueByName('Designation', DesignationL);
    //             EmployeeRec.Designation := DesignationL;
    //             EmployeeRec.Insert();
    //         end;
    //     end;
    //     Message('The Data SuccessFully Inserted');
    // end;
}
