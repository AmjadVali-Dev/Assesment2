table 50304 DepartmentA
{
    Caption = 'DepartmentA';
    DataClassification = ToBeClassified;
    LookupPageId = "DepartmentA List";
    DrillDownPageId = DepartmentA;
    fields
    {
        field(1; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(2; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
        }
    }
    keys
    {
        key(PK; "Department Code")
        {
            Clustered = true;
        }
    }
}
