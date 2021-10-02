import { ethers, run } from 'hardhat'

async function main() {
  await run('compile')

  const Token = await ethers.getContractFactory('token')
  const token = await Token.deploy('Asset', 'AST', 100000)

  await token.deployed()

  console.log('Token deployed to:', token.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
