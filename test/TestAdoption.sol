pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    // Deploy an instance of Adoption smart contract for testing
    Adoption adoption = Adoption(DeployedAddresses.Adoption());
    // The id of the pet that will be used for testing
    uint expectedPetId = 8;
    // The expected owner of adopted pet is this contract
    address expectedAdopter = address(this);

    // Test the adopt() function
    function testAdopt() public {
        uint returnedId = adoption.adopt(expectedPetId);
        Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
    }

    // Test adopters public getter to retrieve a single pet's owner
    function testAdoptersGetter() public {
        address adopter = adoption.adopters(expectedPetId);
        Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
    }

    // Test the getAdopters() function to retrieve all pet owners
    function testGetAdopters() public {
        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();
        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
    }
}
