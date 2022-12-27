// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

//ERC 20 token smart contract
contract myToken { 

   //name of the token
   string public name = "keth";
   //symbol for token
   string public symbol= "kth";
  
//    address owner= 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
   address owner = msg.sender;
   uint8 public decimal= 18;  //used with matic

  
   uint256 public totalToken = 1000000 * (10 ** decimal);
   
   //this will return balance 0 initially but will show total token after constructor()
   mapping (address => uint256) public balanceof;
   //contructor will assign all the token supply to owner
   constructor() {
       balanceof[owner] = totalToken;
       emit Transfer(msg.sender, owner, totalToken);
   }
   
   event Transfer(address indexed _from, address indexed _to, uint256 value);
   function transfer(address _to, uint256 _val) public returns(bool success)
   {
      require(balanceof[owner] >= _val, "Insufficient balance ");
      balanceof[_to] += _val;
      balanceof[owner] -= _val;
      uint balNow = totalToken - _val;

      emit Transfer(owner , _to, _val);
    //   return true;
      if(balNow == balanceof[owner]){
          return true;
      }
      else{
          return false;
      }


   }
   //this mapping will keep track of who is allowed to spend token of owner and how much.
   mapping (address => mapping( address => uint256)) public spendingData;
    //event will fire once approval function is called
   event Approval(address indexed _owner, address indexed spender, uint256 limit);
   function approval (address _spender, uint256 _val) public returns(bool success){
       spendingData[owner][_spender]= _val;
       balanceof[_spender]+=_val;
       emit Approval(owner,_spender,_val);
       return true;
   }

   function transferFrom (address _spender, address _to, uint val)public returns(bool success) {
       require(spendingData[owner][_spender]>= val, "Permission denied");
       require(balanceof[_spender]>= val , "Insufficient balance");
       balanceof[_to] += val;
       balanceof[_spender]-=val;
       emit Transfer(_spender, _to, val);
       spendingData[owner][_spender] -= val;
       return true;
   }
   

   
   

}
