page 50350 Teachers
{
    APIGroup = 'Teacher';
    APIPublisher = 'Amjadali';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'teachers';
    DelayedInsert = true;
    EntityName = 'Teacherdata';
    EntitySetName = 'TeachersWorking';
    PageType = API;
    SourceTable = "Teacher Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(teacherNo; Rec."Teacher No.")
                {
                    Caption = 'Teacher No.';
                }
                field(teacherName; Rec."Teacher Name")
                {
                    Caption = 'Teacher Name';
                }
                field(assainmentDate; Rec."Assainment Date")
                {
                    Caption = 'Assainment Date';
                }
                field(department; Rec.Department)
                {
                    Caption = 'Department';
                }
                field(totalHours; Rec."Total Hours ")
                {
                    Caption = 'Total Hours';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
            }
        }
    }
}
