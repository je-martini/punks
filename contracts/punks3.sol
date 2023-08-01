// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2 ;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";   
import "./base64.sol"; 
import "./dna_punks.sol";

contract punks3 is ERC721, ERC721Enumerable, dna_punks {
    using Counters for Counters.Counter;
    using Strings for uint256;
    
    Counters.Counter private _id_counter;
    uint256 public max_supply; 
    mapping(uint256 => uint256) public token_dna; 

    constructor(uint256 _max_supply) ERC721("crypto-punks", "punks3"){
        max_supply = _max_supply;
    }

    function mint() public {
        uint256 current = _id_counter.current();
        require(current < max_supply, "no more punks :( ");
        
        token_dna[current] = deterministic_pseudo_random_dna(current, msg.sender);
        _safeMint( msg.sender, current);
        _id_counter.increment();
    }

    function _base_uri() internal pure returns(string memory) {
        return "https://avataaars.io/";
    }

    function _params_uri(uint256 _dna) internal view returns(string memory){
        string memory params;
        {
            params = string(abi.encodePacked(
            "accessoriesType=",
            getAccesoriesType(_dna),
            "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                    getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyeBrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna)
        ));
        }
        return string(abi.encodePacked(params, "&topType",
                    getTopType(_dna)));
    } 

    function image_by_DNA(uint256 _dna) public view returns (string memory){
        string memory base_URI = _baseURI();
        string memory params_uri = _params_uri(_dna);

        return string(abi.encodePacked(base_URI, "?", params_uri));
    }

    function tokenURI(uint256 token_Id)
        public
        view
        override
        returns( string memory){
            require(_exists(token_Id), "ERC721 Metadata: URI query for nonexistent token");
        
        uint256 dna = token_dna[token_Id];
        string memory image = image_by_DNA(dna);

        string memory json_URI = Base64.encode(
            abi.encodePacked(
                '{ "name": "punks #',
                token_Id.toString(),
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                image,
                '"}' 
            )
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