codeunit 50322 "Teacher Quote Mgmt"
{
    procedure ConvertQuoteToOrder(var QuoteHeader: Record "Teacher Header")
    var
        OrderHeader: Record "Teacher Header";
        QuoteLine: Record "Teacher Line";
        OrderLine: Record "Teacher Line";
        NextLineNo: Integer;
    begin
        OrderHeader.Init();
        OrderHeader."Document Type" := OrderHeader."Document Type"::Assignment;
        OrderHeader.Validate("Teacher No.", QuoteHeader."Teacher No.");
        OrderHeader.Validate("Teacher Name", QuoteHeader."Teacher Name");
        OrderHeader.Department := QuoteHeader.Department;
        OrderHeader."Assainment Date" := QuoteHeader."Assainment Date";
        OrderHeader.Insert(true);

        QuoteLine.SetRange("Document No.", QuoteHeader."No.");
        QuoteLine.SetRange("Document Type", QuoteHeader."Document Type");
        if QuoteLine.FindSet() then begin
            NextLineNo := 10000;
            repeat
                OrderLine.Init();
                OrderLine."Document Type" := OrderLine."Document Type"::Assignment;
                OrderLine."Document No." := OrderHeader."No.";
                OrderLine."Line No." := NextLineNo;
                OrderLine."Subject Code " := QuoteLine."Subject Code ";
                OrderLine."Subject Name" := QuoteLine."Subject Name";
                OrderLine."Hours Assained" := QuoteLine."Hours Assained";
                OrderLine.Insert(true);
                NextLineNo += 10000;
            until QuoteLine.Next() = 0;
        end;

        Message('Teacher Quote %1 successfully converted to Order %2',
            QuoteHeader."No.", OrderHeader."No.");
        Page.Run(Page::"Teacher Order", OrderHeader);

    end;
}
