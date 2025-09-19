codeunit 50302 DeleteNote
{
    procedure DeleteNotes(CustomerRec: Record Customer)
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.SetRange("Record ID", CustomerRec.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);

        if RecordLink.FindSet() then begin
            repeat
                RecordLink.Delete();
            until RecordLink.Next() = 0;
            Message('All notes deleted for customer %1', CustomerRec."No.");
        end else
            Message('No notes found for customer %1', CustomerRec."No.");
    end;
}
