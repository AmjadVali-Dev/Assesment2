page 50337 "Teacher Shipment"
{
    ApplicationArea = All;
    Caption = 'Teacher Shipment';
    PageType = Document;
    SourceTable = "Tacher Shipment Header";
    SourceTableView = where("Document Type" = filter(Shipment));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Shipment No. field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                }
                field("Teacher Name"; Rec."Teacher Name")
                {
                    ToolTip = 'Specifies the value of the Teacher Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Total Hours Shipped"; Rec."Total Hours Shipped")
                {
                    ToolTip = 'Specifies the value of the Total Hours Shipped field.', Comment = '%';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Shipped By"; Rec."Shipped By")
                {
                    ToolTip = 'Specifies the value of the Shipped By field.', Comment = '%';
                }
                field("Shipped On"; Rec."Shipped On")
                {
                    ToolTip = 'Specifies the value of the Shipped On field.', Comment = '%';
                }
            }
            part("Teacher Shipment Order Subform"; "Teacher Shipment Orde Subform")
            {
                SubPageLink = "Document No." = field("Document No."), "Document Type" = field("Document Type");
                ApplicationArea = All;
            }
        }
    }

}
