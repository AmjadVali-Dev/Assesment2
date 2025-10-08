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
        }
    }
}
