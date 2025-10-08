table 50303 "Employe Master"
{
    Caption = 'Employe Master';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(2; "Employee Name."; Text[50])
        {
            Caption = 'Employee Name.';
        }

        field(3; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = DepartmentA."Department Code";
            trigger OnValidate()
            var
                DepartmentRec: Record DepartmentA;
            begin
                if DepartmentRec.Get("Department Code") then begin
                    "Department Name" := DepartmentRec."Department Name";
                end;
            end;

        }
        field(4; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
        }
        field(5; "Employe Status"; Enum "Employe Status E")
        {
            Caption = 'Employe Status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employee No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        CodeUnitRec: Codeunit "Reuisition No Gen";
    begin
        CodeUnitRec.NoGenE(Rec);
    end;
}
