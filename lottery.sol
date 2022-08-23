pragma solidity 0.8.0;

contract lottery
{
    address public manager;
    address[] public players;

    function Lottery() public{
        manager=msg.sender;
    }

    function enter() public payable{
        players.push(msg.sender);
    }
    


}