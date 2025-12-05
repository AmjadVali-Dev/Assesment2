page 50322 "Teacher Order List"
{
    ApplicationArea = All;
    Caption = 'Teacher Order List';
    PageType = List;
    SourceTable = "Teacher Header";
    UsageCategory = Lists;
    CardPageId = "Teacher Order";
    SourceTableView = where("Document Type" = filter(Assignment));

    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
        }
        area(FactBoxes)
        {
            part(Attachments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(50308), "No." = field("No.");
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
            action("Export Excel")
            {
                ApplicationArea = All;
                Image = Export;
                Caption = 'Export Excel';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Excel Export";
                begin
                    CodeunitRec.Excel_Export();
                end;
            }
            action("Import Excel")
            {
                ApplicationArea = All;
                Image = Import;
                Caption = 'Import Excel';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Excel Import";
                begin
                    CodeunitRec.UploadStream();
                    CodeunitRec.Import_Excel();
                end;
            }
            action("Export Json")
            {
                ApplicationArea = All;
                Image = Export;
                Caption = 'Export Json';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "All Teacher Export";
                    jsonText: Text;
                begin
                    jsonText := CodeunitRec.CreateAllTeacherJson();
                    CodeunitRec.DownloadJson(jsonText);
                end;
            }
            action("Import Data Using text")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Import Data Using text';
                trigger OnAction()
                var
                    JsonTextL: Text;
                    JsonTextRec: Page "Get The Data For Teacher";
                    JsonCodeunit: Codeunit "All Teacher Export";
                begin
                    JsonTextRec.RunModal();
                    JsonTextL := JsonTextRec.Transfer();
                    JsonCodeunit.ImportTeacherFromJson(JsonTextL);
                end;
            }
            action(FilterNotAssigned)
            {
                Caption = 'Show Not Assigned Teachers';
                ApplicationArea = All;
                Image = Filter;

                trigger OnAction()
                var
                    TeacherHeaderRec: Record "Teacher Header";
                begin
                    TeacherHeaderRec.SetRange("Is Assigned", false);
                    CurrPage.SetTableView(TeacherHeaderRec);
                end;
            }
            action(ExportCustomersXml)
            {
                Caption = 'Export Teacher to XML';
                ApplicationArea = All;
                Image = Export;
                trigger OnAction()
                var
                    CustXml: XmlPort "Teacher Header Xml Report";
                begin
                    // CustXml.Run();
                    Xmlport.Run(50300, true, false);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.UpdateAssignmentStatus();
    end;
}
