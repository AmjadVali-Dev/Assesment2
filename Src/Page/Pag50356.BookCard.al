page 50356 "Book Card"
{
    ApplicationArea = All;
    Caption = 'Book Card';
    PageType = Card;
    SourceTable = Book;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BookTitlerec: Record "Book Title";
                    begin
                        BookTitlerec.SetRange("Book Genre", Rec."Book Genre");
                        if RunModal(Page::"Book Title List", BookTitlerec) = Action::LookupOK then begin
                            Text := BookTitlerec.Title;
                            exit(true);
                        end;
                        exit(false);
                    end;
                }
                field("Book Genre"; Rec."Book Genre")
                {
                    ToolTip = 'Specifies the value of the Book Genre field.', Comment = '%';
                }
            }
        }
    }
}
