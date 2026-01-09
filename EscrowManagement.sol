// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// the following contract simulate an escrow management system of a law company
// the buyer starts the contract with an amount and it is release when the contract is fullfiled
contract EscrowManagement {
address public constant buyer = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
address public constant seller = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
address public constant solicitor = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
uint public purchaseAmount;
bool public transactionApproved;

constructor() payable {
    require(msg.sender == buyer, "only buyer can deploy");
    purchaseAmount = msg.value;
}


function approveTransaction() public {

    require(msg.sender == solicitor , "Only solicitor can approve");

    transactionApproved = true;
}

function releasePayment() external payable  {
    require(transactionApproved, "Transaction not approved");
    (bool ok, ) = payable(seller).call{value: purchaseAmount}("");
    require(ok, "ETH transfer failed");
    }

}