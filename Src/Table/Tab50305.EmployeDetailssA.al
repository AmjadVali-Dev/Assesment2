table 50305 "Employe DetailssA"
{
    Caption = 'Employe DetailssA';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmpID; Code[20])
        {
            Caption = 'EmpID';
        }
        field(2; EmpName; Text[50])
        {
            Caption = 'EmpName';
        }
        field(3; Department; Text[30])
        {
            Caption = 'Department';
        }
        field(4; Salary; Decimal)
        {
            Caption = 'Salary';
            trigger OnValidate()

            begin
                if Rec.Salary < 5000 then
                    Error('The Salary Must Be 5000');
                Bonus := Salary * 0.1;
            end;
        }
        field(5; JoiningDate; Date)
        {
            Caption = 'JoiningDate';
        }
        field(6; "Designation"; Text[30])
        {
            Caption = 'Designation';
        }
        field(7; "Bonus"; Decimal)
        {
            Caption = 'Bonus';
            Editable = false;
        }
    }
    keys
    {
        key(PK; EmpID)
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        if Rec.Salary <> xRec.Salary then
            Message('The Salary is Updated From %1 to %2', xRec.Salary, rec.Salary);
    end;

}
