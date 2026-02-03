codeunit 50327 "Custom WorkFlow Event Handler"
{
    // ------------------------------------------------------------
    // Returns the WORKFLOW EVENT CODE for "Send for Approval"
    // ------------------------------------------------------------
    // WHY:
    // - Workflow Engine works ONLY with TEXT event codes
    // - Not with procedure names
    //
    // WHERE USED:
    // - Workflow setup (50329) to STORE event in workflow tables
    // - Runtime (HandleEvent) to MATCH and execute workflow
    //
    // IMPORTANT:
    // - This text must EXACTLY match what is stored in workflow
    //
    procedure RunWorkflowOnSendforApprovalCode(): Text[128]
    begin
        exit('RUNWORKFLOWONSENDFORAPPROVAL');
    end;


    // ------------------------------------------------------------
    // Returns the WORKFLOW EVENT CODE for "Cancel Approval"
    // ------------------------------------------------------------
    // WHY:
    // - Used when user cancels approval request
    //
    // WHERE USED:
    // - Workflow setup (50329)
    // - Runtime cancellation flow
    //
    procedure RunWorkflowOnCancelforApprovalCode(): Text[128]
    begin
        exit('RUNWORKFLOWONCANCELFORAPPROVAL');
    end;


    // ------------------------------------------------------------
    // Registers CUSTOM WORKFLOW EVENTS into Workflow Event Library
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - Business Central must KNOW which workflow events exist
    // - Without this, workflow UI cannot show your events
    //
    // WHEN THIS RUNS:
    // - Extension install
    // - Workflow setup initialization
    // - Opening Workflow page
    //
    // WHAT IT DOES:
    // - Adds "Send for Approval" and "Cancel Approval" events
    //   into the workflow system
    //
    // IMPORTANT:
    // - This is SETUP TIME only
    // - NOT triggered by button click
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Event Handling",
        'OnAddWorkflowEventsToLibrary',
        '',
        true,
        true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        // Registers Send for Approval event
        WorkflowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendforApprovalCode(),  // Event Code
            Database::"Custom Header",           // Table this event applies to
            WorkflowSendForApproval,             // Caption shown in UI
            0,                                   // Category index (default)
            false);                              // Not a manual event

        // Registers Cancel Approval event
        WorkflowEventHandling.AddEventToLibrary(
            RunWorkflowOnCancelforApprovalCode(),
            Database::"Custom Header",
            WorkflowCancel,
            0,
            false);
    end;


    // ------------------------------------------------------------
    // SUBSCRIBER: Triggered when user clicks "Send Approval Request"
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To CONNECT the UI event (50326) to the Workflow Engine
    //
    // WHERE IT IS TRIGGERED FROM:
    // - Raised by codeunit 50326
    //
    // WHAT IT DOES:
    // - Tells Workflow Engine:
    //   "This workflow event just happened for this record"
    //
    // THIS IS THE EXACT POINT WHERE WORKFLOW EXECUTION STARTS
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Custom Approval Workflow Mgmt",
        'OnSendRequestForApproval',
        '',
        false,
        false)]
    local procedure OnSendRequestForApproval(var CustomHdr: Record "Custom Header")
    begin
        WorkflowMgnt.HandleEvent(
            RunWorkflowOnSendforApprovalCode(), // Event code
            CustomHdr);                         // Record instance
    end;


    // ------------------------------------------------------------
    // SUBSCRIBER: Triggered when user clicks "Cancel Approval Request"
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To inform Workflow Engine about approval cancellation
    //
    // WHERE IT IS TRIGGERED FROM:
    // - Raised by codeunit 50326
    //
    // WHAT IT DOES:
    // - Workflow Engine will execute cancel-related responses
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Custom Approval Workflow Mgmt",
        'OnCancelRequestForApproval',
        '',
        false,
        false)]
    local procedure OnCancelRequestForApproval(var CustomHdr: Record "Custom Header")
    begin
        WorkflowMgnt.HandleEvent(
            RunWorkflowOnCancelforApprovalCode(),
            CustomHdr);
    end;


    // ------------------------------------------------------------
    // Defines VALID ORDER of workflow events (Event Predecessors)
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To prevent invalid workflow sequences
    //
    // EXAMPLES:
    // - Cancel Approval is allowed ONLY after Send Approval
    // - Approve / Reject allowed ONLY after Send Approval
    //
    // WHEN THIS RUNS:
    // - Workflow system initialization
    // - Workflow validation
    //
    // THIS DOES NOT EXECUTE WORKFLOW
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Event Handling",
        OnAddWorkflowEventPredecessorsToLibrary,
        '',
        false,
        false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of

            // Cancel can happen only after Send for Approval
            RunWorkflowOnCancelforApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(
                    RunWorkflowOnCancelforApprovalCode(),
                    RunWorkflowOnSendforApprovalCode);

            // Reject / Approve can happen only after Send for Approval
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(
                    WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(),
                    RunWorkflowOnSendforApprovalCode());
        end;
    end;


    // ------------------------------------------------------------
    // Checks whether workflow is ENABLED for this record
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - Used by UI to enable/disable "Send Approval" button
    //
    // WHERE USED:
    // - Page logic
    //
    procedure IsWorkflowApprovalEnabled(var CustomHdr: Record "Custom Header"): Boolean
    begin
        exit(
            WorkflowMgnt.CanExecuteWorkflow(
                CustomHdr,
                RunWorkflowOnSendforApprovalCode()));
    end;


    // ------------------------------------------------------------
    // Checks whether approval can be sent NOW
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - Prevent sending approval in invalid status
    //
    // RULE:
    // - Document must be Open
    //
    procedure IsWorkflowApprovalPending(var CustomHdr: Record "Custom Header"): Boolean
    begin
        exit(IsWorkflowApprovalEnabled(CustomHdr));
        if (CustomHdr.Status <> CustomHdr.Status::Open) then
            exit(false);
    end;


    // ------------------------------------------------------------
    // FINAL VALIDATION before sending approval
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To throw clear error if no workflow exists
    //
    // WHERE USED:
    // - Called before Send Approval
    //
    procedure CheckInComingApprovalEnabled(var CustomHdr: Record "Custom Header"): Boolean
    begin
        if not IsWorkflowApprovalPending(CustomHdr) then
            Error(WorkflowExist);

        exit(true);
    end;


    // ------------------------------------------------------------
    // VARIABLES
    // ------------------------------------------------------------
    // WorkflowMgnt:
    // - Core engine that MATCHES and RUNS workflows
    //
    // WorkflowEventHandling:
    // - Registers events and their order
    //
    var
        WorkflowMgnt: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";

        // UI captions for workflow events
        WorkflowSendForApproval: Label 'Custom Header – Request Sent For Approval';
        WorkflowCancel: Label 'Custom Header – Request Cancelled';

        // Error message when no workflow exists
        WorkflowExist: Label 'No Workflow for this Document';
}
