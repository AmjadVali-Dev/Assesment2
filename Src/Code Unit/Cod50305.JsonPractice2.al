codeunit 50305 "Json Practice 2"
{
    procedure JsonCreation()
    var
        JSonArrayRec: JsonArray;
        JsonObjectRec: JsonObject;
    begin
        JsonObjectRec.Add('Name', 'Amjad Vali');
        JsonObjectRec.Add('Age', 22);
        JsonObjectRec.Add('Course', 'ECE');

        JSonArrayRec.Add(22);
        JSonArrayRec.Add(23);
        JSonArrayRec.Add(24);

        JsonObjectRec.Add('Marks', JSonArrayRec);
        Message(Format(JsonObjectRec));
    end;

    procedure CreatePurchaseHeader(PurchaseHeaderRec: Record "Purchase Header"): Text
    var
        JsonArray: JsonArray;
        JSonObject: JsonObject;
        HeaderJsonObject: JsonObject;
        LineJsonObject: JsonObject;
        PurchaseLineRec: Record "Purchase Line";
    begin
        HeaderJsonObject.Add('Document Type', PurchaseHeaderRec."Document Type".AsInteger());
        HeaderJsonObject.Add('Vendor No', PurchaseHeaderRec."Buy-from Vendor No.");
        HeaderJsonObject.Add('No', PurchaseHeaderRec."No.");
        HeaderJsonObject.Add('Posting Date', PurchaseHeaderRec."Posting Date");


        PurchaseLineRec.SetRange("Document Type", PurchaseHeaderRec."Document Type");
        PurchaseLineRec.SetRange("Document No.", PurchaseHeaderRec."No.");
        if PurchaseLineRec.FindSet() then begin
            repeat
                Clear(LineJsonObject);
                LineJsonObject.Add('Line No', PurchaseLineRec."Line No.");
                LineJsonObject.Add('Type', PurchaseLineRec.Type.AsInteger());
                LineJsonObject.Add('No', PurchaseLineRec."No.");
                LineJsonObject.Add('Quantity', PurchaseLineRec.Quantity);
                JsonArray.Add(LineJsonObject);
            until PurchaseLineRec.Next() = 0;
        end;
        HeaderJsonObject.Add('Lines', JsonArray);
        JsonObject.Add('Status', 'Success');
        JsonObject.Add('Message', 'Data retrieved Successfully');
        JsonObject.Add('Data', HeaderJsonObject);
        exit(Format(JsonObject));
    end;

    procedure ReadCOmplexJson(JsonString: Text)
    var
        JsonObjectRec: JsonObject;
        JsonOrder: JsonObject;
        jsonArrayLines: JsonArray;
        jsonTokenLines: JsonToken;
        JsonTokenType: JsonToken;
        jsonTokenValue: JsonToken;
        DocType: Integer;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        instr: InStream;
    begin
        if JsonObjectRec.ReadFrom(JsonString) then begin
            JsonObjectRec.Get('Data', jsonTokenValue);
            JsonOrder := jsonTokenValue.AsObject();

            JsonOrder.Get('Document Type', JsonTokenValue);
            DocType := JsonTokenValue.AsValue().AsInteger();

            JsonOrder.Get('Lines', JsonTokenLines);
            JsonArrayLines := JsonTokenLines.AsArray();

            JsonOrder.Get('Lines', JsonTokenLines);
            JsonArrayLines := JsonTokenLines.AsArray();

            foreach JsonTokenLines in JsonArrayLines do begin
                Message(Format(JsonTokenLines));
            end;
            Message('Document Type %1', DocType);

            FileName := 'Purchase Order_' + Format(DocType) + '.json';
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            OutStr.WriteText(Format(JsonObjectRec));
            TempBlob.CreateInStream(InStr, TextEncoding::UTF8);

            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;
}
