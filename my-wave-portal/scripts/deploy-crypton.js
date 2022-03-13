deploy-crypton.js

const DEPLOYER = process.env.DEPLOYER || "";

const Crypton = artifacts.require("Crypton");

async function main() {
    const crypton = await Crypton.deploy({frim: DEPLOYER});

    console.log("contract deployed: ", crypton.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });