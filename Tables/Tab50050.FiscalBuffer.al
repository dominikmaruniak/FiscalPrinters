table 50050 "Fiscal Buffer"
{
    Caption = 'Fiscal Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No';
            DataClassification = ToBeClassified;
        }
        field(2; "Request ID"; Guid)
        {
            Caption = 'Request ID';
            DataClassification = ToBeClassified;
        }
        field(3; IsPrinted; Boolean)
        {
            Caption = 'IsPrinted';
            DataClassification = ToBeClassified;
        }
        field(4; InvoiceContent; Blob)
        {
            Caption = 'InvoiceContent';
            DataClassification = ToBeClassified;
        }
        field(5; "Printer ID"; Code[20])
        {
            Caption = 'Printer ID';
            DataClassification = ToBeClassified;

        }
        field(6; "Fiscal Rcpt No"; Code[20])
        {
            Caption = 'Fiscal Rcpt No';
            DataClassification = ToBeClassified;
        }
        field(7; "Fiscal Print Date"; DateTime)
        {
            Caption = 'Fiscal Print Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Fiscal Request Date"; DateTime)
        {
            Caption = 'Fiscal Request Date';
        }
    }
    keys
    {
        key(PK; "Invoice No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Request ID" := CreateGuid();
    end;
}
