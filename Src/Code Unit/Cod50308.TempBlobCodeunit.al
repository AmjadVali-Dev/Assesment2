codeunit 50308 TempBlobCodeunit
{
    procedure ExportEmployeeCSV()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        FileName := 'EmployeeData.csv';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.WriteText('ID,Name,Department' + '\n');
        OutStr.WriteText('101,Amjad,IT' + '\n');
        OutStr.WriteText('102,Alice,HR' + '\n');
        OutStr.WriteText('103,Bob,Finance' + '\n');
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;


}
