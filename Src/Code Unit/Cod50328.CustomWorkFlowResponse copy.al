// codeunit 50328 "Custom WorkFlow Response"
// {

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
//     local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CustomHdr: Record "Custom Header";
//     begin
//         if RecRef.Number = Database::"Custom Header" then begin
//             RecRef.SetTable(CustomHdr);
//             CustomHdr.Status := CustomHdr.Status::Open;
//             CustomHdr.Modify();
//             Handled := true;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
//     local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CustomHdr: Record "Custom Header";
//     begin
//         if RecRef.Number = Database::"Custom Header" then begin
//             RecRef.SetTable(CustomHdr);
//             CustomHdr.Status := CustomHdr.Status::Released;
//             CustomHdr.Modify();
//             Handled := true;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
//     local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         CustomHdr: Record "Custom Header";
//     begin
//         if RecRef.Number = Database::"Custom Header" then begin
//             RecRef.SetTable(CustomHdr);
//             CustomHdr.Status := CustomHdr.Status::"Pending Approval";
//             CustomHdr.Modify();
//             IsHandled := true;
//         end;
//     end;

//     // You never call this procedure.
//     // Business Central’s Workflow Engine calls it automatically while building the workflow system.
//     // This is called a callback.

//     //     foreach ResponseCode in AllWorkflowResponseCodes do begin
//     //     OnAddWorkflowResponsePredecessorsToLibrary(ResponseCode);
//     //      end;
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
//     local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
//     begin
//         case ResponseFunctionName of
//             workflowResponseHandling.SetStatusToPendingApprovalCode():
//                 workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.SetStatusToPendingApprovalCode(), workflowHandling.RunWorkflowOnSendforApprovalCode());
//             workflowResponseHandling.CancelAllApprovalRequestsCode():
//                 workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.CancelAllApprovalRequestsCode(), workflowHandling.RunWorkflowOnCancelforApprovalCode());
//             workflowResponseHandling.OpenDocumentCode():
//                 workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.OpenDocumentCode(), workflowHandling.RunWorkflowOnSendforApprovalCode());
//         end
//     end;

//     var
//         WorkflowResponseHandling: Codeunit "Workflow Response Handling";
//         WorkflowHandling: Codeunit "Custom WorkFlow Event Handler";

// }


codeunit 50328 "Custom WorkFlow Response"
{

    // ------------------------------------------------------------
    // RESPONSE: Open Document
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - When a workflow response is "Open Document"
    // - Used after REJECT or CANCEL approval
    //
    // WHEN THIS RUNS:
    // - Approver clicks Reject
    // - User cancels approval request
    //
    // WHO CALLS THIS:
    // - Workflow Response Handling (STANDARD BC)
    //
    // WHAT IT DOES:
    // - Sets Custom Header status back to Open
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Response Handling",
        'OnOpenDocument',
        '',
        false,
        false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomHdr: Record "Custom Header";
    begin
        // Check that the response is for Custom Header table
        if RecRef.Number = Database::"Custom Header" then begin

            // Convert generic RecordRef into strongly-typed record
            RecRef.SetTable(CustomHdr);

            // Apply business logic
            CustomHdr.Status := CustomHdr.Status::Open;
            CustomHdr.Modify();

            // Tell BC: "I handled this response, do not run default logic"
            Handled := true;
        end;
    end;


    // ------------------------------------------------------------
    // RESPONSE: Release Document
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - When approval is COMPLETED successfully
    //
    // WHEN THIS RUNS:
    // - Approver clicks Approve
    //
    // WHO CALLS THIS:
    // - Workflow Response Handling
    //
    // WHAT IT DOES:
    // - Sets document status to Released
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Response Handling",
        'OnReleaseDocument',
        '',
        false,
        false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomHdr: Record "Custom Header";
    begin
        // Ensure response applies to Custom Header
        if RecRef.Number = Database::"Custom Header" then begin

            // Convert RecordRef to Custom Header
            RecRef.SetTable(CustomHdr);

            // Mark document as approved
            CustomHdr.Status := CustomHdr.Status::Released;
            CustomHdr.Modify();

            // Stop default BC behavior
            Handled := true;
        end;
    end;


    // ------------------------------------------------------------
    // RESPONSE: Set Status to Pending Approval
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - When approval request is CREATED
    //
    // WHEN THIS RUNS:
    // - User clicks Send Approval Request
    // - Approval Entry is inserted
    //
    // WHO CALLS THIS:
    // - Approvals Mgmt. (STANDARD BC)
    //
    // WHAT IT DOES:
    // - Sets document status to Pending Approval
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Approvals Mgmt.",
        OnSetStatusToPendingApproval,
        '',
        false,
        false)]
    local procedure OnSetStatusToPendingApproval(
        RecRef: RecordRef;
        var Variant: Variant;
        var IsHandled: Boolean)
    var
        CustomHdr: Record "Custom Header";
    begin
        // Ensure approval applies to Custom Header
        if RecRef.Number = Database::"Custom Header" then begin

            // Convert RecordRef to Custom Header
            RecRef.SetTable(CustomHdr);

            // Update status
            CustomHdr.Status := CustomHdr.Status::"Pending Approval";
            CustomHdr.Modify();

            // Tell BC: custom logic handled status update
            IsHandled := true;
        end;
    end;


    // ------------------------------------------------------------
    // RESPONSE PREDECESSOR REGISTRATION (SETUP TIME ONLY)
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To define WHICH workflow event must happen
    //   BEFORE a workflow response is allowed
    //
    // VERY IMPORTANT:
    // - You NEVER call this procedure
    // - Workflow Engine calls it automatically
    //
    // WHEN THIS RUNS:
    // - Workflow system initialization
    // - Workflow validation
    //
    // WHAT IT CONTROLS:
    // - Prevents invalid response execution
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Response Handling",
        'OnAddWorkflowResponsePredecessorsToLibrary',
        '',
        false,
        false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(
        ResponseFunctionName: Code[128])
    begin
        case ResponseFunctionName of

            // "Set Pending Approval" can run ONLY after Send Approval event
            WorkflowResponseHandling.SetStatusToPendingApprovalCode():
                WorkflowResponseHandling.AddResponsePredecessor(
                    WorkflowResponseHandling.SetStatusToPendingApprovalCode(),
                    WorkflowHandling.RunWorkflowOnSendforApprovalCode());

            // "Cancel All Approvals" allowed ONLY after Cancel event
            WorkflowResponseHandling.CancelAllApprovalRequestsCode():
                WorkflowResponseHandling.AddResponsePredecessor(
                    WorkflowResponseHandling.CancelAllApprovalRequestsCode(),
                    WorkflowHandling.RunWorkflowOnCancelforApprovalCode());

            // "Open Document" allowed ONLY after Send Approval
            WorkflowResponseHandling.OpenDocumentCode():
                WorkflowResponseHandling.AddResponsePredecessor(
                    WorkflowResponseHandling.OpenDocumentCode(),
                    WorkflowHandling.RunWorkflowOnSendforApprovalCode());
        end
    end;


    // ------------------------------------------------------------
    // VARIABLES
    // ------------------------------------------------------------
    // WorkflowResponseHandling:
    // - Executes workflow responses
    //
    // WorkflowHandling:
    // - Provides event codes for predecessor linking
    //
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowHandling: Codeunit "Custom WorkFlow Event Handler";

}
