page 50359 "Advanced Delegate Dialog"
{
    ApplicationArea = All;
    Caption = 'Advanced Delegate Dialog';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Choose Delegation Type';

                field(DelegationOption; DelegationOption)
                {
                    ApplicationArea = All;
                    Caption = 'Delegation Option';
                }
            }
        }
    }

    var
        DelegationOption: Enum "Delegation Option";

    procedure GetDelegationOption(): Enum "Delegation Option"
    begin
        exit(DelegationOption);
    end;
}
