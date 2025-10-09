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
        Message(Format(JSonObject));
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

    procedure JsonBuffer(jsonString: Text)
    var
        JsonBuffer: Record "JSON Buffer" temporary;
    begin
        JsonBuffer.ReadFromText(jsonString);
        Page.Run(Page::"Json Buffer ListA", JsonBuffer);
    end;


    procedure ReadWithJsonBuffer(JsonString: Text)
    var
        JsonBuffer: Record "JSON Buffer" temporary;
        SellToCustNo: Text;
        PostingDate: Date;
        LineNo: Integer;
        LineType: Text;
    begin
        JsonBuffer.ReadFromText(JsonString);
        JsonBuffer.GetPropertyValue(SellToCustNo, 'Vendor No');
        JsonBuffer.GetDatePropertyValue(PostingDate, 'Posting Date');
        Message('Sell to Cust No:%1 ', SellToCustNo);
        Message('Posting Date:%1 ', PostingDate);
        JsonBuffer.SetRange(Depth, 4);
        if JsonBuffer.FindSet() then begin
            repeat
                if JsonBuffer.Value = 'Line No' then
                    JsonBuffer.GetIntegerPropertyValue(LineNo, 'Line No');
                if JsonBuffer.Value = 'Type' then
                    JsonBuffer.GetPropertyValue(LineType, 'Type');
                Message('Line No:%1 and Line Type:%2', LineNo, LineType);
            until JsonBuffer.Next() = 0;
        end;
    end;

    procedure CreateCustomerWithShipToJson(Customer: Record Customer): Text
    var
        ShipTo: Record "Ship-to Address";
        JsonObject: JsonObject;
        JsonCustomer: JsonObject;
        JsonShipTo: JsonObject;
        JsonShipToArray: JsonArray;
        JsonText: Text;
    begin
        JsonCustomer.Add('No', Customer."No.");
        JsonCustomer.Add('Name', Customer.Name);
        JsonCustomer.Add('Address', Customer.Address);

        ShipTo.SetRange("Customer No.", Customer."No.");
        if ShipTo.FindSet() then begin
            repeat
                Clear(JsonShipTo);
                JsonShipTo.Add('Code', ShipTo.Code);
                JsonShipTo.Add('Address1', ShipTo.Address);
                JsonShipTo.Add('City1', ShipTo.City);
                JsonShipToArray.Add(JsonShipTo);
            until ShipTo.Next() = 0;
        end;
        JsonCustomer.Add('ShipToAddresses', JsonShipToArray);
        JsonObject.Add('Status', 'Success');
        JsonObject.Add('Message', 'Data retrieved Successfully');
        JsonObject.Add('Data', JsonCustomer);
        exit(Format(JsonObject));
    end;


    procedure ReadCustomerJson(JsonText: Text)
    var
        JsonMgt: Codeunit "JSON Management";
        ObjectJsonMgt: Codeunit "JSON Management";
        ArrayJsonMgt: Codeunit "JSON Management";
        JsonDataText: Text;
        ShipToJsonText: Text;
        i: Integer;
        CustomerNo: Text;
        CustomerName: Text;
        CustomerAddress: Text;
        ShipCode: Text;
        ShipAddress: Text;
        ShipCity: Text;
        CustomerRec: Record Customer;
        ShipToRec: Record "Ship-to Address";
    begin
        // Step 1: Load root JSON
        JsonMgt.InitializeObject(JsonText);

        // Step 2: Read Data object
        if JsonMgt.GetArrayPropertyValueAsStringByName('Data', JsonDataText) then begin
            ObjectJsonMgt.InitializeObject(JsonDataText);

            // Step 3: Read customer fields

            ObjectJsonMgt.GetStringPropertyValueByName('No', CustomerNo);
            ObjectJsonMgt.GetStringPropertyValueByName('Name', CustomerName);
            ObjectJsonMgt.GetStringPropertyValueByName('Address', CustomerAddress);

            Message('Customer No: %1 Name: %2 Address: %3', CustomerNo, CustomerName, CustomerAddress);

            if ObjectJsonMgt.GetArrayPropertyValueAsStringByName('ShipToAddresses', JsonDataText) then begin
                ArrayJsonMgt.InitializeCollection(JsonDataText);

                for i := 0 to ArrayJsonMgt.GetCollectionCount() - 1 do begin
                    ArrayJsonMgt.GetObjectFromCollectionByIndex(ShipToJsonText, i);
                    ObjectJsonMgt.InitializeObject(ShipToJsonText);

                    ObjectJsonMgt.GetStringPropertyValueByName('Code', ShipCode);
                    ObjectJsonMgt.GetStringPropertyValueByName('Address1', ShipAddress);
                    ObjectJsonMgt.GetStringPropertyValueByName('City1', ShipCity);

                    Message('Ship-to: %1, %2, %3', ShipCode, ShipAddress, ShipCity);
                end;
            end;
        end;
    end;




    procedure ReadSaleOrder(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        JsonMgnt: Codeunit "JSON Management";
        JsonObject: JsonObject;
        LineObject: JsonObject;
        Array: JsonArray;
        DataToken: JsonToken;
        FieldRefL: FieldRef;
        RecordRefL: RecordRef;
        i: Integer;
        DataTxt: Text[100];
    begin
        RecordRefL.GetTable(SalesHeader);
        for i := 1 to RecordRefL.FieldCount do begin
            FieldRefL := RecordRefL.FieldIndex(i);
            JsonObject.Add(FieldRefL.Name, Format(FieldRefL.Value));
        end;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then begin
            repeat
                Clear(RecordRefL);
                Clear(FieldRefL);
                Clear(LineObject);
                RecordRefL.GetTable(SalesLine);
                for i := 1 to RecordRefL.FieldCount do begin
                    FieldRefL := RecordRefL.FieldIndex(i);
                    LineObject.Add(FieldRefL.Name, Format(FieldRefL.Value));
                end;
                Array.Add(LineObject);
            until SalesLine.Next() = 0;
        end;
        JsonObject.Add('Lines', Array);
        Message(Format(JsonObject));
    end;

}

