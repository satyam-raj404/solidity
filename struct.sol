pragma solidity 0.8.0;
struct student{
    uint roll;
    string name;
}
contract Struct
{
    student public s1;
    constructor(uint _roll, string memory _name)
    {
        s1.roll = _roll;
        s1.name = _name;
    }

}