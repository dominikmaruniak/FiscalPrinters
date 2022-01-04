pageextension 50101 "Posted Sales Inv Ext" extends "Posted Sales Invoices"
{
    actions
    {
        addafter(Print)
        {
            action("Print invoice")
            {
                Caption = 'Print Invoice';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PrintVoucher;
                trigger OnAction();
                var
                    testCU: Codeunit "Fiscal Printer Mgt";
                begin
                    Message(FORMAT(Rec.Amount));
                    testCU.CreateFiscalBufferEntry(Rec);
                end;
            }
        }
    }
}

