//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        string memory sadSvgURI = svgToURI(sadSvg);
        string memory happySvgURI = svgToURI(happySvg);

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(sadSvgURI, happySvgURI);
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(abi.encodePacked(svg));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
