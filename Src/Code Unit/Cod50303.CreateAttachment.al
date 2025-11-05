codeunit 50303 "Create Attachment"
{
    procedure UploadDocumentToFactBox(CustomerRec: Record Customer)
    var
        DocumentMgnt: Record "Document Attachment";
        InstreamL: InStream;
        DialogText: Label 'Please Select a File';
        FromFileL: Text[100];
    begin
        if UploadIntoStream(DialogText, '', '', FromFileL, InstreamL) then begin
            DocumentMgnt.Init();
            DocumentMgnt."Table ID" := Database::Customer;
            DocumentMgnt."No." := CustomerRec."No.";
            DocumentMgnt."Line No." := 10000;
            DocumentMgnt."File Name" := FromFileL;
            DocumentMgnt."Attached Date" := CurrentDateTime;
            DocumentMgnt.User := UserId;
            DocumentMgnt.Insert();
            DocumentMgnt."Document Reference ID".ImportStream(InstreamL, FromFileL);
            DocumentMgnt.Modify();
        end;
    end;

    procedure DeleteAttachMent()
    var
        DocumentRec: Record "Document Attachment";
    begin
        if DocumentRec.FindSet() then begin
            repeat
                DocumentRec.Delete();
            until DocumentRec.Next() = 0;
        end;
    end;
}


