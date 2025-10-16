pageextension 50313 "Customer List Exe" extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action("Checking TempBlob")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Checking Tem Blob';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit TempBlobCodeunit;
                begin
                    CodeunitRec.ExportEmployeeCSV();
                end;
            }
            action("Customer Get")
            {
                ApplicationArea = All;
                image = New;
                Caption = 'Customer Get';
                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                begin
                    if CustomerRec.Get('10000') then
                        Message(CustomerRec."No.");
                end;
            }
        }
    }
}
