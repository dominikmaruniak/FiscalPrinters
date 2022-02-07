tableextension 50051 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50050; "Fiscal Receipt"; Boolean)
        {
            CaptionML = ENU = 'Fiscal Receipt', PLK = 'Paragon fiskalny';
            DataClassification = ToBeClassified;
        }
        field(50051; "Fiscal Rcpt No"; Code[20])
        {
            CaptionML = ENU = 'Fiscal Receipt No', PLK = 'Numer paragonu fiskalnego';
            FieldClass = FlowField;
            CalcFormula = lookup("Fiscal Buffer"."Fiscal Rcpt No" WHERE("Invoice No" = field("No.")));
            Editable = false;
        }
        field(50052; "Fiscal Receipt VAT.Reg.No"; Boolean)
        {
            CaptionML = ENU = 'Fiscal Receipt includes VAT.Reg.No', PLK = 'Paragon fiskalny z NIP';
        }
    }
}
