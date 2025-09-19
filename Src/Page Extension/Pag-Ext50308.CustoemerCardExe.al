pageextension 50308 "Custoemer Card Exe" extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {
            action(AddNoteToCustomer)
            {
                Caption = 'Add Note';
                Image = Note;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                    RecLinkMgt: Codeunit "Record Link Management";
                begin
                    RecordLink.Init();
                    RecordLink."Record ID" := Rec.RecordId;
                    RecordLink.Type := RecordLink.Type::Note;
                    RecordLink.Company := CompanyName;
                    RecordLink.Created := CurrentDateTime;
                    RecordLink."User ID" := UserId;
                    RecLinkMgt.WriteNote(RecordLink, 'Testing FactBox1');
                    RecordLink.Insert(true);
                    Message('Note added successfully for customer %1', Rec."No.");
                end;
            }
            action("Add Link")
            {
                ApplicationArea = All;
                Caption = 'Add Link';
                Image = Link;

                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                begin
                    RecordLink.Init();
                    RecordLink."Record ID" := Rec.RecordId;
                    RecordLink.Type := RecordLink.Type::Link;
                    RecordLink.Description := 'Microsoft..';
                    RecordLink.URL1 := 'https://www.microsoft.com';
                    RecordLink.Company := CompanyName;
                    RecordLink.Created := CurrentDateTime;
                    RecordLink."User ID" := UserId;
                    RecordLink.Insert(true);
                    Message('Link added successfully for customer %1', Rec."No.");
                end;
            }
            action(DeleteCustomerNotes)
            {
                Caption = 'Delete Notes';
                Image = Delete;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DeltenotesCodeRec: Codeunit DeleteNote;
                begin
                    DeltenotesCodeRec.DeleteNotes(Rec);
                end;

            }
            action(DeleteCustomerLinks)
            {
                Caption = 'Delete Links';
                Image = Delete;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                begin
                    RecordLink.SetRange("Record ID", Rec.RecordId);
                    RecordLink.SetRange(Type, RecordLink.Type::Link);

                    if RecordLink.FindSet() then begin
                        repeat
                            RecordLink.Delete();
                        until RecordLink.Next() = 0;

                        Message('All links deleted for customer %1', Rec."No.");
                    end else
                        Message('No links found for customer %1', Rec."No.");
                end;
            }
            action("Add Atachments")
            {
                ApplicationArea = All;
                Image = Attachments;
                Caption = 'Add Attachments';
                trigger OnAction()
                var
                    CreateAttachment: Codeunit "Create Attachment";
                begin
                    CreateAttachment.UploadDocumentToFactBox(Rec);
                end;
            }
            action("Delete Attachment")
            {
                ApplicationArea = All;
                Caption = 'Delete Attachment';
                Image = Attachments;
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Create Attachment";
                begin
                    CodeunitRec.DeleteAttachMent();
                end;
            }
        }
    }
}
