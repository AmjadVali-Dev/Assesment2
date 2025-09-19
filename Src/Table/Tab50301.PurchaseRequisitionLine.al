table 50301 "Purchase Requisition Line"
{
    Caption = 'Purchase Requisition Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                if ItemRec.Get("Item No.") then begin
                    Description := ItemRec.Description;
                    "Unit Of Measure Code" := ItemRec."Base Unit of Measure";
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Unit Of Measure Code"; Code[10])
        {
            Caption = 'Unit Of Measure Code';
        }
        field(6; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(7; "Requisition Date"; Date)
        {
            Caption = 'Requisition Date';
        }
        field(8; Department; Enum "Department Type")
        {
            Caption = 'Department';
        }
        field(9; Status; Enum "Status Enum")
        {
            Caption = 'Status';
        }
        field(10; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
        }
        field(11; "Purchase Order Line No."; Integer)
        {
            Caption = 'Purchase Order Line No.';
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        PurchaseReqLineL: Record "Purchase Requisition Line";
    begin
        PurchaseReqLineL.SetRange("No.", "No.");
        if PurchaseReqLineL.FindLast() then
            "Line No." := PurchaseReqLineL."Line No." + 10000
        else
            "Line No." := 10000;

    end;
}
