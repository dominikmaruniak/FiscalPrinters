tableextension 50052 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50050; "Fiscal Receipt"; Boolean)
        {
            CaptionML = ENU = 'Fiscal Receipt', PLK = 'Paragon fiskalny';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Fiscal Receipt" then begin
                    Rec.Validate("Prices Including VAT", true);
                end;
            end;
        }
        field(50051; "Fiscal Rcpt No"; Code[20])
        {
            CaptionML = ENU = 'Fiscal Receipt No', PLK = 'Numer paragonu fiskalengo';
            FieldClass = FlowField;
            CalcFormula = lookup("Fiscal Buffer"."Fiscal Rcpt No" WHERE("Invoice No" = field("No.")));
            Editable = False;
        }
        field(50052; "Fiscal Receipt VAT.Reg.No"; Boolean)
        {
            CaptionML = ENU = 'Fiscal Receipt includes VAT.Reg.No', PLK = 'Paragon fiskalny z NIP';
            trigger OnValidate()
            begin
                if "Fiscal Receipt VAT.Reg.No" then begin
                    Rec.Validate("Prices Including VAT", true);
                end;
            end;
        }
    }
}
