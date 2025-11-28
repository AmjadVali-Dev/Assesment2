report 50307 "Teacher Header Report"
{
    ApplicationArea = All;
    Caption = 'Teacher Header Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\TeacherHeaderReport.rdl';
    dataset
    {
        dataitem(TeacherHeader; "Teacher Header")
        {
            RequestFilterFields = "No.";
            column(DocumentType; "Document Type") { }
            column(No; "No.") { }
            column(TeacherNo; "Teacher No.") { }
            column(TeacherName; "Teacher Name") { }
            column(AssainmentDate; Format("Assainment Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(Department; Department) { }
            column(TotalHours; "Total Hours ") { }
            column(Status; Status) { }
            column(Description; Description) { }
            column(PostingDate; Format("Posting Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(CreatedBy; "Created By") { }
            column(Teacher_Image; "Teacher Image") { }
            dataitem("Teacher Line"; "Teacher Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(Document_No_; "Document No.") { }
                column(Document_Type; "Document Type") { }
                column(Line_No_; "Line No.") { }
                column(Hours_Assained; "Hours Assained") { }
                column(Subject_Code_; "Subject Code ") { }
                column(Subject_Name; "Subject Name") { }

            }
        }
    }
}
