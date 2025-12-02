page 50349 "Teacher Attachment FactBox"
{
    Caption = 'Attachments';
    PageType = ListPart;
    SourceTable = "Document Attachment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }

                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DownloadAttachment)
            {
                Caption = 'Download';
                Image = Download;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec."File Name" <> '' then
                        Rec.Export(true)
                    else
                        Error('Cannot download a file without a name.');
                end;
            }


            action(DeleteAttachment)
            {
                Caption = 'Delete';
                Image = Delete;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you want to delete this attachment?', false) then begin
                        Rec.Delete();
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
}
