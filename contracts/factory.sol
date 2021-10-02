// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './token.sol';

/// @title Token Factory
/// @author k-xo
/// @notice Deploys ERC-20 tokens with mintable and burnable supply
contract Factory {
    Token[] public tokens;
    address public factoryOwner;

    constructor() {
        factoryOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == factoryOwner);
        _;
    }

    /// @notice Emitted when a 'createToken' is called
    /// @param tokenAddress address of deployed tokenAddress
    /// @param name name of deployed token
    /// @param symbol symbol of deployed token
    event TokenCreated(address tokenAddress, string name, string symbol);

    /// @notice creates an ERC-20 token
    /// @param name sets the name of the token
    /// @param symbol sets the symbol of the token
    /// @param supply sets the supply of the token
    function createToken(
        string memory name,
        string memory symbol,
        uint256 supply
    ) public onlyOwner {
        Token token = new Token(name, symbol, supply, msg.sender);
        tokens.push(token);

        emit TokenCreated(address(token), name, symbol);
    }

    /// @notice returns the list of deployed tokens
    function getTokens() public view returns (Token[] memory) {
        return tokens;
    }
}
