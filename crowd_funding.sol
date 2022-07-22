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
        manager=msg.sender;//msg.sender refers the accounts that will be sending or interacting with the smartcontract
    }

    function sedEth() public payable{
        require(block.timestamp<deadline,"deadline has passed");
        require(msg.value>=minimumContribution,"minimun Contrbution is not met");

        if(contributers[msg.sender]==0){ 
            //it will change the by default value of contributers that is 0
            //we are doing this to uniquely identify the contributers
            noOfContributers++;
        }
        contributers[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
}