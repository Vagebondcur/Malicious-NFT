// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract PoCSVG is ERC721 {

    struct Poc {
        string name;
        string description;
    }

    uint256 private s_tokenCounter;
    string private s_pocSvgImageUri;


    mapping(uint256 => Poc) public s_tokenIdToPoc;

    constructor(string memory pocSvgImageUri) ERC721("PoCSVG", "SVG") {
        s_tokenCounter = 0;
        s_pocSvgImageUri = pocSvgImageUri;
    }

    function mint() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }


    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenID) public view override returns (string memory) {
        string memory imageURI = s_pocSvgImageUri;

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"NFT with a PoC SVG that downloads files when clicked", ',
                            '"image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
