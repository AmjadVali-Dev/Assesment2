codeunit 50304 "Json Practice"
{
    procedure CreateStudentJSON()
    var
        StudentJson: JsonObject;
        MarksArray: JsonArray;
    begin
        StudentJson.Add('StudentName', 'Ajju');
        StudentJson.Add('Age', 22);
        StudentJson.Add('Course', 'ECE');

        MarksArray.Add(85);
        MarksArray.Add(90);
        MarksArray.Add(88);

        StudentJson.Add('Marks', MarksArray);

        Message(Format(StudentJson));
    end;

    procedure CreateSalesHeaderJson(SalesHeaderRec: Record "Sales Header"): Text
    var
        JsonArrayrec: JsonArray;
        HeaderJsonObjectRec: JsonObject;
        SalesLinerec: Record "Sales Line";
        LineJsonObjectRec: JsonObject;
        JsonObject: JsonObject;
    begin
        HeaderJsonObjectRec.Add('Document Type', SalesHeaderRec."Document Type".AsInteger());
        HeaderJsonObjectRec.Add('No', SalesHeaderRec."No.");
        HeaderJsonObjectRec.Add('SellToCustNo', SalesHeaderRec."Sell-to Customer No.");
        HeaderJsonObjectRec.Add('Posting Date', SalesHeaderRec."Posting Date");

        SalesLinerec.SetRange("Document Type", SalesHeaderRec."Document Type");
        SalesLinerec.SetRange("Document No.", SalesLinerec."No.");
        if SalesLinerec.FindSet() then begin
            repeat
                LineJsonObjectRec.Add('LineNo', SalesLinerec."Line No.");
                LineJsonObjectRec.Add('Type', SalesLinerec.Type.AsInteger());
                LineJsonObjectRec.Add('No', SalesLinerec."No.");
                LineJsonObjectRec.Add('Quantity', SalesLinerec.Quantity);
                LineJsonObjectRec.Add('Unit Price', SalesLinerec."Unit Price");
                JsonArrayrec.Add(LineJsonObjectRec);
            until SalesLinerec.Next() = 0;

        end;
        HeaderJsonObjectRec.Add('Lines', JsonArrayrec);
        Message(Format(HeaderJsonObjectRec));
        JsonObject.Add('Status', 'Success');
        JsonObject.Add('Message', 'Data retrieved Successfully');
        JsonObject.Add('Data', HeaderJsonObjectRec);
        exit(Format(JsonObject));
    end;

    procedure ReadComplexJson(JsonString: Text)
    var
        JsonObject: JsonObject;
        JsonOrder: JsonObject;
        JsonTokenValue: JsonToken;
        JsonTokenType: JsonToken;
        JsonTokenLines: JsonToken;
        JsonArrayLines: JsonArray;
        DocType: Integer;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        instr: InStream;
    begin
        if JsonObject.ReadFrom(JsonString) then begin
            JsonObject.Get('Data', JsonTokenValue);
            JsonOrder := JsonTokenValue.AsObject();

            JsonOrder.Get('Document Type', JsonTokenValue);
            DocType := JsonTokenValue.AsValue().AsInteger();

            JsonOrder.Get('Lines', JsonTokenLines);
            JsonArrayLines := JsonTokenLines.AsArray();

            foreach JsonTokenLines in JsonArrayLines do begin
                Message(Format(JsonTokenLines));
            end;
            Message('Document Type %1', DocType);

            FileName := 'Order_' + Format(DocType) + '.json';
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            OutStr.WriteText(Format(JsonObject));
            TempBlob.CreateInStream(InStr, TextEncoding::UTF8);

            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;


    procedure ReadjsonBuffer(JsonString: Text)
    var
        JsonBuffer: Record "JSON Buffer" temporary;
    begin
        JsonBuffer.ReadFromText(JsonString);
        Page.Run(Page::"Json Buffer ListA", JsonBuffer);
    end;
}
