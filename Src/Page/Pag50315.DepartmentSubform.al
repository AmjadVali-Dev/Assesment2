page 50315 "Department Subform"
{
    ApplicationArea = All;
    Caption = 'Department Subform';
    PageType = ListPart;
    SourceTable = DepartmentA;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
