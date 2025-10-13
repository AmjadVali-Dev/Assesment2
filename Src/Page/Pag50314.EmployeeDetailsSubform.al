page 50314 "Employee Details  Subform"
{
    ApplicationArea = All;
    Caption = 'Employee Details  Subform';
    PageType = ListPart;
    SourceTable = "Employe DetailssA";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EmpID; Rec.EmpID)
                {
                    ToolTip = 'Specifies the value of the EmpID field.', Comment = '%';
                }
                field(EmpName; Rec.EmpName)
                {
                    ToolTip = 'Specifies the value of the EmpName field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Salary; Rec.Salary)
                {
                    ToolTip = 'Specifies the value of the Salary field.', Comment = '%';
                }
                field(JoiningDate; Rec.JoiningDate)
                {
                    ToolTip = 'Specifies the value of the JoiningDate field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field(Bonus; Rec.Bonus)
                {
                    ToolTip = 'Specifies the value of the Bonus field.', Comment = '%';
                }
            }
        }
    }
}
