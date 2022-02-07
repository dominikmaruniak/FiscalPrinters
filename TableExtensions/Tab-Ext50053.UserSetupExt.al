tableextension 50053 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50050; "Printer ID"; Code[20])
        {
            CaptionML = ENU = 'Fiscal Printer ID', PLK = 'ID Drukarki Fiskalnej';
            DataClassification = ToBeClassified;
            TableRelation = "Fiscal Printer"."Printer ID";
        }
    }
}
