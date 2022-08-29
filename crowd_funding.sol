// SPDX-Licence-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract CrowdFunding{
    mapping(address=>uint) public contributers; //mapping 
    address public manager;//declared at start of the contract
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributers;
    uint public minimumContribution;

    struct Request{
        string description;//what type of request
        address payable recipient;//who wants the request money
        uint value;//how much
        bool completed;//whether the request has been completed or not
        uint noofvoters;//voters
        mapping(address=>bool) voters;//address=> whether he/she has voted or not
    }
    mapping(uint=>Request) public requests;//mapping type of requests like business or school or food donation drive
    uint public numRequests;



    constructor(uint _target,uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline; //present timestamp+36000sec
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
        contributers[msg.sender]+=msg.value;//has contributed before then increase the amt
        raisedAmount=raisedAmount+msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;//
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"you are not eligible for refund");
        require(contributers[msg.sender]>0,"you have not contributed anything");//to check if the refund requested by the user has actually contributed
        address payable user = payable(msg.sender); //making the user payable
        user.transfer(contributers[msg.sender]);//msg.sender 0x259a  => 1000wei
        contributers[msg.sender]=0;
    }

    modifier onlyManager(){
        require(msg.sender==manager,"only manager can call this function");
        _;
    }
    function createRequests(string memory _description,address payable _recipient,uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
        //we cannot use memory keyword with struct inside a function
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noofvoters=0;
    }
    function voteRequest(uint _requestNo) public{
        require(contributers[msg.sender]>0,"you must be contributer");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"you have already voted");
        //checks if msg.sender has already voted or not
        thisRequest.voters[msg.sender]=true;
        //if condition satisfies then true is set
        thisRequest.noofvoters++;
    }
    function makepayment(uint _requestNo) public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.completed==false,"request has been completed");//will check whether the request is been completed or not
        //checks for majority voting
        require(thisRequest.noofvoters > noOfContributers/2,"majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }
}