// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const AvaPunkModule = buildModule("AvaPunkModule", (m) => {
  const avaPunk = m.contract("AvaPunk");

  return { avaPunk };
});

export default AvaPunkModule;
