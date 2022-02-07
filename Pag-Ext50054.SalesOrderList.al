pageextension 50054 "Sales Order List" extends "Sales Order List"
{

    actions
    {

        addafter(Action12)
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
                            fiscalBuffer.Modify(true);
                        end;
                    end
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        CalcFields("Fiscal Rcpt No");
    end;

    var
        Error001: Label 'Zamówienie sprzedaży musi być zwolnione, żeby można było je zafiskalizować';
        Error002: Label 'Pole Paragon fiskalny lub Paragon fiskalny z NIP musi być zaznaczone!';
        questionLabel: Label 'Czy jesteś PEWIEN że chcesz dokonać ponownej fiskalizacji paragonu dla dokumentu nr: %1?';
}
