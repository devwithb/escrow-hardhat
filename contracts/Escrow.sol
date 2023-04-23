// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    address public arbiter;
    address public beneficiary;
    address public depositor;

    bool public isApproved;

    constructor() payable {
        depositor = msg.sender;
    }

    function setArbiter(address _arbiter) external {
        arbiter = _arbiter;
    }

    function setBeneficiary(address _beneficiary) external {
        beneficiary = _beneficiary;
    }

    event Approved(uint);

    function approve() external {
        require(msg.sender == arbiter);
        uint balance = address(this).balance;
        (bool sent, ) = payable(beneficiary).call{value: balance}("");
        require(sent, "Failed to send Ether");
        emit Approved(balance);
        isApproved = true;
    }
}
