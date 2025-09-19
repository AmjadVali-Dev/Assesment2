pageextension 50301 "User Setup Exe" extends "User Setup"
{
    layout
    {
        addlast(content)
        {
            group(Amjad)
            {
                field(DepartmentA; Rec.DepartmentA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Allow Requisition ReleaseA"; Rec."Allow Requisition ReleaseA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Requisition Release field.', Comment = '%';
                }
            }
        }
    }
}
