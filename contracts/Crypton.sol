pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "./interfaces/IFarmingPool.sol";
import "./accounting/FarmAccounting.sol";
import "./accounting/UserAccounting.sol";

contract Crypton {

    constructor() {
        ERC20(
            string(abi.encodePacked("Farming of ", stakingToken_.name())),
            string(abi.encodePacked("farm", stakingToken_.symbol()))
        )
    }    

    function deposit(uint256 amount) external override {
        _mint(msg.value, amount);
    }

    function withdraw(uint256 amount) public override {
        _burn(msg.sender, amount);
    }

}