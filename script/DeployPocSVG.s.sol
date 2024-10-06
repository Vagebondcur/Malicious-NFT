// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {PoCSVG} from "src/PocSvg.sol";
import "forge-std/console2.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployPocSVG is Script {
    function run() external returns (PoCSVG) {
        string memory PoC = vm.readFile("./img/poc.svg");

        // string memory privateKey = vm.envString("PRIVATE_KEY");

        vm.startBroadcast();
        // Deploy the contract
        PoCSVG pocSvg = new PoCSVG(svgToImageURI(PoC));
        // Mint a token
        pocSvg.mint();
        vm.stopBroadcast();
        return pocSvg;
    }

    function svgToImageURI(string memory _svg) public pure returns (string memory) {
        // example: "data:image/svg+xml;base64,PHN2ZyB4bWxu..."
        // <svg width'"1024px" height="1024px"
        // data:image/svg+xml;base64,PHN2ZyB4bWxu...

        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
