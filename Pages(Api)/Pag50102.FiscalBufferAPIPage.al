page 50102 "Fiscal Buffer API Page"
{
    APIGroup = 'apiFiscal';
    APIPublisher = 'EIPSOFTART';
    APIVersion = 'v1.0';
    Caption = 'fiscalBufferAPIPage';
    DelayedInsert = true;
    EntityName = 'fiscalBuffer';
    EntitySetName = 'fiscalBuffers';
    PageType = API;
    SourceTable = "Fiscal Buffer";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(invoiceNo; Rec."Invoice No")
                {
                    Caption = 'Invoice No';
                }
                field(requestID; Rec."Request ID")
                {
                    Caption = 'Request ID';
                }
                field(isPrinted; Rec.IsPrinted)
                {
                    Caption = 'IsPrinted';
                }
                field(invoiceContent; Rec.InvoiceContent)
                {
                    Caption = 'InvoiceContent';
                }
                field(printerID; Rec."Printer ID")
                {
                    Caption = 'Printer ID';
                }
                field(fiscalRcptNo; Rec."Fiscal Rcpt No")
                {
                    Caption = 'Fiscal Rcpt No';
                }
                field(fiscalPrintDate; Rec."Fiscal Print Date")
                {
                    Caption = 'Fiscal Print Date';
                }
                field(fiscalRequestDate; Rec."Fiscal Request Date")
                {
                    Caption = 'Fiscal Request Date';
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        fiscalBuffer: Record "Fiscal Buffer";
    begin

    end;
}
