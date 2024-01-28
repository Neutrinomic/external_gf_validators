import Error "mo:base/Error";
import Ledger "./services/icrc_ledger";
import Option "mo:base/Option";
import Principal "mo:base/Principal";


actor {

    type ValidationResult = {
        #Ok: Text;
        #Err :Text;
    };


    public query func validate_icrc1_transfer(req: Ledger.TransferArg) : async ValidationResult {
        if (not Option.isNull(req.created_at_time)) return #Err("created_at_time must be null, the window is 24hours while proposals may take days");
        
        ignore do ? { if (req.memo!.size() > 200) return #Err("memo must be less than 200 bytes"); };
        ignore do ? { if (req.to.subaccount!.size() > 32) return #Err("subaccount must be less than 32 bytes"); };
        ignore do ? { if (req.from_subaccount!.size() > 32) return #Err("from_subaccount must be less than 32 bytes"); };

        if (req.amount <= 0 or req.amount >= 10**50) return #Err("amount must be between 0 and 10^50");
        ignore do ? { if (req.fee! > 10**50) return #Err("fee must be less than 10^50"); };

        let msg:Text = "
        amount: " # debug_show(req.amount) # " 
        to owner: " # Principal.toText(req.to.owner) # " 
        to subaccount: " # debug_show(req.to.subaccount) # " 
        from_subaccount: " # debug_show(req.from_subaccount) # " 
        fee: " # debug_show(req.fee) # " 
        memo: " # debug_show(req.memo) # " 
        ";
        #Ok(msg);
    };



}