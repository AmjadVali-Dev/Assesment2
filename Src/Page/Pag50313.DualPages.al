page 50313 "Dual Pages"
{
    ApplicationArea = All;
    Caption = 'Dual Pages';
    PageType = ListPlus;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                part("Employee Details"; "Employee Details  Subform")
                {
                    Caption = 'Employe Deatails';
                    ApplicationArea = All;
                }
                part("Department Subform"; "Department Subform")
                {
                    Caption = 'Department Subform';
                    ApplicationArea = All;
                }
            }
        }
    }
}
