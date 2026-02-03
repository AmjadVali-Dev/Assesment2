pageextension 50335 "Request To Approve Ext" extends "Requests to Approve"
{
    actions
    {
        // modify(Delegate)
        // {
        //     Visible = false;
        // }

        addafter(Reject)
        {
            action("Advanced Delegate")
            {
                ApplicationArea = All;
                Caption = 'Advanced Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    DelegateDialog: Page "Advanced Delegate Dialog";
                    SelectedOption: Enum "Delegation Option";
                    CustomApproveDelegate: Codeunit "Advanced Delegation Management";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    AdvDelegate: Codeunit "Advance Delegation Management2";
                begin
                    if DelegateDialog.RunModal() <> Action::OK then
                        exit;

                    SelectedOption := DelegateDialog.GetDelegationOption();
                    CurrPage.SetSelectionFilter(ApprovalEntry);

                    case SelectedOption of
                        SelectedOption::ApproveAndDelegate:
                            begin
                                // Note: We no longer pass the hardcoded ID. 
                                // The Codeunit finds it from the Approval User Setup automatically.
                                CustomApproveDelegate.ApproveAndCreateDelegate(ApprovalEntry);
                            end;
                        SelectedOption::SendWithoutApproval:
                            begin
                                ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                            end;

                        SelectedOption::DelegateAndReturnToMe:
                            begin
                                CurrPage.SetSelectionFilter(ApprovalEntry);
                                if not ApprovalEntry.IsEmpty() then begin
                                    AdvDelegate.DelegateToConsultant(ApprovalEntry);
                                    CurrPage.Update(true);
                                    Message('The request has been handed over to AMYA. It will return to you after her approval.');
                                end;
                            end;
                    end;
                end;

            }

        }
    }
}