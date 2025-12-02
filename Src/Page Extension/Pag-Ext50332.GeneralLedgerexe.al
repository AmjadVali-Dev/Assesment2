pageextension 50332 "General Ledger exe" extends "General Ledger Entries"
{
    layout
    {
        modify("Entry No.")
        {
            Visible = false;
        }

        addbefore("Posting Date")
        {
            field("Entry No. New"; Rec."Entry No.")
            {
                Caption = 'Entry No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the entry number.';
            }
        }
    }
}
