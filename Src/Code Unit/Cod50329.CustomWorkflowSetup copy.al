// codeunit 50329 "Custom Workflow Setup"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAddWorkflowCategoriesToLibrary, '', false, false)]
//     local procedure OnAddWorkflowCategoriesToLibrary()
//     begin
//         WorkflowSetup.InsertWorkflowCategory(WorkflowCategoryCode, WorkflowCategoryDes);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAfterInsertApprovalsTableRelations, '', false, false)]
//     local procedure OnAfterInsertApprovalsTableRelations()
//     begin
//         WorkflowSetup.InsertTableRelation(Database::"Custom Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnInsertWorkflowTemplates, '', false, false)]
//     local procedure OnInsertWorkflowTemplates()
//     begin
//         InsertCustomHeaderTemplate();
//     end;

//     local procedure InsertCustomHeaderTemplate()
//     var
//         Workflow: Record Workflow;
//     begin
//         WorkflowSetup.InsertWorkflowTemplate(Workflow, WorkflowTemplateCode, WorkflowTemplateDesc, WorkflowCategoryCode);
//         InsertWorkflowSteps(Workflow);
//         WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
//     end;

//     local procedure InsertWorkflowSteps(var Workflow: Record Workflow)
//     var
//         WorkflowStepArgument: Record "Workflow Step Argument";
//         BlankDateFormula: DateFormula;
//         WorkflowEventHandling: Codeunit "Custom WorkFlow Event Handler";
//         CustomHdr: Record "Custom Header";
//     begin
//         Clear(WorkflowStepArgument);
//         WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
//         WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildCustomHeaderCondition(CustomHdr.Status::Open), WorkflowEventHandling.RunWorkflowOnSendforApprovalCode(), BuildCustomHeaderCondition(CustomHdr.Status::"Pending Approval"), WorkflowEventHandling.RunWorkflowOnCancelforApprovalCode(), WorkflowStepArgument, true);
//     end;

//     local procedure BuildCustomHeaderCondition(Status: Enum "Custom Doc Status"): Text
//     var
//         CustomHdr: Record "Custom Header";
//     begin
//         CustomHdr.SetRange(Status, Status);
//         exit(StrSubstNo(WorkflowCond, WorkflowSetup.Encode(CustomHdr.GetView(false))));
//     end;

//     var
//         WorkflowSetup: Codeunit "Workflow Setup";
//         ApprovalEntry: Record "Approval Entry";
//         WorkflowCategoryCode: Label 'CUSTOMREQ';
//         WorkflowCategoryDes: Label 'Custom Requisition';

//         WorkflowTemplateCode: Label 'CUSTOMREQ01';
//         WorkflowTemplateDesc: Label 'Custom Requisition Approval Workflow';

//         WorkflowCond: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Custom Header">%1</DataItem></DataItems></ReportParameters>', Locked = true;
// }

