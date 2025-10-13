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

    procedure InsertSalesOrder(JsonObjectData: Text[2048])
    var
        SalesHdrRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        ObjectJSONMgnt: Codeunit "JSON Management";
        SalesHdrMgnt: Codeunit "JSON Management";
        SalesLineMgnt: Codeunit "JSON Management";
        DateData: Date;
        Qty: Decimal;
        i: Integer;
        LineNo: Integer;
        ArrayTxt: Text;
        DataTxt: Text;
        SalesHdrTxt: Text;
        SalesLineTxt: Text;
    begin
        ObjectJSONMgnt.InitializeObject(JsonObjectData);
        if ObjectJSONMgnt.GetStringPropertyValueByName('', SalesHdrTxt) then begin
            SalesHdrMgnt.InitializeObject(SalesHdrTxt);
            SalesHdrRec.Init();
            SalesHdrRec."Document Type" := SalesHdrRec."Document Type"::Order;
            SalesHdrMgnt.GetStringPropertyValueByName('No.', DataTxt);
            SalesHdrRec."No." := DataTxt;
            SalesHdrMgnt.GetStringPropertyValueByName('Document Date', DataTxt);
            Evaluate(SalesHdrRec."Document Date", DataTxt);
            SalesHdrMgnt.GetStringPropertyValueByName('Sell-to Customer No.', DataTxt);
            SalesHdrRec.Validate("Sell-to Customer No.", DataTxt);
            SalesHdrRec.Insert();
            ObjectJSONMgnt.InitializeObject(SalesHdrTxt);
            if ObjectJSONMgnt.GetArrayPropertyValueAsStringByName('Lines', ArrayTxt) then begin
                SalesLineMgnt.InitializeCollection(ArrayTxt);
                for i := 0 to SalesLineMgnt.GetCollectionCount() - 1 do begin
                    SalesLineMgnt.GetObjectFromCollectionByIndex(SalesLineTxt, i);
                    ObjectJSONMgnt.InitializeObject(SalesLineTxt);
                    SalesLineRec.Init();
                    SalesLineRec."Document Type" := SalesHdrRec."Document Type";
                    SalesLineRec."Document No." := SalesHdrRec."No.";
                    SalesLineRec."Line No." := LineNo;
                    SalesLineRec.Type := SalesLineRec.Type::Item;
                    ObjectJSONMgnt.GetStringPropertyValueByName('ItemNo', DataTxt);
                    SalesLineRec.Validate("No.", DataTxt);
                    ObjectJSONMgnt.GetStringPropertyValueByName('Quantity', DataTxt);
                    if Evaluate(Qty, DataTxt) then
                        SalesLineRec.Validate(Quantity, Qty);
                    LineNo += 10000;
                    SalesLineRec.Insert();
                end;
            end;
        end;
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



}
