// SPDX-Licence-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract CrowdFunding{
    mapping(address=>uint) public contributers;
    address public manager;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributers;
    uint public minimumContribution;

    constructor(uint _target,uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline; //10sec+36000sec
        minimumContribution=100 wei;
        manager=msg.sender;
    }
}