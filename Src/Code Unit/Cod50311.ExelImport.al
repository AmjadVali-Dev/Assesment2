codeunit 50311 "Exel Import"
{
    // procedure CreateDailogueBox()
    // var
    //     FileManagementRec: Codeunit "File Management";
    //     InstreamL: InStream;
    //     FileL: Text[50];
    // begin
    //     UploadIntoStream(Dailoguetitle, '', '', FileL, InstreamL);
    //     if FileL <> '' then begin
    //         FileNameG := FileManagementRec.GetFileName(FileL);
    //         SheetNameG := TempBufferG.SelectSheetsNameStream(InstreamL);
    //     end;
    //     TempBufferG.Reset();
    //     TempBufferG.DeleteAll();
    //     TempBufferG.OpenBookStream(InstreamL, SheetNameG);
    //     TempBufferG.ReadSheet();
    // end;

    // procedure Import_Exel()
    // var
    //     EmployeRec: Record "Employe DetailssA";
    //     RowNoL: Integer;
    //     ColNoL: Integer;
    //     MaxRowNoL: Integer;
    // begin
    //     Clear(EmployeRec);
    //     Clear(RowNoL);
    //     Clear(ColNoL);
    //     Clear(MaxRowNoL);
    //     if TempBufferG.FindLast() then
    //         MaxRowNoL := TempBufferG."Row No.";
    //     for RowNoL := 2 to MaxRowNoL do begin
    //         EmployeRec.Init();
    //         Evaluate(EmployeRec.EmpID, GetValue(RowNoL, 1));
    //         Evaluate(EmployeRec.EmpName, GetValue(RowNoL, 2));
    //         Evaluate(EmployeRec.Department, GetValue(RowNoL, 3));
    //         Evaluate(EmployeRec.Salary, GetValue(RowNoL, 4));
    //         Evaluate(EmployeRec.JoiningDate, GetValue(RowNoL, 5));
    //         Evaluate(EmployeRec.Designation, GetValue(RowNoL, 6));
    //         Evaluate(EmployeRec.Bonus, GetValue(RowNoL, 7));
    //         EmployeRec.Insert()
    //     end;
    //     Message('The exel Successfully imported');
    // end;

    // procedure GetValue(RowNo: Integer; ColNo: Integer): Text
    // begin
    //     if TempBufferG.Get(RowNo, ColNo) then
    //         exit(TempBufferG."Cell Value as Text")
    //     else
    //         exit('');
    // end;


    procedure CreateDailogueBox()
    var
        FileL: Text[50];
        FileManL: Codeunit "File Management";
        InstreamL: InStream;
    begin
        UploadIntoStream(Dailoguetitle, '', '', FileL, InstreamL);
        if FileL <> '' then begin
            FileNameG := FileManL.GetFileName(FileL);
            SheetNameG := TempBufferG.SelectSheetsNameStream(InstreamL);
        end;
        TempBufferG.Reset();
        TempBufferG.DeleteAll();
        TempBufferG.OpenBookStream(InstreamL, SheetNameG);
        TempBufferG.ReadSheet();
    end;

    procedure Import_Exel()
    var
        EmployeRec: Record "Employe DetailssA";
        RowNoL: Integer;
        ColNoL: Integer;
        MaxRowNoL: Integer;
    begin
        Clear(EmployeRec);
        Clear(RowNoL);
        Clear(ColNoL);
        Clear(MaxRowNoL);
        if TempBufferG.FindLast() then
            MaxRowNoL := TempBufferG."Row No.";
        for RowNoL := 2 to MaxRowNoL do begin
            EmployeRec.Init();
            Evaluate(EmployeRec.EmpID, GetValue(RowNoL, 1));
            Evaluate(EmployeRec.EmpName, GetValue(RowNoL, 2));
            Evaluate(EmployeRec.Department, GetValue(RowNoL, 3));
            Evaluate(EmployeRec.Salary, GetValue(RowNoL, 4));
            Evaluate(EmployeRec.JoiningDate, GetValue(RowNoL, 5));
            Evaluate(EmployeRec.Designation, GetValue(RowNoL, 6));
            Evaluate(EmployeRec.Bonus, GetValue(RowNoL, 7));
            EmployeRec.Insert();
        end;
        Message('The Employee inserted Successfully');
    end;

    procedure Getvalue(RowNo: Integer; ColNo: Integer): Text
    begin
        if TempBufferG.Get(RowNo, ColNo) then begin
            exit(TempBufferG."Cell Value as Text");
        end
        else
            exit('');
    end;

    var
        TempBufferG: Record "Excel Buffer" temporary;
        Dailoguetitle: Label 'Please Insert the Exel';
        SheetNameG: Text[50];
        FileNameG: Text[50];
}