codeunit 50329 "Custom Workflow Setup"
{
    // ------------------------------------------------------------
    // Adds a CUSTOM WORKFLOW CATEGORY to the Workflow system
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To group custom workflows under a meaningful category
    //
    // WHEN THIS RUNS:
    // - Workflow system initialization
    // - Opening Workflow page
    //
    // WHERE YOU SEE IT:
    // - Workflow page → Category = "Custom Requisition"
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Setup",
        OnAddWorkflowCategoriesToLibrary,
        '',
        false,
        false)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        WorkflowSetup.InsertWorkflowCategory(
            WorkflowCategoryCode,   // Category Code (internal)
            WorkflowCategoryDes);   // Category Description (UI)
    end;


    // ------------------------------------------------------------
    // Enables APPROVALS for Custom Header table
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - Workflow approvals use the "Approval Entry" table
    // - System must know how Custom Header links to Approval Entry
    //
    // WHEN THIS RUNS:
    // - Workflow setup initialization
    //
    // WHAT IT ENABLES:
    // - Approval Entry creation for Custom Header records
    //
    // WITHOUT THIS:
    // - Approval requests will FAIL
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Setup",
        OnAfterInsertApprovalsTableRelations,
        '',
        false,
        false)]
    local procedure OnAfterInsertApprovalsTableRelations()
    begin
        WorkflowSetup.InsertTableRelation(
            Database::"Custom Header",               // Source table
            0,                                       // Primary key index
            Database::"Approval Entry",              // Target table
            ApprovalEntry.FieldNo("Record ID to Approve"));
    end;


    // ------------------------------------------------------------
    // Inserts WORKFLOW TEMPLATE automatically
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To provide a ready-made workflow template
    // - User can enable it instead of creating from scratch
    //
    // WHEN THIS RUNS:
    // - Workflow setup initialization
    //
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Workflow Setup",
        OnInsertWorkflowTemplates,
        '',
        false,
        false)]
    local procedure OnInsertWorkflowTemplates()
    begin
        InsertCustomHeaderTemplate();
    end;


    // ------------------------------------------------------------
    // Creates the WORKFLOW TEMPLATE HEADER
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - To define workflow identity (code, description, category)
    //
    // WHAT IT DOES:
    // - Inserts Workflow record
    // - Adds steps
    // - Marks it as template
    //
    local procedure InsertCustomHeaderTemplate()
    var
        Workflow: Record Workflow;
    begin
        // Create workflow template header
        WorkflowSetup.InsertWorkflowTemplate(
            Workflow,
            WorkflowTemplateCode,   // Template Code
            WorkflowTemplateDesc,   // Template Description
            WorkflowCategoryCode);  // Category

        // Add workflow steps (events + responses)
        InsertWorkflowSteps(Workflow);

        // Mark as template (not active workflow yet)
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;


    // ------------------------------------------------------------
    // Defines WORKFLOW STEPS (core logic)
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - This is the HEART of workflow behavior
    //
    // WHAT IT DEFINES:
    // - Which event starts the workflow
    // - Which condition must be true
    // - Which responses will execute
    //
    local procedure InsertWorkflowSteps(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowEventHandling: Codeunit "Custom WorkFlow Event Handler";
        CustomHdr: Record "Custom Header";
    begin
        // Clear previous arguments
        Clear(WorkflowStepArgument);

        // Initialize approver configuration
        WorkflowSetup.InitWorkflowStepArgument(
            WorkflowStepArgument,
            WorkflowStepArgument."Approver Type"::Approver,
            WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
            0,                      // Approval limit
            '',                     // No specific approver
            BlankDateFormula,       // No due date
            true);                  // Approval required

        // Insert standard document approval workflow steps
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,

            // CONDITION to START workflow
            BuildCustomHeaderCondition(CustomHdr.Status::Open),

            // EVENT that TRIGGERS workflow
            WorkflowEventHandling.RunWorkflowOnSendforApprovalCode(),

            // CONDITION after approval request
            BuildCustomHeaderCondition(CustomHdr.Status::"Pending Approval"),

            // EVENT to CANCEL workflow
            WorkflowEventHandling.RunWorkflowOnCancelforApprovalCode(),

            // Approver settings
            WorkflowStepArgument,

            // Insert responses
            true);
    end;


    // ------------------------------------------------------------
    // Builds CONDITION XML for workflow engine
    // ------------------------------------------------------------
    // WHY THIS EXISTS:
    // - Workflow engine evaluates conditions using XML
    //
    // WHAT IT DOES:
    // - Converts AL filters into encoded XML
    //
    local procedure BuildCustomHeaderCondition(
        Status: Enum "Custom Doc Status"): Text
    var
        CustomHdr: Record "Custom Header";
    begin
        // Apply filter
        CustomHdr.SetRange(Status, Status);

        // Convert filter view into encoded XML
        exit(StrSubstNo(WorkflowCond, WorkflowSetup.Encode(CustomHdr.GetView(false))));
    end;


    // ------------------------------------------------------------
    // VARIABLES
    // ------------------------------------------------------------
    var
        // Core workflow setup engine
        WorkflowSetup: Codeunit "Workflow Setup";

        // Approval Entry table reference
        ApprovalEntry: Record "Approval Entry";

        // Workflow category details
        WorkflowCategoryCode: Label 'CUSTOMREQ';
        WorkflowCategoryDes: Label 'Custom Requisition';

        // Workflow template details
        WorkflowTemplateCode: Label 'CUSTOMREQ01';
        WorkflowTemplateDesc: Label 'Custom Requisition Approval Workflow';

        // XML template used for workflow conditions
        WorkflowCond: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Custom Header">%1</DataItem></DataItems></ReportParameters>', Locked = true;
}
