pragma solidity ^0.4.23;

import "./NGOdata.sol";

contract Donations is NGOinfo{

    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier permit{
        require(msg.sender==owner);
        _;
    }

    struct NGO{
        string ngoName;
        string ngoType;
        uint ngoRegId;
        address ngoAddress;
        mapping(uint=>Donor) donors;
    }

    struct Donor{
        address donorAddress;
        uint donationAmount;
    }

    mapping(uint=>NGO) ngos;
    

    uint donorCount;

    function insertNGO(address _ngoAddress,uint _ngoRegId,string _ngoType,string _ngoName) permit public{

        NGOinfo data = new NGOinfo();
        bool validity = data.isValid(_ngoRegId);
        require(validity);
        ngos[_ngoRegId] = NGO(_ngoName,_ngoType,_ngoRegId,_ngoAddress);

    }

    function donate(uint16 _ngoRegId)public payable{
       
        donorCount++;
        NGO storage ngo = ngos[_ngoRegId];
        ngo.donors[donorCount++] = Donor({donorAddress:msg.sender,donationAmount:msg.value});        
    }

}


