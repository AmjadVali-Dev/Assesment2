report 50300 "Purchase Requisation Report A"
{
    Caption = 'Purchase Requisation Report A';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\PurchaseRequisationreportA.rdl';
    dataset
    {
        //Hello this is little Change I made
        dataitem("Purchase Requisition Header"; "Purchase Requisition Header")
        {
            column(No_; "No.") { }
            column(Requisition_Date; "Requisition Date") { }
            column(Released_By; "Released By") { }
            column(Released_Date; "Released Date") { }
            column(Released_Time; "Released Time") { }
            column(Department; Department) { }
            column(Purpose; Purpose) { }
            column(Created_By; "Created By") { }
            column(Created_Date; "Created Date") { }
            column(Created_Time; "Created Time") { }
            column(Status; Status) { }
            dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                DataItemLink = "No." = field("No.");
                column(Item_No_; "Item No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Of_Measure_Code; "Unit Of Measure Code") { }

            }
        }
    }
}