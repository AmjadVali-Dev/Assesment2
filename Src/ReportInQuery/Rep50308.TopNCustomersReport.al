report 50308 "Top N Customers Report"
{
    ApplicationArea = All;
    Caption = 'Top N Customers Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src/ReportInQuery/Rep50308.TopNCustomersReport.rdl';
    dataset
    {
        dataitem(Integer; Integer)// this is Like a dummy dataitem to drive the report
        {
            DataItemTableView = sorting(Number);
            column(customerNo; customerNo) { }
            column(customerName; customerName) { }
            column(customerBalance; customerBalance) { }

            column(city; city) { }


            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, TopN);
                TopNCustomers.TopNumberOfRows(TopN);
                TopNCustomers.open();
            end;

            trigger OnAfterGetRecord()
            begin
                if TopNCustomers.Read() then begin
                    customerNo := TopNCustomers.No;
                    customerName := TopNCustomers.Name;
                    customerBalance := TopNCustomers.BalanceLCY;
                    city := TopNCustomers.City;
                end
                else begin
                    CurrReport.Skip();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(TopN; TopN)
                    {
                        Caption = 'Top Records which you like to generate a report:';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        TopN := 5;
    end;

    var
        TopNCustomers: Query "Top N Customers";
        TopN: Integer;
        customerNo: Code[20];
        customerName: Text;
        customerBalance: Decimal;
        city: Text;
}