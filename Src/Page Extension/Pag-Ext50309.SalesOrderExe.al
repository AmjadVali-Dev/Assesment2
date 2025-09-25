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
        }
    }
}
