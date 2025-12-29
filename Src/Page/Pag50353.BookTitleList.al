page 50353 "Book Title List"
{
    ApplicationArea = All;
    Caption = 'Book Title List';
    PageType = List;
    SourceTable = "Book Title";
    UsageCategory = Lists;
    CardPageId = "Book Title";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field("Book Genre"; Rec."Book Genre")
                {
                    ToolTip = 'Specifies the value of the Book Genre field.', Comment = '%';
                }
            }
        }
    }
}
