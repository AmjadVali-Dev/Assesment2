page 50358 "Custom Order"
{
    ApplicationArea = All;
    Caption = 'Custom Order';
    PageType = Card;
    SourceTable = "Custom Header";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send For Approval")
            {
                ApplicationArea = All;
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                trigger OnAction()
                begin
                    if CustomWorkflowEventHandler.CheckInComingApprovalEnabled(Rec) then
                        CustomApprovalMgmt.OnSendRequestForApproval(Rec);
                end;
            }
            group(OrderProcessing)
            {
                Caption = 'Order Processing';
                action(ReleaseOrder)
                {
                    Caption = 'Release Order';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        Message('Order %1 has been released.', Rec."No.");
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        Message('Order %1 has been reopened.', Rec."No.");
                    end;
                }
            }
        }
    }
    var
        CustomApprovalMgmt: Codeunit "Custom Approval Workflow Mgmt";
        CustomWorkflowEventHandler: Codeunit "Custom WorkFlow Event Handler";
        CanCancelApprovalForWorkflow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanRequestApprovalForWorkflow: Boolean;
        OpenApprovalEntiesExist: Boolean;
        OpenApprovalEntriesForCurrUser: Boolean;
}
