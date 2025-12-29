page 50355 "Book List"
{
    ApplicationArea = All;
    Caption = 'Book List';
    PageType = List;
    SourceTable = Book;
    UsageCategory = Lists;
    CardPageId = "Book Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Book ID"; Rec."Book ID")
                {
                    ToolTip = 'Specifies the value of the Book ID field.', Comment = '%';
                }
                field("Book Publisher"; Rec."Book Publisher")
                {
                    ToolTip = 'Specifies the value of the Book Publisher field.', Comment = '%';
                }
                field("Book Title"; Rec."Book Title")
                {
                    ToolTip = 'Specifies the value of the Book Title field.', Comment = '%';
                }
                field("Book Genre"; Rec."Book Genre")
                {
                    ToolTip = 'Specifies the value of the Book Genre field.', Comment = '%';
                }
            }
        }
    }
}
