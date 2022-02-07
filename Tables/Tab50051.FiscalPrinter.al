table 50051 "Fiscal Printer"
{
    Caption = 'Fiscal Printer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Printer ID"; Code[20])
        {
            Caption = 'Printer ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Rate A"; Decimal)
        {
            CaptionML = ENU = 'Rate A', PLK = 'Stawka A';
            DataClassification = ToBeClassified;
        }
        field(3; "Rate B"; Decimal)
        {
            CaptionML = ENU = 'Rate B', PLK = 'Stawka B';
            DataClassification = ToBeClassified;
        }
        field(4; "Rate C"; Decimal)
        {
            CaptionML = ENU = 'Rate C', PLK = 'Stawka C';
            DataClassification = ToBeClassified;
        }
        field(5; "Rate D"; Decimal)
        {
            CaptionML = ENU = 'Rate D', PLK = 'Stawka D';
            DataClassification = ToBeClassified;
        }
        field(6; "Rate E"; Decimal)
        {
            CaptionML = ENU = 'Rate E', PLK = 'Stawka E';
            DataClassification = ToBeClassified;
        }
        field(7; "Rate F"; Decimal)
        {
            CaptionML = ENU = 'Rate F', PLK = 'Stawka F';
            DataClassification = ToBeClassified;
        }
        field(8; "Rate G"; Decimal)
        {
            CaptionML = ENU = 'Rate G', PLK = 'Stawka G';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Printer ID")
        {
            Clustered = true;
        }
    }
}
