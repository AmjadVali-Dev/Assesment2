pageextension 50310 "Purchase OrderExe" extends "Purchase Order"
{
    actions
    {
        addlast(processing)
        {
            action("Json Operaton")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Json Operation';
                trigger OnAction()
                var
                    JsonCodeunit: Codeunit "Json Practice 2";
                begin
                    JsonCodeunit.JsonCreation();
                end;
            }
            action("Json Creation")
            {
                ApplicationArea = All;
                image = New;
                Caption = 'Json Purchase Order Creation';
                trigger OnAction()
                var
                    JsonCreateRec: Codeunit "Json Practice 2";
                begin
                    JsonCreateRec.CreatePurchaseHeader(Rec);
                end;
            }
            action("Download Json")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Download Json';
                trigger OnAction()
                var
                    JsonCreateRec: Codeunit "Json Practice 2";
                    JsonRead: Text;
                begin
                    jsonRead := JsonCreateRec.CreatePurchaseHeader(Rec);
                    JsonCreateRec.ReadComplexJson(jsonRead);
                end;
            }
        }
    }
}
