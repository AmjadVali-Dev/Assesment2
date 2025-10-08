page 50309 "DepartmentA"
{
    ApplicationArea = All;
    Caption = 'DepartmentA';
    PageType = Card;
    SourceTable = DepartmentA;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.', Comment = '%';
                }
            }
        }
    }
}
