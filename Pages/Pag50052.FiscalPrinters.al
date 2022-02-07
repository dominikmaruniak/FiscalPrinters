page 50052 "Fiscal Printers"
{
    ApplicationArea = All;
    Caption = 'Fiscal Printers';
    PageType = List;
    SourceTable = "Fiscal Printer";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Printer ID"; Rec."Printer ID")
                {
                    ToolTip = 'Specifies the value of the Printer ID field.';
                    ApplicationArea = All;
                }
                field("Rate A"; Rec."Rate A")
                {
                    ToolTip = 'Specifies the value of the Rate A field.';
                    ApplicationArea = All;
                }
                field("Rate B"; Rec."Rate B")
                {
                    ToolTip = 'Specifies the value of the Rate B field.';
                    ApplicationArea = All;
                }
                field("Rate C"; Rec."Rate C")
                {
                    ToolTip = 'Specifies the value of the Rate C field.';
                    ApplicationArea = All;
                }
                field("Rate D"; Rec."Rate D")
                {
                    ToolTip = 'Specifies the value of the Rate D field.';
                    ApplicationArea = All;
                }
                field("Rate E"; Rec."Rate E")
                {
                    ToolTip = 'Specifies the value of the Rate E field.';
                    ApplicationArea = All;
                }
                field("Rate F"; Rec."Rate F")
                {
                    ToolTip = 'Specifies the value of the Rate F field.';
                    ApplicationArea = All;
                }
                field("Rate G"; Rec."Rate G")
                {
                    ToolTip = 'Specifies the value of the Rate G field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
