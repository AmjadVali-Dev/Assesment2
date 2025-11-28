codeunit 50315 "Transfer Fields 2"
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromPurchHeader, '', false, false)]
    procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Field Testing" := PurchaseHeader."Field Testing"
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchHeader, '', false, false)]
    procedure OnAfterCopyItemJnlLineFromPurchHeader(PurchHeader: Record "Purchase Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Field Testing" := PurchHeader."Field Testing";
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Field Testing" := GenJournalLine."Field Testing";
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", OnAfterCopyFromGenJnlLine, '', false, false)]
    procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")
    begin
        VATEntry."Field Testing" := GenJournalLine."Field Testing";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterCopyTrackingFromItemJnlLine, '', false, false)]
    procedure OnAfterCopyTrackingFromItemJnlLine(ItemJnlLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Field Testing" := ItemJnlLine."Field Testing";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry."Field Testing" := GenJournalLine."Field Testing";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitValueEntry, '', false, false)]
    procedure OnAfterInitValueEntry(var ItemJournalLine: Record "Item Journal Line"; var ValueEntry: Record "Value Entry")
    begin
        ValueEntry."Field Testing" := ItemJournalLine."Field Testing";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertDtldVendLedgEntry, '', false, false)]
    procedure OnBeforeInsertDtldVendLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
        DtldVendLedgEntry."Field Testing" := GenJournalLine."Field Testing";
    end;
}
