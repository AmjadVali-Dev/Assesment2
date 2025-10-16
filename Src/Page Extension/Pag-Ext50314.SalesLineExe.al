pageextension 50314 "Sales Line Exe" extends "Sales Lines"
{
    actions
    {
        addlast(Processing)
        {
            action("Delete All Lines Using Setrange")
            {
                ApplicationArea = All;
                Image = Delete;
                Caption = 'Delete All Lines Using Setrange';
                trigger OnAction()
                var
                    salesLineRec: Record "Sales Line";
                begin
                    salesLineRec.SetRange("Document No.", 'AV-021');
                    if salesLineRec.FindSet() then begin
                        repeat
                            salesLineRec.Delete();
                        until salesLineRec.Next() = 0;
                    end;
                end;
            }
            action("Delete All Lines Using Get")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Delete All Lines Using Get';
                trigger OnAction()
                var
                    salesLineRec: Record "Sales Line";
                begin
                    if salesLineRec.Get('1001') then
                        Message(salesLineRec."Document No.");
                end;
            }
        }
    }
}
