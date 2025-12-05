codeunit 50320 "Teacher Order Json Export"
{
    procedure CreateTeacherHeaderJson(TeacherHeaderRec: Record "Teacher Header"): Text
    var
        JsonArrayLines: JsonArray;
        HeaderJson: JsonObject;
        LineJson: JsonObject;
        JsonRoot: JsonObject;
        TeacherLineRec: Record "Teacher Line";
    begin
        HeaderJson.Add('Document Type', Format(TeacherHeaderRec."Document Type"::Assignment));
        HeaderJson.Add('No', TeacherHeaderRec."No.");
        HeaderJson.Add('Teacher No', TeacherHeaderRec."Teacher No.");
        HeaderJson.Add('Teacher Name', TeacherHeaderRec."Teacher Name");
        HeaderJson.Add('Assainment Date', TeacherHeaderRec."Assainment Date");
        HeaderJson.Add('Department', TeacherHeaderRec.Department);
        HeaderJson.Add('Total Hours', TeacherHeaderRec."Total Hours ");
        HeaderJson.Add('Status', Format(TeacherHeaderRec.Status));
        HeaderJson.Add('Posting Date', TeacherHeaderRec."Posting Date");
        HeaderJson.Add('Description', TeacherHeaderRec.Description);
        HeaderJson.Add('Created By', TeacherHeaderRec."Created By");
        HeaderJson.Add('Approval Status', Format(TeacherHeaderRec."Approval Status"));
        HeaderJson.Add('Approved By', TeacherHeaderRec."Approved By");
        HeaderJson.Add('Approved on', TeacherHeaderRec."Approved On");

        TeacherLineRec.SetRange("Document Type", TeacherHeaderRec."Document Type");
        TeacherLineRec.SetRange("Document No.", TeacherHeaderRec."No.");
        if TeacherLineRec.FindSet() then
            repeat
                Clear(LineJson);
                LineJson.Add('Line No', TeacherLineRec."Line No.");
                LineJson.Add('Subject Code', TeacherLineRec."Subject Code");
                LineJson.Add('Subject Name', TeacherLineRec."Subject Name");
                LineJson.Add('Hours Assained', TeacherLineRec."Hours Assained");
                LineJson.Add('Class Date', TeacherLineRec."Class Date");
                LineJson.Add('Room No', TeacherLineRec."Room No.");
                LineJson.Add('Remarks', TeacherLineRec.Remarks);
                JsonArrayLines.Add(LineJson);
            until TeacherLineRec.Next() = 0;

        HeaderJson.Add('Lines', JsonArrayLines);
        JsonRoot.Add('Status', 'Success');
        JsonRoot.Add('Message', 'Data Retrieved Successfully');
        JsonRoot.Add('Data', HeaderJson);
        exit(Format(JsonRoot));
    end;


    procedure DownloadJson(JsonText: Text)
    var
        Tempblob: Codeunit "Temp Blob";
        FileName: Text;
        OutStr: OutStream;
        InStr: InStream;
    begin
        FileName := 'Teacher Data.json';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;
}
