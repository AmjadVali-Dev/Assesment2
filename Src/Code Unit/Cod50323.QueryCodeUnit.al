codeunit 50323 "Query Code Unit"
{
    trigger OnRun()

    begin
        QueryRec.SetFilter(Quantity, '>500');
        QueryRec.Open();
        while QueryRec.Read() do begin
            Message(TextBox,
                    QueryRec.CustNo,
                    QueryRec.CustName,
                    QueryRec.Quantity);
        end;
        QueryRec.Close();
    end;

    var
        QueryRec: Query "Join Using Query";
        TextBox: TextConst ENU = 'Customer No.: %1, Customer Name: %2, Quantity: %3';
}
