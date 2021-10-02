import { Contract, ContractFactory } from '@ethersproject/contracts';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import { ethers } from 'hardhat';
import tokenAbi from '../artifacts/contracts/token.sol/Token.json';

describe('Token', function () {
  let Factory: ContractFactory;
  let factory: Contract;
  let token: Contract;
  let tokenAddress: any;
  let deployer: SignerWithAddress;

  beforeEach(async () => {
    [deployer] = await ethers.getSigners();

    //deploy token factory
    Factory = await ethers.getContractFactory('Factory');
    factory = await Factory.deploy();

    await factory.deployed();

    //deploy token
    await factory.createToken('Asset', 'AST', 100000);
    [tokenAddress] = await factory.getTokens();

    token = new ethers.Contract(tokenAddress, tokenAbi.abi, deployer);
  });

  it('Should return the correct total supply', async function () {
    expect(await token.totalSupply()).to.equal(100000);
  });

  it('Should return the correct total supply after a burn', async function () {
    await token.burn(100);
    expect(await token.totalSupply()).to.equal(99900);
  });

  it('Should be able to increase the total supply', async function () {
    await token.mint(100);
    expect(await token.totalSupply()).to.equal(100100);
  });

  it('Should mint the total supply to the deployer', async function () {
    expect(await token.balanceOf(await deployer.getAddress())).to.equal(await token.totalSupply());
  });

  it('Should expect factory and token to have the same owner', async function () {
    expect(await factory.factoryOwner()).to.equal(await token.owner());
  });
});
