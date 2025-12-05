page 50352 "Teacher XML Import/Export"
{
    ApplicationArea = All;
    Caption = 'Teacher XML Import/Export';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            grid(maingrid)
            {
                group(Operations)
                {
                    Caption = 'Teacher XML Operations';

                    InstructionalText =
                      'Use this page to import and export teacher data in XML format. Click "Export Teachers" to download all teachers as XML. Click "Import Teachers" to upload teachers from an XML file.';

                    field(Dummy; 0) { Visible = false; }
                }

                group(Statistics)
                {
                    Caption = 'Statistics';
                    Editable = false;

                    field("Total Teachers"; StatsRec."Total Teachers") { }
                    field("Last Export Date"; StatsRec."Last Export Date") { }
                    field("Last Import Date"; StatsRec."Last Import Date") { }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ExportTeachers)
            {
                Caption = 'Export Teachers';
                Image = Export;

                trigger OnAction()
                var
                    Teacher: Record "Teacher Header";
                begin
                    EnsureStatsRec();
                    XmlPort.Run(XmlPort::"Teacher Header Xml Report", true, false);
                    StatsRec."Last Export Date" := CurrentDateTime();
                    Teacher.SetRange("Document Type", Teacher."Document Type"::Assignment);
                    StatsRec."Total Teachers" := Teacher.Count();
                    StatsRec.Modify();
                    CurrPage.Update(false);
                end;
            }

            action(ImportTeachers)
            {
                Caption = 'Import Teachers';
                Image = Import;

                trigger OnAction()
                begin
                    XmlPort.Run(XmlPort::"Teacher Header Import", true, true);

                    if StatsRec.Get('STATS') then begin
                        StatsRec."Last Import Date" := CurrentDateTime();
                        StatsRec.Modify();
                    end;

                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        StatsRec: Record "Teacher XML Stats";

    procedure EnsureStatsRec()
    begin
        if not StatsRec.Get('STATS') then begin
            StatsRec.Init();
            StatsRec."No." := 'STATS';
            StatsRec.Insert();
        end;
    end;

}
