const hre = require("hardhat");
const { ethers } = require("ethers");

async function main() {
  const [signer] = await hre.ethers.getSigners();
  //  console.log(await signer.getBalance());
  //console.log(signer);
  console.log("signer.address", signer.address);
  const balance = await hre.ethers.provider.getBalance(signer.address);
  console.log(ethers.formatEther(balance), "ETH");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
