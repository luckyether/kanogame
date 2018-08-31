pragma solidity ^0.4.24;

contract luckycontract {
    
address public owner;

  constructor() public {
    owner = msg.sender;
  }
  
   modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

event givedan(address amount);

uint256 public maxsize = 20;
uint256 public gametype = 0.05 ether;
uint256 public enterance = 0;
address public serviceaddress = 0xD7dDF69bf06468A078a665cB14F3161E2778E87b;
address[] private accounts;
uint nonce = 0;
function rand(uint min, uint max) private returns (uint){
 uint random = uint(keccak256(abi.encodePacked(now, block.difficulty, nonce))) % max + min;
    nonce++;
    return random;
}

mapping(uint256 => address) private addresses;
  function () public payable {

        bool accept=false;
        //Check values
        if (msg.value == gametype && enterance<maxsize) { 
            enterance = enterance+1; accept=true;
            addresses[enterance]=msg.sender;
            accounts.push(msg.sender);
       }
       
         if(enterance==maxsize && accept) {
             
             uint256 winner = rand(1,maxsize);
              addresses[winner].transfer(address(this).balance*90/100);
              serviceaddress.transfer(address(this).balance);
             emit givedan(addresses[winner]);

            }
            
            
        if(!accept) { revert(); } 
        
   }
   
     function revertit() public onlyOwner {
     
       for(uint index=0; index<accounts.length; index++){
            accounts[index].transfer(0.045 ether);
        }
             serviceaddress.transfer(address(this).balance);

        
    }
    
  
 
}
