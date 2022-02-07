pageextension 50050 "Posted Sales Inv Ext" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Fiscal Receipt"; "Fiscal Receipt")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Fiscal Receipt', PLK = 'Paragon fiskalny';

            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action("Print invoice")
            {
                CaptionML = ENU = 'Print receipt', PLK = 'Drukuj paragon';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PrintCheck;

                trigger OnAction();
                var
                    fiscalPrinterMgt: Codeunit "Fiscal Printer Mgt";
                    fiscalBuffer: Record "Fiscal Buffer";
                begin
                    if fiscalBuffer.Get(Rec."Order No.") then Error('Paragon został już wydrukowany wcześniej');

                    fiscalPrinterMgt.CreateFiscalBufferEntry(Rec);
                end;
            }
        }

        addafter("Print invoice")
        {
            action("Reprint Invoice")
            {
                CaptionML = ENU = 'Reprint receipt', PLK = 'Drukuj ponownie paragon';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Receipt;

                trigger OnAction();
                var
                    fiscalBuffer: Record "Fiscal Buffer";
                    answer: Boolean;
                begin
                    if fiscalBuffer.Get(Rec."Order No.") then Error('Paragon został już wydrukowany wcześniej');

                    answer := Confirm(questionLabel, false, Rec."No.");
                    if answer then begin
                        fiscalBuffer.Get(Rec."No.");
                        fiscalBuffer.IsPrinted := false;
                        fiscalBuffer."Fiscal Rcpt No" := '';
                        fiscalBuffer.Modify(true);
                    end;
                end;
            }
        }
    }
    var
        questionLabel: Label 'Czy jesteś PEWIEN że chcesz dokonać ponownej fiskalizacji paragonu dla dokumentu nr: %1?';

}

