page 50310 "DepartmentA List"
{
    ApplicationArea = All;
    Caption = 'DepartmentA List';
    PageType = List;
    SourceTable = DepartmentA;
    UsageCategory = Lists;
    CardPageId = DepartmentA;
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
