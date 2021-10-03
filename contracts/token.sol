// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

/// @title ERC-20 token
/// @author k-xo
/// @notice ERC-20 token spec
contract Token is ERC20, ERC20Burnable {
    address public owner;

    /// @notice Deploys the ERC-20 token and mints the total supply to the owner -- factory owner
    /// @param name sets name of the ERC-20 token
    /// @param symbol sets symbol of the ERC-20 token
    /// @param supply sets supply of the ERC-20 token
    constructor(
        string memory name,
        string memory symbol,
        uint256 supply,
        address _owner
    ) ERC20(name, symbol) {
        owner = _owner;
        _mint(_owner, supply);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /// @notice sets the amount of new supply to be minted to owner
    /// @param amount the amount to be minted
    function mint(uint256 amount) public onlyOwner {
        _mint(owner, amount);
    }
}
