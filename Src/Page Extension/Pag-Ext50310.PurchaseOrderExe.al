pageextension 50310 "Purchase OrderExe" extends "Purchase Order"
{
    actions
    {
        addlast(processing)
        {
            action("Practice")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Practice';
                trigger OnAction()
                var
                    JsonPractice3Rec: Codeunit "Json Practice 3";
                begin
                    JsonPractice3Rec.CreateJsonExample();
                end;
            }
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
            action("Json Buffer")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Json Buffer';
                trigger OnAction()
                var
                    JsonCodeunitRec: Codeunit "Json Practice 2";
                    JsonString: Text;
                begin
                    JsonString := JsonCodeunitRec.CreatePurchaseHeader(Rec);
                    JsonCodeunitRec.JsonBuffer(JsonString);
                end;
            }
            action("Read Json Buffer")
            {
                ApplicationArea = All;
                image = New;
                Caption = 'Read Json Buffer';
                trigger OnAction()
                var
                    jsoncodeunitRec: Codeunit "Json Practice 2";
                    JsonString: Text;
                begin
                    JsonString := jsoncodeunitRec.CreatePurchaseHeader(Rec);
                    jsoncodeunitRec.ReadWithJsonBuffer(JsonString);
                end;
            }
        }
    }
}
