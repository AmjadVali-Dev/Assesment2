codeunit 50321 "All Teacher Export"
{
    procedure CreateAllTeacherJson(): Text
    var
        TeacherHeaderRec: Record "Teacher Header";
        TeacherLineRec: Record "Teacher Line";
        JsonRoot: JsonObject;
        HeaderListArray: JsonArray;
        HeaderJson: JsonObject;
        LineJson: JsonObject;
        LineArray: JsonArray;
    begin
        TeacherHeaderRec.SetRange("Document Type", TeacherHeaderRec."Document Type"::Assignment);
        if TeacherHeaderRec.FindSet() then
            repeat
                Clear(HeaderJson);
                Clear(LineArray);
                HeaderJson.Add('Document Type', Format(TeacherHeaderRec."Document Type"));
                HeaderJson.Add('No', TeacherHeaderRec."No.");
                HeaderJson.Add('Teacher No', TeacherHeaderRec."Teacher No.");
                HeaderJson.Add('Teacher Name', TeacherHeaderRec."Teacher Name");
                HeaderJson.Add('Assainment Date', TeacherHeaderRec."Assainment Date");
                HeaderJson.Add('Department', TeacherHeaderRec.Department);
                HeaderJson.Add('Total Hours', TeacherHeaderRec."Total Hours ");
                HeaderJson.Add('Status', Format(TeacherHeaderRec.Status));
                HeaderJson.Add('Posting Date', TeacherHeaderRec."Posting Date");
                HeaderJson.Add('Description', TeacherHeaderRec.Description);
                HeaderJson.Add('Approval Status', Format(TeacherHeaderRec."Approval Status"));
                HeaderJson.Add('Created By', TeacherHeaderRec."Created By");
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
                        LineArray.Add(LineJson);
                    until TeacherLineRec.Next() = 0;

                HeaderJson.Add('Lines', LineArray);
                HeaderListArray.Add(HeaderJson);

            until TeacherHeaderRec.Next() = 0;

        JsonRoot.Add('Status', 'Success');
        JsonRoot.Add('Message', 'All Teacher Records Exported');
        JsonRoot.Add('Data', HeaderListArray);

        exit(Format(JsonRoot));
    end;


    procedure DownloadJson(JsonText: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        FileName: Text;
        InStr: InStream;
    begin
        FileName := 'All_Teacher_Records.json';

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText(JsonText);
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;




    procedure ImportTeacherFromJson(JsonText: Text)
    var
        RootJson: Codeunit "JSON Management";
        HeadersJson: Codeunit "JSON Management";
        HeaderObjJson: Codeunit "JSON Management";

        LinesJson: Codeunit "JSON Management";
        LineObjJson: Codeunit "JSON Management";

        HeaderTxt: Text;
        LineTxt: Text;

        TeacherHeaderRec: Record "Teacher Header";
        TeacherLineRec: Record "Teacher Line";

        i: Integer;
        j: Integer;

        DocTypeL: Text;
        NoL: Text;
        TeacherNoL: Text;
        TeacherNameL: Text;
        DeptL: Text;
        TotalHoursL: Text;
        PostingDateL: Text;
        DescriptionL: Text;
        Assainment_DateL: Text;
        StatusL: Text;
        Approved_ByL: Text;
        Approved_OnL: Text;
        CreatedByL: Text;

        LineNoL: Text;
        SubCodeL: Text;
        SubNameL: Text;
        HoursL: Text;
        ClassDateL: Text;
        Room_NoL: Text;
        RemarksL: Text;
    begin
        RootJson.InitializeObject(JsonText);

        if RootJson.GetArrayPropertyValueAsStringByName('Data', HeaderTxt) then begin

            HeadersJson.InitializeCollection(HeaderTxt);
            for i := 0 to HeadersJson.GetCollectionCount() - 1 do begin
                HeadersJson.GetObjectFromCollectionByIndex(HeaderTxt, i);

                HeaderObjJson.InitializeObject(HeaderTxt);
                TeacherHeaderRec.Init();
                HeaderObjJson.GetStringPropertyValueByName('Document Type', DocTypeL);
                Evaluate(TeacherHeaderRec."Document Type", DocTypeL);
                HeaderObjJson.GetStringPropertyValueByName('No', NoL);
                TeacherHeaderRec."No." := NoL;
                HeaderObjJson.GetStringPropertyValueByName('Teacher No', TeacherNoL);
                TeacherHeaderRec."Teacher No." := TeacherNoL;
                HeaderObjJson.GetStringPropertyValueByName('Teacher Name', TeacherNameL);
                TeacherHeaderRec."Teacher Name" := TeacherNameL;
                HeaderObjJson.GetStringPropertyValueByName('Assainment Date', Assainment_DateL);
                Evaluate(TeacherHeaderRec."Assainment Date", Assainment_DateL);
                HeaderObjJson.GetStringPropertyValueByName('Description', DescriptionL);
                TeacherHeaderRec.Description := DescriptionL;
                HeaderObjJson.GetStringPropertyValueByName('Status', StatusL);
                Evaluate(TeacherHeaderRec.Status, StatusL);
                HeaderObjJson.GetStringPropertyValueByName('Department', DeptL);
                TeacherHeaderRec.Department := DeptL;
                HeaderObjJson.GetStringPropertyValueByName('Total Hours', TotalHoursL);
                Evaluate(TeacherHeaderRec."Total Hours ", TotalHoursL);
                HeaderObjJson.GetStringPropertyValueByName('Posting Date', PostingDateL);
                Evaluate(TeacherHeaderRec."Posting Date", PostingDateL);
                HeaderObjJson.GetStringPropertyValueByName('Created By', CreatedByL);
                TeacherHeaderRec."Created By" := CreatedByL;
                HeaderObjJson.GetStringPropertyValueByName('Approved On', Approved_OnL);
                Evaluate(TeacherHeaderRec."Approved On", Approved_OnL);
                HeaderObjJson.GetStringPropertyValueByName('Approved By', Approved_ByL);
                TeacherHeaderRec."Approved By" := Approved_ByL;
                TeacherHeaderRec.Insert(true);

                if HeaderObjJson.GetArrayPropertyValueAsStringByName('Lines', LineTxt) then begin
                    LinesJson.InitializeCollection(LineTxt);

                    for j := 0 to LinesJson.GetCollectionCount() - 1 do begin
                        LinesJson.GetObjectFromCollectionByIndex(LineTxt, j);
                        LineObjJson.InitializeObject(LineTxt);

                        TeacherLineRec.Init();
                        TeacherLineRec."Document Type" := TeacherHeaderRec."Document Type";
                        TeacherLineRec."Document No." := TeacherHeaderRec."No.";
                        LineObjJson.GetStringPropertyValueByName('Line No', LineNoL);
                        Evaluate(TeacherLineRec."Line No.", LineNoL);
                        LineObjJson.GetStringPropertyValueByName('Subject Code', SubCodeL);
                        TeacherLineRec."Subject Code" := SubCodeL;
                        LineObjJson.GetStringPropertyValueByName('Subject Name', SubNameL);
                        TeacherLineRec."Subject Name" := SubNameL;
                        LineObjJson.GetStringPropertyValueByName('Hours Assained', HoursL);
                        Evaluate(TeacherLineRec."Hours Assained", HoursL);
                        LineObjJson.GetStringPropertyValueByName('Class Date', ClassDateL);
                        Evaluate(TeacherLineRec."Class Date", ClassDateL);
                        LineObjJson.GetStringPropertyValueByName('Room No', Room_NoL);
                        TeacherLineRec."Room No." := Room_NoL;
                        LineObjJson.GetStringPropertyValueByName('Remarks', RemarksL);
                        TeacherLineRec.Remarks := RemarksL;
                        TeacherLineRec.Insert(true);
                    end;
                end;
            end;
            Message('All Teacher Records Imported Successfully!');
        end else
            Error('Invalid JSON: Data array not found.');
    end;
}

