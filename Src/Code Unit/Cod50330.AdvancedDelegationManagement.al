codeunit 50330 "Advanced Delegation Management"
{
    Permissions = TableData "Approval Entry" = rimd;

    procedure ApproveAndCreateDelegate(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DelegateUserId: Code[50];
    begin
        // 1. Get the Delegate (Substitute) dynamically based on the current user
        DelegateUserId := GetSubstitute(UserId());
        if ApprovalEntry.FindSet() then begin
            repeat
                ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                CreateNewApprovalEntry(ApprovalEntry, DelegateUserId);
            until ApprovalEntry.Next() = 0;
        end;
    end;

    local procedure GetSubstitute(CurrentUserId: Code[50]): Code[50]
    var
        UserSetup: Record "User Setup";
    begin
        // Find the record for the current user in Approval User Setup
        if UserSetup.Get(CurrentUserId) then begin
            if UserSetup.Substitute <> '' then
                exit(UserSetup.Substitute);
        end;
        Error('No Substitute (Delegate) has been configured for user %1 in User Setup.', CurrentUserId);
    end;

    local procedure CreateNewApprovalEntry(OldEntry: Record "Approval Entry"; NewApprover: Code[50])
    var
        NewEntry: Record "Approval Entry";
        LastEntry: Record "Approval Entry";
    begin
        LastEntry.Reset();
        if LastEntry.FindLast() then;
        NewEntry.Init();
        NewEntry."Entry No." := LastEntry."Entry No." + 1;
        NewEntry."Table ID" := OldEntry."Table ID";
        NewEntry."Document Type" := OldEntry."Document Type";
        NewEntry."Document No." := OldEntry."Document No.";
        NewEntry."Record ID to Approve" := OldEntry."Record ID to Approve";
        NewEntry."Approver ID" := NewApprover;
        NewEntry."Sender ID" := UserId();
        NewEntry.Status := NewEntry.Status::Open;
        NewEntry."Date-Time Sent for Approval" := CurrentDateTime;
        NewEntry."Sequence No." := OldEntry."Sequence No." + 1;
        NewEntry.Insert(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnAfterRejectSelectedApprovalRequest, '', false, false)]
    local procedure OnAfterRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        CustomHdr: Record "Custom Header";
        RecRef: RecordRef;
    begin
        // Only for Custom Header
        if ApprovalEntry."Table ID" <> Database::"Custom Header" then
            exit;
        // Use RecordId (CORRECT WAY)
        RecRef.Get(ApprovalEntry."Record ID to Approve");
        // Convert RecordRef → Record
        RecRef.SetTable(CustomHdr);
        // Update status
        CustomHdr.Status := CustomHdr.Status::Open;
        CustomHdr.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnAfterRejectSelectedApprovalRequest, '', false, false)]
    local procedure OnAfterRejectApprovalRequest3(var ApprovalEntry: Record "Approval Entry")
    var
        PurchaseHeader: Record "Purchase Header";
        RecRef: RecordRef;
    begin
        // Only for Purchase Header
        if ApprovalEntry."Table ID" <> Database::"Purchase Header" then
            exit;
        // Use RecordId (CORRECT WAY)
        RecRef.Get(ApprovalEntry."Record ID to Approve");
        // Convert RecordRef → Record
        RecRef.SetTable(PurchaseHeader);
        // Update status
        PurchaseHeader.Status := PurchaseHeader.Status::Open;
        PurchaseHeader.Modify();
    end;
}

