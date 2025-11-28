codeunit 50318 "Excel Export"
{
    procedure Excel_Export()
    var
        TeacherHeader: Record "Teacher Header";
        TempBufferRec: Record "Excel Buffer" temporary;
    begin
        TempBufferRec.Reset();
        TempBufferRec.DeleteAll();
        TempBufferRec.NewRow();
        TempBufferRec.AddColumn('Document Type', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('No.', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Teacher No.', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Teacher Name', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Assainment Date', false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
        TempBufferRec.AddColumn('Department', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Total Hours', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Status', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Description', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Posting Date', false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
        TempBufferRec.AddColumn('Created By', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        Clear(TeacherHeader);
        if TeacherHeader.FindSet() then begin
            repeat
                TempBufferRec.NewRow();
                TempBufferRec.AddColumn(TeacherHeader."Document Type", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."No.", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."Teacher No.", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."Teacher Name", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."Assainment Date", false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
                TempBufferRec.AddColumn(TeacherHeader.Department, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."Total Hours ", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader.Status, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader.Description, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(TeacherHeader."Posting Date", false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
                TempBufferRec.AddColumn(TeacherHeader."Posting Date", false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
            until TeacherHeader.Next() = 0;
        end;
        TempBufferRec.CreateNewBook('Teacher Excel Export');
        TempBufferRec.WriteSheet('Sheet1', CompanyName, UserId);
        TempBufferRec.CloseBook();
        TempBufferRec.SetFriendlyFilename('Teacher Excel Export');
        TempBufferRec.OpenExcel();
    end;
}
