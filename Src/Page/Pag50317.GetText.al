page 50317 "Get Text"
{
    ApplicationArea = All;
    Caption = 'Get Text';
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
