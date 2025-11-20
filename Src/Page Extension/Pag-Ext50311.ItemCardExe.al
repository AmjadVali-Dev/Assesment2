pageextension 50311 "Item Card Exe" extends "Item Card"
{
    actions
    {
        addlast(processing)
        {
            action("Customer Finding")
            {
                ApplicationArea = All;
                Image = Find;
                Caption = 'Customer Finding';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Item Finding Code Unit";
                begin
                    CodeunitRec.ShowCustomersForItem(Rec."No.");
                end;
            }
            action("Finding How many Lines")
            {
                ApplicationArea = All;
                Image = Find;
                Caption = 'finding';
                trigger OnAction()
                var
                    codeunitRec: Codeunit "Item Finding Code Unit";
                begin
                    codeunitRec.ItemCount(Rec);
                end;
            }
        }
    }
}
