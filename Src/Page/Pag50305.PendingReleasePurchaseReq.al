page 50305 "Pending Release Purchase Req"
{
    ApplicationArea = All;
    Caption = 'Pending Release Purchase Req';
    PageType = List;
    SourceTable = "Purchase Requisition Line";
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where("Purchase Order No." = const(''), "Purchase Order Line No." = const(0));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Confirm('Do You Want to create Line', true) then
            CreateLine()
        else
            exit;
    end;

    procedure CreateLine()
    var
        PurchaseReqLine: Record "Purchase Requisition Line";
        PurchaseLineRecL: Record "Purchase Line";
    begin
        PurchaseLineRecL.SetRange("Document Type", PurchHdrRecG."Document Type");
        PurchaseLineRecL.SetRange("Document No.", PurchHdrRecG."No.");
        if PurchaseLineRecL.FindLast() then
            PurchaseLineRecL."Line No." := PurchaseLineRecL."Line No." + 10000
        else
            PurchaseLineRecL."Line No." := 10000;

        CurrPage.SetSelectionFilter(PurchaseReqLine);
        if PurchaseReqLine.FindSet() then begin
            repeat
                PurchaseLineRecL.Init();
                PurchaseLineRecL."Document Type" := PurchHdrRecG."Document Type";
                PurchaseLineRecL."Document No." := PurchHdrRecG."No.";
                PurchaseLineRecL."Line No." := PurchaseLineRecL."Line No.";
                PurchaseLineRecL.Type := PurchaseLineRecL.Type::Item;
                PurchaseLineRecL.Validate("No.", PurchaseReqLine."Item No.");
                PurchaseLineRecL."Unit of Measure Code" := PurchaseReqLine."Unit of Measure Code";
                PurchaseLineRecL.Validate(Quantity, PurchaseReqLine.Quantity);
                PurchaseLineRecL."Requisition No.A" := PurchaseReqLine."No.";
                PurchaseLineRecL."Requisition Line No.A" := PurchaseReqLine."Line No.";
                PurchaseLineRecL."Line No." += 10000;
                PurchaseLineRecL.Insert();
                PurchaseReqLine."Purchase Order No." := PurchaseLineRecL."Document No.";
                PurchaseReqLine."Purchase Order Line No." := PurchaseLineRecL."Line No.";
                PurchaseReqLine.Modify();
            until PurchaseReqLine.Next() = 0;
        end;
    end;

    procedure SetPurchaseHeader(PurchLineRec: Record "Purchase Line")
    var
        PurchHdrRecL: Record "Purchase Header";
    begin
        PurchHdrRecL.SetRange("Document Type", PurchLineRec."Document Type");
        PurchHdrRecL.SetRange("No.", PurchLineRec."Document No.");
        if PurchHdrRecL.FindFirst() then begin
            PurchHdrRecG := PurchHdrRecL;
        end;
    end;

    var
        PurchHdrRecG: Record "Purchase Header";
}

