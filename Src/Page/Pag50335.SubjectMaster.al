page 50335 "Subject Master"
{
    ApplicationArea = All;
    Caption = 'Subject Master';
    PageType = Card;
    SourceTable = "Subject Master Table";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Specifies the value of the Subject Code field.', Comment = '%';
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ToolTip = 'Specifies the value of the Subject Name field.', Comment = '%';
                }
            }
        }
    }
}
