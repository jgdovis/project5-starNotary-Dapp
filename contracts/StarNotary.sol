pragma solidity >= 0.4.24;

//Importing openzeppelin-solidity ERC-721 implemented Standard
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

// StarNotary Contract declaration inheritance the ERC721 openzeppelin implementation
contract StarNotary is ERC721 {

    // Star data
    struct Star {
        string name;
    }

    // name: Is a short name to your token

    string public constant name = "jGStar";
    string public constant symbol = "JGT";

    // mapping the Star with the Owner Address
    mapping(uint256 => Star) public tokenIdToStarInfo;
    // mapping the TokenId and price
    mapping(uint256 => uint256) public starsForSale;

    // Create Star using the Struct
    function createStar(string memory _name, uint256 _tokenId) public { // Passing the name and tokenId as a parameters
        Star memory newStar = Star(_name); // Star is an struct so we are creating a new Star
        tokenIdToStarInfo[_tokenId] = newStar; // Creating in memory the Star -> tokenId mapping
        _mint(msg.sender, _tokenId); // _mint assign the the star with _tokenId to the sender address (ownership)
    }

    // Putting an Star for sale (Adding the star tokenid into the mapping starsForSale, first verify that the sender is the owner)
    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "You can't sale the Star you don't owned");
        starsForSale[_tokenId] = _price;
    }


    // Function that allows you to convert an address into a payable address
    function _make_payable(address x) internal pure returns(address payable) {
        return address(uint160(x));
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0, "The Star should be up for sale");
        uint256 jGStar = starsForSale[_tokenId];
        address ownerAddress = ownerOf(_tokenId);
        require(msg.value > jGStar, "You need to have enough Ether");
        _transferFrom(ownerAddress, msg.sender, _tokenId); // We can't use _addTokenTo or_removeTokenFrom functions, now we have to use _transferFrom
        address payable ownerAddressPayable = _make_payable(ownerAddress); // We need to make this conversion to be able to use transfer() function to transfer ethers
        ownerAddressPayable.transfer(jGStar);
        if (msg.value > jGStar) {
            msg.sender.transfer(msg.value - jGStar);
        }
    }

    // function that returns star saved in tokenIdToStarInfo mapping
    function lookUptokenIdToStarInfo(uint _tokenId) public view returns(string memory) {
        return tokenIdToStarInfo[_tokenId].name;
    }

    // function that exchange stars between two users
    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
        address firstTokenowner1 = ownerOf(_tokenId1);
        address secondTokenowner2 = ownerOf(_tokenId2);
        
        require(
            msg.sender == firstTokenowner1 || msg.sender == secondTokenowner2, "You don't own any of these Stars!");
        _transferFrom(firstTokenowner1, secondTokenowner2, _tokenId1);
        _transferFrom(secondTokenowner2, firstTokenowner1, _tokenId2);
    }

    // function that transfer star
    function transferStar(address _to1, uint256 _tokenId) public {
        address starOwner = ownerOf(_tokenId);
        require(starOwner == msg.sender, "You can't transfer Star you don't own");
        transferFrom(starOwner, _to1, _tokenId);
    }

    // function that returns owner by token id
    function getOwnerByToken(uint256 _tokenId) public view returns(address) {
        return ownerOf(_tokenId);
    }

}
