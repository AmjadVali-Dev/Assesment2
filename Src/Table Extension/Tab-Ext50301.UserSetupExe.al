tableextension 50301 "User Setup Exe" extends "User Setup"
{
    fields
    {
        field(50300; DepartmentA; Enum "Department Type")
        {
            Caption = 'DepartmentA';
            DataClassification = ToBeClassified;
        }
        field(50301; "Allow Requisition ReleaseA"; Boolean)
        {
            Caption = 'Allow Requisition Release';
            DataClassification = ToBeClassified;
        }
    }
}
