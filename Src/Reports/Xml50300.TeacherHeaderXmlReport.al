xmlport 50300 "Teacher Header Xml Report"
{
    Caption = 'Teacher Header Xml Report';
    Format = Xml;
    Direction = Export;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(TeacherHeader; "Teacher Header")
            {

                fieldelement(DocumentType; TeacherHeader."Document Type") { }
                fieldelement(No; TeacherHeader."No.") { }
                fieldelement(TeacherNo; TeacherHeader."Teacher No.") { }
                fieldelement(TeacherName; TeacherHeader."Teacher Name") { }
                fieldelement(AssainmentDate; TeacherHeader."Assainment Date") { }
                fieldelement(Department; TeacherHeader.Department) { }
                fieldelement(TotalHours; TeacherHeader."Total Hours ") { }
                fieldelement(Status; TeacherHeader.Status) { }
                fieldelement(Description; TeacherHeader.Description) { }
                fieldelement(PostingDate; TeacherHeader."Posting Date") { }
                fieldelement(CreatedBy; TeacherHeader."Created By") { }

                tableelement(TeacherLine; "Teacher Line")
                {
                    XmlName = 'TeacherLines';
                    MinOccurs = Zero;
                    LinkTable = TeacherHeader;
                    LinkFields = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    fieldelement(Subject_code; TeacherLine."Subject Code") { }
                    fieldelement(SubjectName; TeacherLine."Subject Name") { }
                    fieldelement(Hours; TeacherLine."Hours Assained") { }
                    fieldelement(LineNo; TeacherLine."Line No.") { }
                    fieldelement(Class_Date; TeacherLine."Class Date") { }
                }
                trigger OnPreXmlItem()
                begin
                    TeacherHeader.SetRange("Document Type", TeacherHeader."Document Type"::Assignment);
                end;
            }

        }
    }

}