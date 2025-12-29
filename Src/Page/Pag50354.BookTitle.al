page 50354 "Book Title"
{
    ApplicationArea = All;
    Caption = 'Book Title';
    PageType = Card;
    SourceTable = "Book Title";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
