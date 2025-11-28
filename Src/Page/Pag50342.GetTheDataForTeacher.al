page 50342 "Get The Data For Teacher"
{
    ApplicationArea = All;
    Caption = 'Get The Data For Teacher';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(JsonText; JsonText)
            {
                Caption = 'Json Text';
            }
        }
    }
    procedure Transfer(): Text
    begin
        exit(JsonText);
    end;

    var
        JsonText: Text;

}