pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IExerciceSolution.sol";


contract ExerciceSolution is ERC721, IExerciceSolution
{
    constructor() ERC721("AlNft", "AFT") public {
        ERC721._mint(0x04a02eb067D6CDC7e4f4C1b112456C94EC38Dd40, 0);
        ERC721._mint(0x40aDC5976f6ae451Dbf9a390d31c7ffB5366b229, 1);

        getOwnerByIndex[address(0x04a02eb067D6CDC7e4f4C1b112456C94EC38Dd40)][0] = 0; 
        getOwnerByIndex[address(0x40aDC5976f6ae451Dbf9a390d31c7ffB5366b229)][0] = 1;
        
    }

    mapping(address => bool) public allowBreeder;
    mapping(address=>mapping(uint=>uint)) getOwnerByIndex;
    // mapping(uint => address) public idToOwner;

    struct Animal {
        uint sex;
        uint legs;
        bool wings;
        string name;
    }

    mapping(uint => Animal) public animals;

	// Breeding function
	function isBreeder(address account) external override returns (bool) {
        allowBreeder[account] = true;
        return allowBreeder[account];
    }

	function registrationPrice() external override returns (uint256) {
        return 1;
    }

	function registerMeAsBreeder() external override payable {
        require(msg.value == 1);
        allowBreeder[msg.sender] = true;
    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external override returns (uint256) {
        require(allowBreeder[msg.sender] == true);
        uint id = totalSupply() + 1;
        animals[id] = Animal(sex, legs, wings, name);
        _mint(msg.sender, id);
        return id;
    }

	function getAnimalCharacteristics(uint animalNumber) external override returns (string memory _name, bool _wings, uint _legs, uint _sex) {
        _name = animals[animalNumber].name;
        _wings = animals[animalNumber].wings;
        _legs = animals[animalNumber].legs;
        _sex = animals[animalNumber].sex;
        return(_name, _wings, _legs, _sex);
    }

	function declareDeadAnimal(uint animalNumber) external override {
        // require(allowBreeder[msg.sender] == true);
        require(ownerOf(animalNumber) == msg.sender);
        _burn(animalNumber);
        animals[animalNumber].name = "";
        animals[animalNumber].wings = false;
        animals[animalNumber].legs = 0;
        animals[animalNumber].sex = 0;
    }


	function tokenOfOwnerByIndex(address owner, uint256 index) public override(ERC721, IExerciceSolution) view returns (uint256) {
        return getOwnerByIndex[owner][index];
    }

	// Selling functions
	function isAnimalForSale(uint animalNumber) external override view returns (bool) {
        return true;
    }

	function animalPrice(uint animalNumber) external override view returns (uint256) {
        return 1;
    }

	function buyAnimal(uint animalNumber) external override payable {

    }

	function offerForSale(uint animalNumber, uint price) external override {

    }

	// Reproduction functions

	function declareAnimalWithParents(uint sex, uint legs, bool wings, string calldata name, uint parent1, uint parent2) external override returns (uint256) {
        return 1;
    }

	function getParents(uint animalNumber) external override returns (uint256, uint256) {
        return (1, 1);
    }

	function canReproduce(uint animalNumber) external override returns (bool) {
        return true;
    }

	function reproductionPrice(uint animalNumber) external override view returns (uint256) {
        return 1;
    }

	function offerForReproduction(uint animalNumber, uint priceOfReproduction) external override returns (uint256) {
        return 1;
    }

	function authorizedBreederToReproduce(uint animalNumber) external override returns (address) {
        address newAddress;
        return newAddress;
    }

	function payForReproduction(uint animalNumber) external override payable {

    }
}
