codeunit 50301 "Requisation Management"
{
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnDeleteRecordEvent', '', false, false)]
    procedure OnDeletePOLine(var Rec: Record "Purchase Line")
    var
        ReqLine: Record "Purchase Requisition Line";
    begin
        if (Rec."Requisition No.A" <> '') and (Rec."Requisition Line No.A" <> 0) then begin
            if ReqLine.Get(Rec."Requisition No.A", Rec."Requisition Line No.A") then begin
                ReqLine.Validate("Purchase Order No.", '');
                ReqLine.Validate("Purchase Order Line No.", 0);
                ReqLine.Modify(true);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeModifyEvent', '', false, false)]
    procedure OnBeforeModifyPOLine(var Rec: Record "Purchase Line"; xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if (Rec."Requisition No.A" <> '') and (Rec."Requisition Line No.A" <> 0) then begin
            if ((Rec.Type <> xRec.Type) or (Rec."No." <> xRec."No.") or (Rec.Description <> xRec.Description) or (Rec.Quantity <> xRec.Quantity) or (Rec."Unit of Measure Code" <> xRec."Unit of Measure Code")) then
                Error('You cannot modify Type, Item No., Description, Quantity, or UoM for lines linked with Requisition.');
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchLine, '', false, false)]
    procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine."Reqiuisition No.A" := PurchLine."Requisition No.A";
        ItemJnlLine."Requision Line No.A" := PurchLine."Requisition Line No.A";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterCopyTrackingFromItemJnlLine, '', false, false)]
    procedure OnAfterCopyTrackingFromItemJnlLine(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry."Requisition No.S" := ItemJnlLine."Reqiuisition No.A";
        ItemLedgerEntry."Requisition Line No.S" := ItemJnlLine."Requision Line No.A";
    end;

    procedure ReleaseRequisition(PurchReqHeader: Record "Purchase Requisition Header")
    var
        UserSetup: Record "User Setup";
        PurchaseReqLine: Record "Purchase Requisition Line";
    begin
        if Confirm('Do you Want to Release..', true) then begin
            if UserSetup.Get(UserId) then begin
                if UserSetup."Allow Requisition ReleaseA" = true then begin
                    PurchReqHeader.Status := PurchReqHeader.Status::Released;
                    PurchReqHeader."Released By" := UserId;
                    PurchReqHeader."Released Date" := Today;
                    PurchReqHeader."Released Time" := Time;
                    PurchReqHeader.Modify();
                end
                else
                    Message('User %1 Does not has the permission to Release Document', UserSetup."User ID");
            end;
        end;
    end;
}
