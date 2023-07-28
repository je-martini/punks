// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2 ;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";   
import "./base64.sol"; 

contract punks3 is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;
    
    Counters.Counter private _id_counter;
    uint256 public max_supply; 

    constructor(uint256 _max_supply) ERC721("crypto-punks", "punks3"){
        max_supply = _max_supply;
    }

    function mint() public {
        uint256 current = _id_counter.current();
        require(current < max_supply, "no more punks :( ");
        _safeMint( msg.sender, current);
        _id_counter.increment();
    }

    function tokenURI(uint256 token_Id)
        public
        view
        override
        returns( string memory){
            require(_exists(token_Id), "ERC721 Metadata: URI query for nonexistent token");
        
        string memory json_URI = base64.encode(
            abi.encodePacked(
                '{ "name": "punks #',
                token_Id,
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                "// TO DO Calculate image URL",
                '"}' 
            ),
        );
        
        return string(abi.encodePacked("data:application/json;base64,", json_URI));

        }

        // The following functions are overrides required by Solidity.
    // override
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}