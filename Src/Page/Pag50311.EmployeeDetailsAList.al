page 50311 "Employee Details A List"
{
    ApplicationArea = All;
    Caption = 'Employee Details A List';
    PageType = List;
    SourceTable = "Employe DetailssA";
    UsageCategory = Lists;
    CardPageId = "Employee Details A";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EmpID; Rec.EmpID)
                {
                    ToolTip = 'Specifies the value of the EmpID field.', Comment = '%';
                }
                field(EmpName; Rec.EmpName)
                {
                    ToolTip = 'Specifies the value of the EmpName field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Salary; Rec.Salary)
                {
                    ToolTip = 'Specifies the value of the Salary field.', Comment = '%';
                }
                field(JoiningDate; Rec.JoiningDate)
                {
                    ToolTip = 'Specifies the value of the JoiningDate field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field(Bonus; Rec.Bonus)
                {
                    ToolTip = 'Specifies the value of the Bonus field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("To Get Employe Data")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'To Get Employe Data';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Employe DetailsJson";
                    jsonText: Text;
                begin
                    jsonText := CodeunitRec.GetAllEmployeesAsJSON();
                    Message('Data That Stored in The Employe table %1', jsonText);
                end;
            }
            action("Employee Export")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Exel Export';
                ShortCutKey = 'Ctrl+F7';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Employe Details Exel Export";
                begin
                    CodeunitRec.Exel_Export();
                end;
            }
            action("Employee Import")
            {
                ApplicationArea = All;
                Caption = 'Employee Import';
                Image = Import;
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Exel Import";
                begin
                    CodeunitRec.CreateDailogueBox();
                    CodeunitRec.Import_Exel();
                end;
            }
            action("To Get Data Using Json")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'To Get Data Using Json';
                trigger OnAction()
                var
                    CodeUnitRec: Codeunit "Json Practice Employe";
                    JsonText: Text;
                begin
                    JsonText := CodeUnitRec.ExportEmployeeDetails();
                    Message('The Data inside the Employee IS %1', JsonText);
                end;
            }
            action("Import Data Using Json")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Import Data Using Json';
                trigger OnAction()
                var
                    CodeUnitRec: Codeunit "Json Practice Employe";
                    JsonText: Text;
                    FromFileL: Text;
                    instream: InStream;
                    Line: Text;
                    Dailoguetitle: Label 'Please Insert the File';
                begin
                    UploadIntoStream(Dailoguetitle, '', '', FromFileL, instream);
                    if FromFileL <> '' then begin
                        while not instream.EOS do begin
                            instream.Read(Line);
                            JsonText += Line;
                        end;
                    end;
                    CodeUnitRec.InsertEmployeeFromJson(JsonText);
                end;
            }
            action("Import Data Using text")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Import Data Using text';
                trigger OnAction()
                var
                    JsonTextL: Text[2048];
                    JsonTextRec: Page "Get Text";
                    JsonCodeunit: Codeunit "Json Practice Employe";
                begin
                    JsonTextRec.RunModal();
                    JsonTextL := JsonTextRec.Transfer();
                    JsonCodeunit.InsertEmployeeFromJson(JsonTextL);
                end;
            }
        }
    }
}