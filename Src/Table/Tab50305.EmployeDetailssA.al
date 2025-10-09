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
        }
        field(5; JoiningDate; Date)
        {
            Caption = 'JoiningDate';
        }
    }
    keys
    {
        key(PK; EmpID)
        {
            Clustered = true;
        }
    }

}
