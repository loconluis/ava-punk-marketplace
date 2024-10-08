// import { expect } from "chai";
import { ethers } from "hardhat";

describe("AvaPunk", function () {
  it("Deploying....", async () => {
    const AvaPunk = await ethers.getContractFactory("AvaPunk");
    const deployed = await AvaPunk.deploy();
    console.log("AvaPunk is deployed at: ", await deployed.getAddress());
  });
});
