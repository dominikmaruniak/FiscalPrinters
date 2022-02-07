codeunit 50050 "Fiscal Printer Mgt"
{
    procedure CreateFiscalBufferEntry(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        fiscalBuffer: Record "Fiscal Buffer";
        invoiceInstream: InStream;
        os: OutStream;
        userSetup: Record "User Setup";
    begin
        SalesInvoiceHeader.TestField("Prices Including VAT", true);
        userSetup.Get(UserId());
        userSetup.TestField("User ID", UserId());
        fiscalBuffer.Init();
        fiscalBuffer."Invoice No" := SalesInvoiceHeader."No.";
        fiscalBuffer."Request ID" := CreateGuid();
        fiscalBuffer.Insert(true);
        fiscalBuffer."Printer ID" := userSetup."Printer ID";
        fiscalBuffer.IsPrinted := false;
        fiscalBuffer.InvoiceContent.CreateOutStream(os, TextEncoding::UTF8);
        CreateInvoiceContentOutstream(os, SalesInvoiceHeader);
        fiscalBuffer."Fiscal Request Date" := CurrentDateTime();
        fiscalBuffer.Modify(true);
    end;

    procedure CreateFiscalBufferEntry(var SalesHeader: Record "Sales Header")
    var
        fiscalBuffer: Record "Fiscal Buffer";
        invoiceInstream: InStream;
        os: OutStream;
        userSetup: Record "User Setup";
    begin
        SalesHeader.TestField("Prices Including VAT", true);
        userSetup.Get(UserId());
        userSetup.TestField("User ID", UserId());
        fiscalBuffer.Init();
        fiscalBuffer."Invoice No" := SalesHeader."No.";
        fiscalBuffer."Request ID" := CreateGuid();
        fiscalBuffer.Insert(true);
        fiscalBuffer."Printer ID" := userSetup."Printer ID";
        fiscalBuffer.IsPrinted := false;
        fiscalBuffer.InvoiceContent.CreateOutStream(os, TextEncoding::MSDos);
        CreateInvoiceContentOutstream(os, SalesHeader);
        fiscalBuffer."Fiscal Request Date" := CurrentDateTime();
        fiscalBuffer.Modify(true);

    end;

    local procedure CreateInvoiceContentOutstream(lineOutStream: OutStream; var SalesInvoiceHeader: Record "Sales Invoice Header"): OutStream
    var
        salesInvoiceLine: Record "Sales Invoice Line";
        invoiceContent: TextBuilder;
        lfChar: Char;
        crChar: Char;
        grossValueAfterDiscount: Decimal;
        currExchange: Record "Currency Exchange Rate";
    begin
        lfChar := 10;
        crChar := 13;
        salesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if salesInvoiceLine.FindSet() then
            repeat
                // grossValueAfterDiscount := Round(salesInvoiceLine."Amount Including VAT" / salesInvoiceLine.Quantity, 0.001, '=');
                invoiceContent.AppendLine((StrSubstNo('%1|%2|%3|%4|%5|%6|%7|%8|',
                salesInvoiceLine."No.", salesInvoiceLine.Description, ReturnVatRateCode(salesInvoiceLine), salesInvoiceLine."Quantity (Base)" * 1000,
                Round(CalculateFCYAmountIfExists(salesInvoiceLine."Unit Price", SalesInvoiceHeader, salesInvoiceLine), 0.01) * 100,
                Round(CalculateFCYAmountIfExists(salesInvoiceLine."Amount Including VAT", SalesInvoiceHeader, salesInvoiceLine), 0.01, '<') * 100,
                CheckIfPrintVATRegNo(SalesInvoiceHeader),
                CalculateFCYAmountIfExists(salesInvoiceLine."Line Discount Amount", SalesInvoiceHeader, salesInvoiceLine) * 100)));
            until salesInvoiceLine.Next() = 0;
        lineOutStream.WriteText(invoiceContent.ToText());
        Message(invoiceContent.ToText());
        exit(lineOutStream);
    end;

    local procedure CreateInvoiceContentOutstream(lineOutStream: OutStream; var SalesHeader: Record "Sales Header"): OutStream
    var
        invoiceContent: TextBuilder;
        salesLine: Record "Sales Line";
        lfChar: Char;
        crChar: Char;
        grossValueAfterDiscount: Decimal;
    begin
        lfChar := 10;
        crChar := 13;

        salesLine.SetRange("Document No.", SalesHeader."No.");
        salesLine.SetRange("Document Type", SalesHeader."Document Type");
        if salesLine.FindSet() then
            repeat
                // grossValueAfterDiscount := Round(salesLine."Amount Including VAT" / salesLine.Quantity, 0.001, '=');
                invoiceContent.AppendLine((StrSubstNo('%1|%2|%3|%4|%5|%6|%7|%8|',
                                salesLine."No.", salesLine.Description, ReturnVatRateCode(salesLine), salesLine."Quantity (Base)" * 1000,
                                ROUND(CalculateFCYAmountIfExists(salesLine."Unit Price", SalesHeader, salesLine), 0.01) * 100,
                                ROUND(CalculateFCYAmountIfExists(salesLine."Amount Including VAT", SalesHeader, salesLine), 0.01, '<') * 100,
                                CheckIfPrintVATRegNo(SalesHeader),
                                CalculateFCYAmountIfExists(salesLine."Line Discount Amount", SalesHeader, salesLine) * 100)));
            until salesLine.Next() = 0;
        lineOutStream.WriteText(invoiceContent.ToText());
        exit(lineOutStream);
    end;

    local procedure ReturnVatRateCode(var salesInvoiceLine: Record "Sales Invoice Line"): Text[1]
    var
        fiscalPrinters: Record "Fiscal Printer";
        userSetup: Record "User Setup";
        vatRate: Decimal;
    begin
        userSetup.Get(UserId);
        userSetup.TestField("User ID", UserId());

        fiscalPrinters.Get(userSetup."Printer ID");
        fiscalPrinters.TestField("Printer ID", userSetup."Printer ID");

        vatRate := salesInvoiceLine."VAT %";

        case vatRate of
            fiscalPrinters."Rate A":
                exit('A');
            fiscalPrinters."Rate B":
                exit('B');
            fiscalPrinters."Rate C":
                exit('C');
            fiscalPrinters."Rate D":
                exit('D');
        // fiscalPrinters."Rate E":
        //     exit('E');
        // fiscalPrinters."Rate F":
        //     exit('F');
        // fiscalPrinters."Rate G":
        //     exit('G');
        end;
    end;

    local procedure ReturnVatRateCode(var salesLine: Record "Sales Line"): Text[1]
    var
        fiscalPrinters: Record "Fiscal Printer";
        userSetup: Record "User Setup";
        vatRate: Decimal;
    begin
        userSetup.Get(UserId);
        userSetup.TestField("User ID", UserId());

        fiscalPrinters.Get(userSetup."Printer ID");
        fiscalPrinters.TestField("Printer ID", userSetup."Printer ID");

        vatRate := salesLine."VAT %";

        case vatRate of
            fiscalPrinters."Rate A":
                exit('A');
            fiscalPrinters."Rate B":
                exit('B');
            fiscalPrinters."Rate C":
                exit('C');
            fiscalPrinters."Rate D":
                exit('D');
        // fiscalPrinters."Rate E":
        //     exit('E');
        // fiscalPrinters."Rate F":
        //     exit('F');
        // fiscalPrinters."Rate G":
        //     exit('G');
        end;
    end;

    local procedure CheckIfPrintVATRegNo(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text[20]
    var
        tb: TextBuilder;
    begin
        if SalesInvoiceHeader."Fiscal Receipt VAT.Reg.No" = true then
            exit(SalesInvoiceHeader."VAT Registration No.") else
            exit('');
    end;

    local procedure CalculateFCYAmountIfExists(AmountToExchange: Decimal; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: record "Sales Invoice Line"): Decimal
    var
        currExchange: Record "Currency Exchange Rate";
    begin
        if SalesInvoiceHeader."Currency Code" <> '' then
            Exit(currExchange.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", AmountToExchange, SalesInvoiceHeader."Currency Factor")) else
            Exit(ROUND(AmountToExchange, 0.01));
    end;

    local procedure CalculateFCYAmountIfExists(AmountToExchange: Decimal; var SalesHeader: Record "Sales Header"; var SalesLine: record "Sales Line"): Decimal
    var
        currExchange: Record "Currency Exchange Rate";
    begin
        if SalesHeader."Currency Code" <> '' then begin
            Exit(currExchange.ExchangeAmtFCYToLCY(SalesHeader."Posting Date", SalesHeader."Currency Code", AmountToExchange, SalesHeader."Currency Factor"))
        end else
            Exit(ROUND(AmountToExchange, 0.01));
    end;

    local procedure CheckIfPrintVATRegNo(var SalesHeader: Record "Sales Header"): Text[20]
    begin
        if SalesHeader."Fiscal Receipt VAT.Reg.No" = true then
            exit(SalesHeader."VAT Registration No.") else
            exit('');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReopenSalesDoc', '', false, false)]
    local procedure OnBeforeReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean);
    begin
        if SalesHeader."Fiscal Rcpt No" <> '' then Error(Error001);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReOpenSalesDoc', '', false, false)]
    local procedure OnBeforeManualReOpenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    begin
        if SalesHeader."Fiscal Rcpt No" <> '' then Error(Error001);
    end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order List", 'OnBeforeActionEvent', 'Reopen', true, true)]
    // local procedure "Sales Order List_OnBeforeActionEvent_[processing / Action12] - Reopen"(var Rec: Record "Sales Header")
    // begin
    //     Rec.SetAutoCalcFields("Fiscal Rcpt No");
    //     if Rec."Fiscal Rcpt No" <> '' then Error(Error001);
    // end;

    var
        Error001: Label 'Nie można otworzyć zamówienia sprzedaży, które zostało już zafiskalizowane';


}
