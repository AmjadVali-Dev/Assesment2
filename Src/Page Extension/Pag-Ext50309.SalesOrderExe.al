pageextension 50309 "Sales Order Exe" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
            }
            field("Customer Name2"; Rec."Customer Name2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("json Operation")
            {
                ApplicationArea = All;
                Caption = 'Json Operation';
                Image = New;
                trigger OnAction()
                var
                    JsonCodeunit: Codeunit "Json Practice";
                begin
                    JsonCodeunit.CreateStudentJSON();
                end;
            }
            action("Json Header Operation")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Json Header Operation';
                trigger OnAction()
                var
                    JsonCodeunit: Codeunit "Json Practice";
                begin
                    JsonCodeunit.CreateSalesHeaderJson(Rec);
                end;
            }
            action("ReadJson")
            {
                ApplicationArea = All;
                Caption = 'Read Json';
                Image = New;
                trigger OnAction()
                var
                    JsonCodeunit: Codeunit "Json Practice";
                    jsonRead: Text;
                begin
                    jsonRead := JsonCodeunit.CreateSalesHeaderJson(Rec);
                    JsonCodeunit.ReadComplexJson(jsonRead);
                end;
            }
            action("Json Buffer")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Json Buffer';
                trigger OnAction()
                var
                    JsonCodeunit: Codeunit "Json Practice";
                    jsonRead: Text;
                begin
                    jsonRead := JsonCodeunit.CreateSalesHeaderJson(Rec);
                    JsonCodeunit.ReadjsonBuffer(jsonRead);
                end;
            }
            action("Read Sales Order")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Read Sales Order';
                trigger OnAction()
                var
                    JsonPracticeCodeUnitL: Codeunit "Json Practice 2";
                begin
                    JsonPracticeCodeUnitL.ReadSaleOrder(Rec);
                end;
            }

            action("Create a App Json")
            {
                ApplicationArea = All;
                Image = Create;
                Caption = 'Create A App Json';
                trigger OnAction()
                var
                    JsonPractice3: Codeunit "Json Practice 3";
                begin
                    JsonPractice3.GenerateAppJson();
                end;
            }
            action("Create a Salaes Order")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Create a Sales Order';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Sales Order Creation";
                begin
                    CodeunitRec.CreateSalesOrderFromCustomer();
                end;
            }

        }
    }


}
