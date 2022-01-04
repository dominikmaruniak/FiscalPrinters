codeunit 50100 "Fiscal Printer Mgt"
{
    procedure CreateFiscalBufferEntry(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        fiscalBuffer: Record "Fiscal Buffer";
        invoiceInstream: InStream;
        os: OutStream;
    begin
        fiscalBuffer.Init();
        fiscalBuffer."Invoice No" := SalesInvoiceHeader."No.";
        fiscalBuffer."Request ID" := CreateGuid();
        fiscalBuffer.Insert(true);
        fiscalBuffer.IsPrinted := false;
        fiscalBuffer.InvoiceContent.CreateOutStream(os, TextEncoding::Windows);
        CreateInvoiceContentOutstream(os, SalesInvoiceHeader);
        fiscalBuffer."Fiscal Print Date" := CurrentDateTime();
        fiscalBuffer.Modify(true);

    end;

    local procedure CreateInvoiceContentOutstream(lineOutStream: OutStream; var SalesInvoiceHeader: Record "Sales Invoice Header"): OutStream
    var
        salesInvoiceLine: Record "Sales Invoice Line";
        invoiceContent: TextBuilder;
        companyInformation: Record "Company Information";
    begin
        companyInformation.Get();
        salesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        invoiceContent.AppendLine(StrSubstNo('NIP=%1', SalesInvoiceHeader."VAT Registration No."));
        if salesInvoiceLine.FindSet() then
            repeat
                invoiceContent.AppendLine(StrSubstNo('%1|%2|%3|%4|%5|%6|%7|%8',
                salesInvoiceLine."No.", salesInvoiceLine.Description, 'TEST', salesInvoiceLine."Quantity (Base)",
                salesInvoiceLine."Unit Price", salesInvoiceLine."Amount Including VAT",
                companyInformation."VAT Registration No.",
                salesInvoiceLine."Line Discount Amount"));
            until salesInvoiceLine.Next() = 0;
        Message(invoiceContent.ToText());
        lineOutStream.WriteText(invoiceContent.ToText());
        exit(lineOutStream);
    end;
}
