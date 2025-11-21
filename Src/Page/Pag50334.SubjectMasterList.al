page 50334 "Subject Master List"
{
    ApplicationArea = All;
    Caption = 'Subject Master List';
    PageType = List;
    SourceTable = "Subject Master Table";
    UsageCategory = Lists;
    CardPageId = "Subject Master";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
