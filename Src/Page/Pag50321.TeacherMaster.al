page 50321 "Teacher Master"
{
    ApplicationArea = All;
    Caption = 'Teacher Master';
    PageType = Card;
    SourceTable = "Master Table Teacher";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                }
                field("Teacher Name"; Rec."Teacher Name")
                {
                    ToolTip = 'Specifies the value of the Teacher Name field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Joining Date"; Rec."Joining Date")
                {
                    ToolTip = 'Specifies the value of the Joining Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = '%';
                }
                field("No. of Orders"; Rec."No. of Orders")
                {
                    ToolTip = 'Specifies the value of the No.of Orders field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        OrderHeader: Record "Teacher Header";
                    begin
                        OrderHeader.SetRange("Teacher No.", Rec."Teacher No.");
                        OrderHeader.SetRange("Document Type", OrderHeader."Document Type"::Assignment);
                        PAGE.Run(PAGE::"Teacher Order List", OrderHeader);
                    end;
                }
            }
        }
        area(FactBoxes)
        {
            part(Attachments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(50307), "No." = field("Teacher No.");
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
}
