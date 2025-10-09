page 50312 "Employee Details A"
{
    ApplicationArea = All;
    Caption = 'Employee Details A';
    PageType = Card;
    SourceTable = "Employe DetailssA";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
            }
        }
    }
}
