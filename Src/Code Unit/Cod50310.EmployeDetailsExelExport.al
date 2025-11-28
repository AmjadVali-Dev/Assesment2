codeunit 50310 "Employe Details Exel Export"
{
    // procedure Exel_Export()
    // var
    //     TempBufferRec: Record "Excel Buffer" temporary;
    //     EmployeeDetRec: Record "Employe DetailssA";
    // begin
    //     TempBufferRec.Reset();
    //     TempBufferRec.DeleteAll();
    //     TempBufferRec.NewRow();
    //     TempBufferRec.AddColumn('EmpID', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('EmpName', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('Department', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('Salary', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('JoiningDate', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('Designation', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //     TempBufferRec.AddColumn('Bonus', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);

    //     Clear(EmployeeDetRec);
    //     if EmployeeDetRec.FindSet() then begin
    //         repeat
    //             TempBufferRec.NewRow();
    //             TempBufferRec.AddColumn(EmployeeDetRec.EmpID, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //             TempBufferRec.AddColumn(EmployeeDetRec.EmpName, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //             TempBufferRec.AddColumn(EmployeeDetRec.Department, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //             TempBufferRec.AddColumn(EmployeeDetRec.Salary, false, '', false, false, false, '', TempBufferRec."Cell Type"::Number);
    //             TempBufferRec.AddColumn(EmployeeDetRec.JoiningDate, false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
    //             TempBufferRec.AddColumn(EmployeeDetRec.Designation, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
    //             TempBufferRec.AddColumn(EmployeeDetRec.Bonus, false, '', false, false, false, '', TempBufferRec."Cell Type"::Number);
    //         until EmployeeDetRec.Next() = 0;
    //     end;
    //     TempBufferRec.CreateNewBook('Employee Export');
    //     TempBufferRec.WriteSheet('Sheet1', CompanyName, UserId);
    //     TempBufferRec.CloseBook();
    //     TempBufferRec.SetFriendlyFilename('Employe Export');
    //     TempBufferRec.OpenExcel();
    // end;

    procedure Exel_Export()
    var
        TempBufferRec: Record "Excel Buffer" temporary;
        EmployeeDetRec: Record "Employe DetailssA";
    begin
        TempBufferRec.Reset();
        TempBufferRec.DeleteAll();
        TempBufferRec.NewRow();
        TempBufferRec.AddColumn('EmpID', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('EmpName', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Department', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Salary', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('JoiningDate', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Designation', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        TempBufferRec.AddColumn('Bonus', false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
        Clear(EmployeeDetRec);
        if EmployeeDetRec.FindSet() then begin
            repeat
                TempBufferRec.NewRow();
                TempBufferRec.AddColumn(EmployeeDetRec.EmpID, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(EmployeeDetRec.EmpName, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(EmployeeDetRec.Department, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(EmployeeDetRec.Salary, false, '', false, false, false, '', TempBufferRec."Cell Type"::Number);
                TempBufferRec.AddColumn(EmployeeDetRec.JoiningDate, false, '', false, false, false, '', TempBufferRec."Cell Type"::Date);
                TempBufferRec.AddColumn(EmployeeDetRec.Designation, false, '', false, false, false, '', TempBufferRec."Cell Type"::Text);
                TempBufferRec.AddColumn(EmployeeDetRec.Bonus, false, '', false, false, false, '', TempBufferRec."Cell Type"::Number);
            until EmployeeDetRec.Next() = 0;
        end;
        TempBufferRec.CreateNewBook('Employe Export');
        TempBufferRec.WriteSheet('sheet1', CompanyName, UserId);
        TempBufferRec.CloseBook();
        TempBufferRec.SetFriendlyFilename('Employee Export');
        TempBufferRec.OpenExcel();
    end;

}
