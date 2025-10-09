page 50311 "Employee Details A List"
{
    ApplicationArea = All;
    Caption = 'Employee Details A List';
    PageType = List;
    SourceTable = "Employe DetailssA";
    UsageCategory = Lists;
    CardPageId = "Employee Details A";
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("To Get Employe Data")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'To Get Employe Data';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Employe DetailsJson";
                    jsonText: Text;
                begin
                    jsonText := CodeunitRec.GetAllEmployeesAsJSON();
                    Message('Data That Stored in The Employe table %1', jsonText);
                end;
            }
        }
    }
}
