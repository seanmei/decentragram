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


  event TipImage(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  //Create Posts

  function uploadImage(string memory _imageHash, string memory _description) public {
    require(bytes(_description).length > 0 , 'Decription is empty'); //makes sure the decription is not an empty string 
    require(bytes(_imageHash).length > 0 , 'ImageHash is empty'); //makre sure image hash exists 
    require(msg.sender != address(0)); //make sure sender exists

    imageCount++; //Id of image coutner 
    //Craete Image and add to contract 
    images[imageCount] = Image(imageCount, _imageHash,  _description, 0, msg.sender); //add image to contract
    
    //Trigger Event 
    emit ImageCreated(imageCount, _imageHash, _description, 0, msg.sender);
  }
    //Tip Posts 

  function tipImageOwner(uint _id) external payable {
    require(_id >0 && _id <= imageCount);//Check that image id is valid 
    //Fetch the Image
    Image memory _image = images[_id]; //memory not storage because not on chain 
    //Fetch author 
    address payable _author = _image.author;
    //send money to author 
    _author.transfer(msg.value); //msg.value is the amount of crypto that is sent in 
    //Increment the tip amount 
    _image.tipAmount = _image.tipAmount + msg.value; 
    //update the image in the list 
    images[_id] = _image; 
    //Trigger Event 
    emit TipImage(_id, _image.hash, _image.description, _image.tipAmount, _author);
  }
 
}


