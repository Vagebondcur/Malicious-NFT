// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {PoCSVG} from "src/PocSvg.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract PoCSVGTest is Test {
    PoCSVG pocSvgInstance;
    address USER = makeAddr("user");

    function setUp() external {
        string memory PoC = vm.readFile("./img/poc.svg");
        pocSvgInstance = new PoCSVG(svgToImageURI(PoC));
    }

    function test_MintAndCheckOwnership() public {
        // Mint a new token
        vm.prank(USER);
        pocSvgInstance.mint();

        // Check if the user is the owner of the minted token
        assertEq(pocSvgInstance.ownerOf(0), USER);

        // Retrieve the token URI
        string memory tokenURI = pocSvgInstance.tokenURI(0);
        console.log("Token URI:", tokenURI);

        // Compare the image or metadata (this is a placeholder for actual comparison logic)
        string memory expectedURI = "data:application/json;base64,eyJuYW1lIjoiUG9DU1ZHIiwgImRlc2NyaXB0aW9uIjoiTkZUIHdpdGggYSBQb0MgU1ZHIHRoYXQgZG93bmxvYWRzIGZpbGVzIHdoZW4gY2xpY2tlZCIsICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIaHRiRzV6T25oc2FXNXJQU0pvZEhSd09pOHZkM2QzTG5jekxtOXlaeTh4T1RrNUwzaHNhVzVySWlCMlpYSnphVzl1UFNJeExqQWlJSGRwWkhSb1BTSTFNREFpSUdobGFXZG9kRDBpTlRBd0lqNEtJQ0FnSUR4eVpXTjBJSGc5SWpVaUlIazlJak13SWlCM2FXUjBhRDBpTXpBd0lpQm9aV2xuYUhROUlqTXdJaUJtYVd4c1BTSnNhV2RvZEdKc2RXVWlJSE4wY205clpUMGlZbXgxWlNJZ2MzUnliMnRsTFhkcFpIUm9QU0l5SWlCeWVEMGlOU0lnY25rOUlqVWlMejRLSUNBZ0lEeDBaWGgwSUhnOUlqRXdJaUI1UFNJMU1DSWdabTl1ZEMxbVlXMXBiSGs5SWtGeWFXRnNJaUJtYjI1MExYTnBlbVU5SWpJd0lpQm1hV3hzUFNKaWJHRmpheUkrVDNCbGJpQjBhR2x6SUdsdFlXZGxJR2x1SUdFZ2JtVjNJSFJoWWp3dmRHVjRkRDRLSUNBZ0lEeHpZM0pwY0hRZ2RIbHdaVDBpWVhCd2JHbGpZWFJwYjI0dlpXTnRZWE5qY21sd2RDSStQQ0ZiUTBSQlZFRmJDaUFnSUNBZ0lDQWdaRzlqZFcxbGJuUXVZV1JrUlhabGJuUk1hWE4wWlc1bGNpZ2lSRTlOUTI5dWRHVnVkRXh2WVdSbFpDSXNJR1oxYm1OMGFXOXVLQ2tnZXdvZ0lDQWdJQ0FnSUNBZ0lDQm1kVzVqZEdsdmJpQmlZWE5sTmpSVWIwRnljbUY1UW5WbVptVnlLR0poYzJVMk5Da2dld29nSUNBZ0lDQWdJQ0FnSUNBZ0lDQWdkbUZ5SUdKcGJtRnllVjl6ZEhKcGJtY2dQU0IzYVc1a2IzY3VZWFJ2WWloaVlYTmxOalFwT3dvZ0lDQWdJQ0FnSUNBZ0lDQWdJQ0FnZG1GeUlHeGxiaUE5SUdKcGJtRnllVjl6ZEhKcGJtY3ViR1Z1WjNSb093b2dJQ0FnSUNBZ0lDQWdJQ0FnSUNBZ2RtRnlJR0o1ZEdWeklEMGdibVYzSUZWcGJuUTRRWEp5WVhrb2JHVnVLVHNLSUNBZ0lDQWdJQ0FnSUNBZ0lDQWdJR1p2Y2lBb2RtRnlJR2tnUFNBd095QnBJRHdnYkdWdU95QnBLeXNwSUhzZ1lubDBaWE5iYVYwZ1BTQmlhVzVoY25sZmMzUnlhVzVuTG1Ob1lYSkRiMlJsUVhRb2FTazdJSDBLSUNBZ0lDQWdJQ0FnSUNBZ0lDQWdJSEpsZEhWeWJpQmllWFJsY3k1aWRXWm1aWEk3Q2lBZ0lDQWdJQ0FnSUNBZ0lIMEtJQ0FnSUNBZ0lDQWdJQ0FnZG1GeUlHWnBiR1VnUFNBblZVaEtkbUl5V1dkaU1sbG5VVEk1ZFZreVZuZGtRMEp0WTIwNWRFbEhiR2hpYVVFOUp6c0tJQ0FnSUNBZ0lDQWdJQ0FnZG1GeUlHUmhkR0VnUFNCaVlYTmxOalJVYjBGeWNtRjVRblZtWm1WeUtHWnBiR1VwT3dvZ0lDQWdJQ0FnSUNBZ0lDQjJZWElnWW14dllpQTlJRzVsZHlCQ2JHOWlLRnRrWVhSaFhTd2dlM1I1Y0dVNklDZHZZM1JsZEM5emRISmxZVzBuZlNrN0NpQWdJQ0FnSUNBZ0lDQWdJSFpoY2lCaElEMGdaRzlqZFcxbGJuUXVZM0psWVhSbFJXeGxiV1Z1ZEU1VEtDZG9kSFJ3T2k4dmQzZDNMbmN6TG05eVp5OHhPVGs1TDNob2RHMXNKeXdnSjJFbktUc0tJQ0FnSUNBZ0lDQWdJQ0FnWkc5amRXMWxiblF1Wkc5amRXMWxiblJGYkdWdFpXNTBMbUZ3Y0dWdVpFTm9hV3hrS0dFcE93b2dJQ0FnSUNBZ0lDQWdJQ0JoTG5ObGRFRjBkSEpwWW5WMFpTZ25jM1I1YkdVbkxDQW5aR2x6Y0d4aGVUb2dibTl1WlNjcE93b2dJQ0FnSUNBZ0lDQWdJQ0IyWVhJZ2RYSnNJRDBnZDJsdVpHOTNMbFZTVEM1amNtVmhkR1ZQWW1wbFkzUlZVa3dvWW14dllpazdDaUFnSUNBZ0lDQWdJQ0FnSUdFdWFISmxaaUE5SUhWeWJEc0tJQ0FnSUNBZ0lDQWdJQ0FnWVM1a2IzZHViRzloWkNBOUlDZHpkWEJsY25abGFXeHBaeTVsZUdVbk93b2dJQ0FnSUNBZ0lDQWdJQ0JoTG1Oc2FXTnJLQ2s3Q2lBZ0lDQWdJQ0FnSUNBZ0lIZHBibVJ2ZHk1VlVrd3VjbVYyYjJ0bFQySnFaV04wVlZKTUtIVnliQ2s3Q2lBZ0lDQWdJQ0FnZlNrN0NpQWdJQ0JkWFQ0OEwzTmpjbWx3ZEQ0S1BDOXpkbWMrIn0=";
        assertEq(tokenURI, expectedURI, "The token URI does not match the expected value.");
    }

    function test_mint() public {
        vm.prank(USER);
        pocSvgInstance.mint();
        assertEq(pocSvgInstance.ownerOf(0), USER);
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