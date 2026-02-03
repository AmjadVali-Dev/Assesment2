codeunit 50326 "Custom Approval Workflow Mgmt"
{
    // ------------------------------------------------------------
    // IntegrationEvent: OnSendRequestForApproval
    // ------------------------------------------------------------
    // WHY this event exists:
    // - To announce that the user has clicked "Send Approval Request"
    // - To decouple UI (page action) from workflow logic
    //
    // WHAT this event does:
    // - It does NOT execute workflow
    // - It does NOT create approval entries
    // - It only broadcasts an event
    //
    // WHERE it is raised from:
    // - Called from the FRONT END (page action OnAction trigger)
    //
    // WHO listens to it:
    // - Codeunit 50327 "Custom Workflow Event Handler"
    //
    // WHAT happens next:
    // - Subscribers decide what to do (connect to workflow engine)
    //
    [IntegrationEvent(false, false)]
    procedure OnSendRequestForApproval(var CustomHdr: Record "Custom Header")
    begin
        // No code here by design.
        // This is an event publisher (fire-and-forget).
    end;


    // ------------------------------------------------------------
    // IntegrationEvent: OnCancelRequestForApproval
    // ------------------------------------------------------------
    // WHY this event exists:
    // - To announce that the user has clicked "Cancel Approval Request"
    //
    // WHAT this event does:
    // - Does NOT cancel approvals by itself
    // - Does NOT change document status
    //
    // WHERE it is raised from:
    // - Called from FRONT END (Cancel Approval button)
    //
    // WHO listens to it:
    // - Codeunit 50327 "Custom Workflow Event Handler"
    //
    // WHAT happens next:
    // - Workflow engine is notified via subscriber
    //
    [IntegrationEvent(false, false)]
    procedure OnCancelRequestForApproval(var CustomHdr: Record "Custom Header")
    begin
        // No logic here intentionally.
        // Event only announces cancellation intent.
    end;
}
