codeunit 50331 "Advance Delegation Management2"
{
    Permissions = TableData "Approval Entry" = rimd;

    procedure DelegateToConsultant(var ApprovalEntry: Record "Approval Entry")
    var
        UserSetup: Record "User Setup";
        DelegateUserId: Code[50];
    begin
        if UserSetup.Get(UserId()) then
            DelegateUserId := UserSetup.Substitute;

        if DelegateUserId = '' then
            Error('No substitute found for %1.', UserId());

        if ApprovalEntry.FindSet() then
            repeat
                // 1. Change the Approver to AMYA
                ApprovalEntry."Approver ID" := DelegateUserId;
                // 2. STAMP the Sender as ALICIAT (Crucial)
                ApprovalEntry."Sender ID" := UserId();
                // 3. Mark it so we can find it later
                ApprovalEntry."Sequence No." := 99999;
                ApprovalEntry.Modify(true);
            until ApprovalEntry.Next() = 0;
    end;

    // --- THE FIX: Catch the approval BEFORE the workflow engine closes the document ---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveCatchAndReturn(var ApprovalEntry: Record "Approval Entry")
    var
        NewEntry: Record "Approval Entry";
        LastEntry: Record "Approval Entry";
        LastentryNo: Integer;
    begin
        // If this is not our special consultation, stop.
        //GUARD CONDITION.
        if ApprovalEntry."Sequence No." <> 99999 then
            exit;
        // Find the last entry number
        LastEntry.Reset();
        if LastEntry.FindLast() then begin
            LastentryNo := LastEntry."Entry No.";
        end;
        NewEntry.Init();
        NewEntry.Copy(ApprovalEntry);
        // We set the status to Approved for the CURRENT one manually 
        // to ensure we can create the NEXT one.
        NewEntry."Entry No." := LastentryNo + 1;
        // THE RETURN TRIP
        NewEntry."Approver ID" := ApprovalEntry."Sender ID"; // Back to ALibIAT
        NewEntry."Sender ID" := ApprovalEntry."Approver ID"; // From AMYA

        NewEntry.Status := NewEntry.Status::Open;
        NewEntry."Date-Time Sent for Approval" := CurrentDateTime;
        NewEntry."Sequence No." := 1;
        NewEntry."Last Modified By User ID" := '';
        NewEntry."Last Date-Time Modified" := 0DT;
        // INSERT WITHOUT TRIGGER to bypass recursive workflow loops
        if NewEntry.Insert(false) then begin
            // This message MUST appear for AMYA
            Message('Handing back to %1...', NewEntry."Approver ID");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnAfterRejectSelectedApprovalRequest, '', false, false)]
    local procedure OnAfterRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        SalesHeader: Record "Sales Header";
        RecRef: RecordRef;
    begin
        // Only for Sales Header
        if ApprovalEntry."Table ID" <> Database::"Sales Header" then
            exit;
        // Use RecordId (CORRECT WAY)
        RecRef.Get(ApprovalEntry."Record ID to Approve");
        // Convert RecordRef → Record
        RecRef.SetTable(SalesHeader);
        // Update status
        SalesHeader.Status := SalesHeader.Status::Open;
        SalesHeader.Modify();
    end;
}