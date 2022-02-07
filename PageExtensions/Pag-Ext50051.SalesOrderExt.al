pageextension 50051 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("Fiscal Rcpt No"; "Fiscal Rcpt No")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Fiscal Receipt', PLK = 'Paragon fiskalny';

            }
        }

        addafter("Prices Including VAT")
        {
            field("Fiscal Receipt"; "Fiscal Receipt")
            {
                ApplicationArea = all;

            }
        }

        addafter("Fiscal Receipt")
        {
            field("Fiscal Receipt VAT.Reg.No"; "Fiscal Receipt VAT.Reg.No")
            {
                ApplicationArea = all;

            }
        }
    }
    actions
    {
        addafter(Release)
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
                begin
                    TestField(Rec."Prices Including VAT", true);

                    if (Rec."Fiscal Receipt" = false) AND (Rec."Fiscal Receipt VAT.Reg.No" = false) then
                        Error(Error002);

                    if Rec.Status = Rec.Status::Released then
                        fiscalPrinterMgt.CreateFiscalBufferEntry(Rec) else
                        Error(Error001);
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
                    if fiscalBuffer.Get(Rec."No.") then begin
                        answer := Confirm(questionLabel, false, Rec."No.");
                        if answer then begin
                            fiscalBuffer.IsPrinted := false;
                            fiscalBuffer."Fiscal Rcpt No" := '';
                            fiscalBuffer.Modify(true);
                        end;
                    end
                end;
            }
        }
    }
    var
        Error001: Label 'Zamówienie sprzedaży musi być zwolnione, żeby można było je zafiskalizować';
        Error002: Label 'Pole Paragon fiskalny lub Paragon fiskalny z NIP musi być zaznaczone!';
        questionLabel: Label 'Czy jesteś PEWIEN że chcesz dokonać ponownej fiskalizacji paragonu dla dokumentu nr: %1?';
}
