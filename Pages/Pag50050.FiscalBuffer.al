page 50050 "Fiscal Buffer"
{
    ApplicationArea = All;
    Caption = 'Fiscal Buffer';
    PageType = List;
    SourceTable = "Fiscal Buffer";
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Invoice No"; Rec."Invoice No")
                {
                    ToolTip = 'Specifies the value of the Invoice No field.';
                    ApplicationArea = All;
                }
                field("Request ID"; Rec."Request ID")
                {
                    ToolTip = 'Specifies the value of the Request ID field.';
                    ApplicationArea = All;
                }
                field(IsPrinted; Rec.IsPrinted)
                {
                    ToolTip = 'Specifies the value of the IsPrinted field.';
                    ApplicationArea = All;
                }
                field(InvoiceContent; Rec.InvoiceContent)
                {
                    ToolTip = 'Specifies the value of the InvoiceContent field.';
                    ApplicationArea = All;
                }
                field("Printer ID"; Rec."Printer ID")
                {
                    ToolTip = 'Specifies the value of the Printer ID field.';
                    ApplicationArea = All;
                }
                field("Fiscal Rcpt No"; Rec."Fiscal Rcpt No")
                {
                    ToolTip = 'Specifies the value of the Fiscal Rcpt No field.';
                    ApplicationArea = All;
                }
                field("Fiscal Print Date"; Rec."Fiscal Print Date")
                {
                    ToolTip = 'Specifies the value of the Fiscal Print Date field.';
                    ApplicationArea = All;
                }
                field("Fiscal Request Date"; Rec."Fiscal Request Date")
                {
                    ToolTip = 'Specifies the value of the Fiscal Request Date field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
