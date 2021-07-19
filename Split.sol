contract FundSplitter {
    event Deposit(address sender, uint amount);

    address user1;
    address user2;
    uint user1Fraction;
    
    function FundSplitter(address u1, address u2, uint fraction) {
        user1 = u1;
        user2  = u2;
        user1Fraction = fraction;
    }
    
    function() payable {
        Deposit(msg.sender, msg.value);
    }
    
    function withdraw() {
        if(msg.sender != user1 && msg.sender != user2) throw;
        uint u1total = (this.balance * user1Fraction) / 100;
        if(!user1.send(u1total)) throw;
        if(!user2.send(this.balance)) throw;
    }
}
