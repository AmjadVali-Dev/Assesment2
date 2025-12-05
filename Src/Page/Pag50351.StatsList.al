page 50351 "Stats List"
{
    ApplicationArea = All;
    Caption = 'Stats List';
    PageType = List;
    SourceTable = "Teacher XML Stats";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Last Export Date"; Rec."Last Export Date")
                {
                    ToolTip = 'Specifies the value of the Last Export Date field.', Comment = '%';
                }
                field("Last Import Date"; Rec."Last Import Date")
                {
                    ToolTip = 'Specifies the value of the Last Import Date field.', Comment = '%';
                }
                field("Total Teachers"; Rec."Total Teachers")
                {
                    ToolTip = 'Specifies the value of the Total Teachers field.', Comment = '%';
                }
            }
        }
    }
}
