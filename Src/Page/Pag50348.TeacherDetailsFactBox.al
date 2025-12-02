page 50348 "Teacher Details FactBox"
{
    PageType = CardPart;
    SourceTable = "Teacher Header";
    Caption = 'Teacher Details';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Teacher Image"; Rec."Teacher Image")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the photo of the teacher.';
                }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Teacher Name"; Rec."Teacher Name") { ApplicationArea = All; }
                field("Department"; Rec.Department) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
            }
        }
    }
}
