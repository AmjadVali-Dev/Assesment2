pageextension 50330 "Business Manager Role Exe" extends "Business Manager Role Center"
{
    actions
    {
        addlast(sections)
        {
            group("Teacher Management")
            {
                Caption = 'Teacher Management';
                Image = Education; // optional icon
                action(TeacherMaster)
                {
                    Caption = 'Teacher Master';
                    RunObject = Page "Teacher Master List";
                }

                action(TeacherOrders)
                {
                    Caption = 'Teacher Orders';
                    RunObject = Page "Teacher Order List";
                }
                action(TeacherLines)
                {
                    Caption = 'Teacher Lines';
                    RunObject = Page "Teacher Line List";
                }
                action(TeacherInvoices)
                {
                    Caption = 'Teacher Invoices';
                    RunObject = Page "Teacher Invoice List";
                }
                action(TeacherInvoiceLines)
                {
                    Caption = 'Teacher Invoice Lines';
                    RunObject = Page "Teacher Invoice Line List";
                }
                action(PostedTeacherInvoices)
                {
                    Caption = 'Posted Teacher Invoices';
                    RunObject = Page "Posted Teacher Invoice List";
                }
                action(PostedTeacherInvoiceLines)
                {
                    Caption = 'Posted Teacher Invoice Lines';
                    RunObject = Page "Posted Invoice Line List";
                }

                action(TeacherShipments)
                {
                    Caption = 'Teacher Shipments';
                    RunObject = Page "Teacher Shipment List";
                }
                action(TeacherShipmentLines)
                {
                    Caption = 'Teacher Shipment Lines';
                    RunObject = Page "Teacher Shipment Line List";
                }
                action(SubjectMaster)
                {
                    Caption = 'Subject Master';
                    RunObject = Page "Subject Master List";
                }
            }
        }
    }
}
