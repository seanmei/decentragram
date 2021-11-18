// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0; 

contract Decentragram {
  string public name = "Decentragram"; //

  

  
  //Store Posts 
  uint public imageCount = 0;

  mapping(uint => Image) public images;

  struct Image {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;

  }

  event ImageCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );


  //Create Posts

  function uploadImage(string memory _imageHash, string memory _description) public {
    imageCount++;
    images[imageCount] = Image(imageCount, _imageHash,  _description, 0, msg.sender); //add image to contract
    
    emit ImageCreated(imageCount, _imageHash, _description, 0, msg.sender);
  }
}
  //Tip Posts 
 

