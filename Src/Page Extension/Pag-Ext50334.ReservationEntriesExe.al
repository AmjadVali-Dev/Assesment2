pageextension 50334 "Reservation Entries Exe" extends "Reservation Entries"
{
    layout
    {
        addafter("Location Code")
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the lot or serial number on the item tracking line.';
            }
        }
    }
}
