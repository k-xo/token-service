// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract Token is ERC20, ERC20Burnable {
    address owner;

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

    function mint(uint256 amount) public onlyOwner {
        _mint(owner, amount);
    }
}
