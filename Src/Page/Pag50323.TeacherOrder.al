page 50323 "Teacher Order"
{
    ApplicationArea = All;
    Caption = 'Teacher Order';
    PageType = Document;
    SourceTable = "Teacher Header";
    SourceTableView = where("Document Type" = filter(Assignment));
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Teacher Name"; Rec."Teacher Name")
                {
                    ToolTip = 'Specifies the value of the Teacher Name field.', Comment = '%';
                }
                field("Assainment Date"; Rec."Assainment Date")
                {
                    ToolTip = 'Specifies the value of the Assainment Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                // field("Total Hours "; Rec."Total Hours ")
                // {
                //     ToolTip = 'Specifies the value of the Total Hours field.', Comment = '%';
                // }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Approved On"; Rec."Approved On")
                {
                    ToolTip = 'Specifies the value of the Approved On field.', Comment = '%';
                }
                field("Teacher Image"; Rec."Teacher Image")
                {
                    ToolTip = 'Specifies the value of the Teacher Image field.', Comment = '%';
                }
                field("Teacher Photo"; Rec."Teacher Photo")
                {
                    ToolTip = 'Specifies the value of the Teacher Photo field.', Comment = '%';
                    ShowCaption = true;
                }
                field("Total Hours2"; Rec."Total Hours2")
                {
                    ToolTip = 'Specifies the value of the Total Hours2 field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        Orderline: Record "Teacher Line";
                    begin
                        Orderline.SetRange("Document No.", Rec."No.");
                        Orderline.SetRange("Document Type", Orderline."Document Type"::Assignment);
                        PAGE.Run(PAGE::"Teacher Line List", Orderline);
                    end;
                }
                field("Is Assigned"; Rec."Is Assigned")
                {
                    ToolTip = 'Specifies the value of the Is Assigned field.', Comment = '%';
                }
            }
            part("Teacher Order Subform"; "Teacher Order Subform")
            {
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            part(TeacherDetails; "Teacher Details FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Attachments; "Teacher Attachment FactBox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(50308),
              "No." = field("No.");
            }

            systempart(Links; Links)
            {
                ApplicationArea = All;
            }

            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Post")
            {
                Caption = 'Post';
                Image = Post;
                action(PostInvoice)
                {
                    Caption = 'Post Invoice';
                    Image = Post;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostingMgt: Codeunit "Teacher Posting Mgt";
                    begin
                        if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                            Error('The order must be approved before posting.');
                        PostingMgt.PostTeacherHeader(Rec);
                        Message('Teacher Invoice Posted Successfully.');
                    end;
                }
                action(PostShipment)
                {
                    Caption = 'Post Shipment';
                    Image = Post;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostingMgt: Codeunit "Teacher Posting Mgt";
                    begin
                        if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                            Error('The order must be approved before posting.');
                        PostingMgt.PostTeacherShipment(Rec);
                        Message('Teacher Shipment Posted Successfully.');
                    end;
                }
                action(PostShipAndInvoice)
                {
                    Caption = 'Post Shipment and Invoice';
                    Image = Post;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostingMgt: Codeunit "Teacher Posting Mgt";
                    begin
                        if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                            Error('The order must be approved before posting.');
                        PostingMgt.PostTeacherShipment(Rec);
                        PostingMgt.PostTeacherHeader(Rec);
                        Message('Teacher Shipment and Invoice Posted Successfully.');
                    end;
                }

            }
            action("Look Up Check")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Look Up Check';
                trigger onaction()
                var
                    TeacherRec: Record "Master Table Teacher";
                begin
                    if Page.RunModal(Page::"Teacher Master List", TeacherRec) = Action::LookupOK then begin
                        Rec."Teacher No." := TeacherRec."Teacher No.";
                        Rec."Teacher Name" := TeacherRec."Teacher Name";
                        Rec.Modify(true);
                        Message('Selected Teacher: %1', TeacherRec."Teacher Name");
                    end;
                end;
            }
            action("Recalculate Total Hours")
            {
                ApplicationArea = All;
                Caption = 'Recalculate Total Hours';
                Image = Calculate;

                trigger OnAction()
                begin
                    Rec.UpdateTotalHoursFromLines();
                    Rec.Modify(true);

                    Message('Total Hours updated based on Teacher Lines.');
                end;
            }
            action(ViewInvoices)
            {
                Caption = 'Show Invoices';
                ApplicationArea = All;
                Image = Find;
                trigger OnAction()
                var
                    InvoiceList: Page "Posted Teacher Invoice List";
                    InvRec: Record "Teacher Invoice Header";
                begin
                    InvRec.SetRange("Teacher No.", Rec."Teacher No.");
                    InvoiceList.SetTableView(InvRec);
                    InvoiceList.RunModal();
                end;
            }
            action(ViewShipments)
            {
                Caption = 'Show Shipments';
                ApplicationArea = All;
                Image = Find;
                trigger OnAction()
                var
                    ShipmentList: Page "Teacher Shipment List";
                    ShipmentRec: Record "Tacher Shipment Header";
                begin
                    ShipmentRec.SetRange("Teacher No.", Rec."Teacher No.");
                    ShipmentList.SetTableView(ShipmentRec);
                    ShipmentList.RunModal();
                end;
            }
            action(PrintTeacherOrder)
            {
                Caption = 'Print Teacher Order';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Teacher Header Report", true, false, Rec);
                end;
            }
            group("Approval")
            {
                Caption = 'Approval';
                Image = Approval;
                action(SendForApproval)
                {
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec."Approval Status" := Rec."Approval Status"::"Pending Approval";
                        Rec.Modify(true);
                        Message('Teacher Order sent for approval.');
                    end;
                }
                action(ApproveOrder)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec."Approved By" := UserId();
                        Rec."Approved On" := CurrentDateTime();
                        Rec.Modify(true);
                        Message('Teacher Order approved.');
                    end;
                }
                action(RejectOrder)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec."Approval Status" := Rec."Approval Status"::Rejected;
                        Rec."Approved By" := '';
                        Rec."Approved On" := 0DT;
                        Rec.Modify(true);
                        Message('Teacher Order rejected.');
                    end;
                }
            }
            action("Export Json")
            {
                ApplicationArea = All;
                Image = Export;
                Caption = 'Export Json';
                trigger OnAction()
                var
                    Codeunitrec: Codeunit "Teacher Order Json Export";
                    JsonText: Text;
                begin
                    JsonText := Codeunitrec.CreateTeacherHeaderJson(Rec);
                    Codeunitrec.DownloadJson(JsonText);
                end;
            }
            action("AddNote")
            {
                ApplicationArea = All;
                Image = Note;
                Caption = 'Add Note';
                trigger OnAction()
                var
                    RecordLinkL: Record "Record Link";
                    RecordLinkMgmt: Codeunit "Record Link Management";
                begin
                    RecordLinkL.Init();
                    RecordLinkL."Record ID" := Rec.RecordId;
                    RecordLinkL.Type := RecordLinkL.Type::Note;
                    RecordLinkL.Company := CompanyName;
                    RecordLinkL.Created := CurrentDateTime;
                    RecordLinkL."User ID" := UserId;
                    RecordLinkMgmt.WriteNote(RecordLinkL, 'Testing Note');
                    RecordLinkL.Insert(true);
                    Message('The Note Successfully inserted in The Teacher Order No %1', Rec."No.");
                end;
            }
            action("Add Link")
            {
                ApplicationArea = All;
                Image = Link;
                Caption = 'Add Link';
                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                begin
                    RecordLink.Init();
                    RecordLink."Record ID" := Rec.RecordId;
                    RecordLink.Type := RecordLink.Type::Link;
                    RecordLink.Description := 'This is Youtube Link';
                    RecordLink.URL1 := 'https://www.youtube.com/';
                    RecordLink.Company := CompanyName;
                    RecordLink.Created := CurrentDateTime;
                    RecordLink."User ID" := UserId;
                    RecordLink.Insert(true);
                    Message('Link added successfully for Teacher Order %1', Rec."No.");
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
                    CreateAttachment.UploadAttachment(Rec);
                end;
            }
            fileuploadaction(UploadFiles)
            {
                Caption = 'Upload Files';
                Image = Import;
                ApplicationArea = All;
                AllowMultipleFiles = true;
                trigger OnAction(Files: List of [FileUpload])
                var
                    CreateAttachment: Codeunit "Create Attachment";
                begin
                    CreateAttachment.UploadAttachmentMulti(Rec, Files);
                    CurrPage.Update();
                end;
            }

        }
    }
}
