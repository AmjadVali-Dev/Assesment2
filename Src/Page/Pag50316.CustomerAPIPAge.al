page 50316 "Customer API PAge"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Amjad';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'customerAPIPAge';
    DelayedInsert = true;
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    PageType = API;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
            }
        }
    }
}
