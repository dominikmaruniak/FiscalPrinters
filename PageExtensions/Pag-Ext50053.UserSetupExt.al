pageextension 50053 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addbefore("Salespers./Purch. Code")
        {
            field("Printer ID"; "Printer ID")
            {
                ApplicationArea = all;
            }
        }
    }
}
