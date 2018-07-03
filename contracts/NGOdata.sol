pragma solidity ^0.4.23;

contract NGOinfo{

    address owner;
    uint[] ngoregId;

    constructor() public {
        owner = msg.sender;
    }

    modifier officialOnly(){
        owner = msg.sender;
        _;
    }

    uint16 Id = 0;

    function registerNGO(uint16 _givenId) officialOnly public returns(uint){

        ngoregId.push(_givenId);
        Id++;
        return _givenId;
    }

    function removeNGO(uint _id) officialOnly public {
        uint i;
        for(i = 0; i < ngoregId.length ; i++){
            if(ngoregId[i] == _id){
                ngoregId[i] = ngoregId[ngoregId.length-1];
                delete ngoregId[ngoregId.length-1];
                ngoregId.length--;
                return;
            }
        }
    }

    function isValid(uint _ngoRegId) public view returns(bool){

        uint16 x = 0;
        while(x < ngoregId.length){
            if(ngoregId[x] == _ngoRegId){
                return true;
            }
            x++;
        }
        return false;
    }

}