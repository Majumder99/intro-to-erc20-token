const hre = require("hardhat");

async function main() {
  const SouravToken = await hre.ethers.getContractFactory("SouravToken");
  const souravtoken = await SouravToken.deploy(100000000, 50);
  await souravtoken.deployed();
  console.log("Contract address", souravtoken.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
