// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract balance

{
    address payable user= payable (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    function payEth() public payable {

    }

    function getBal() public view returns(uint)
    {
        return address(this).balance;
    }

    function sendEth() public {
        user.transfer(2 ether) ;
    }
}
