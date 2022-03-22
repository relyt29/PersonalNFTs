// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../PersonalNFTs.sol";

contract ContractTest is DSTest {
    PersonalNFTs p;

    function setUp() public {
        p = new PersonalNFTs("","");
    }

    function testExample() public {
        assertTrue(true);
    }
}
