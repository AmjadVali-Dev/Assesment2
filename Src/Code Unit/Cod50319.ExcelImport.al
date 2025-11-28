codeunit 50319 "Excel Import"
{
    procedure UploadStream()
    var
        FilemgtRec: Codeunit "File Management";
        instreamL: InStream;
        FileL: Text;
    begin
        UploadIntoStream(Label, '', '', FileL, instreamL);
        if FileL <> '' then begin
            FileG := FilemgtRec.GetFileName(FileL);
            SheetNameG := TempbufferExcel.SelectSheetsNameStream(instreamL);
        end;
        TempbufferExcel.Reset();
        TempbufferExcel.DeleteAll();
        TempbufferExcel.OpenBookStream(instreamL, SheetNameG);
        TempbufferExcel.ReadSheet();
    end;

    procedure Import_Excel()
    var
        TeacherHeaderRec: Record "Teacher Header";
        RowNo: Integer;
        ColNo: Integer;
        MaxRowNo: Integer;
    begin
        Clear(TeacherHeaderRec);
        Clear(RowNo);
        Clear(ColNo);
        Clear(MaxRowNo);
        if TempbufferExcel.FindLast() then
            MaxRowNo := TempbufferExcel."Row No.";
        for RowNo := 2 to MaxRowNo do begin
            TeacherHeaderRec.Init();
            Evaluate(TeacherHeaderRec."Document Type", Getvalue(RowNo, 1));
            Evaluate(TeacherHeaderRec."No.", Getvalue(RowNo, 2));
            Evaluate(TeacherHeaderRec."Teacher No.", Getvalue(RowNo, 3));
            Evaluate(TeacherHeaderRec."Teacher Name", Getvalue(RowNo, 4));
            Evaluate(TeacherHeaderRec."Assainment Date", Getvalue(RowNo, 5));
            Evaluate(TeacherHeaderRec.Department, Getvalue(RowNo, 6));
            Evaluate(TeacherHeaderRec."Total Hours ", Getvalue(RowNo, 7));
            Evaluate(TeacherHeaderRec.Status, Getvalue(RowNo, 8));
            Evaluate(TeacherHeaderRec.Description, Getvalue(RowNo, 9));
            Evaluate(TeacherHeaderRec."Posting Date", Getvalue(RowNo, 10));
            Evaluate(TeacherHeaderRec."Created By", Getvalue(RowNo, 11));
            TeacherHeaderRec.Insert(true);
        end;
        Message('The Teacher Records inserted Successfully');
    end;

    procedure Getvalue(Rownum: Integer; ColNum: Integer): Text

    begin
        if TempbufferExcel.Get(Rownum, ColNum) then
            exit(TempbufferExcel."Cell Value as Text")
        else
            exit('');
    end;

    var
        TempbufferExcel: Record "Excel Buffer" temporary;
        Label: Label 'Please Insert Your Excel';
        FileG: Text;
        SheetNameG: Text;
}
