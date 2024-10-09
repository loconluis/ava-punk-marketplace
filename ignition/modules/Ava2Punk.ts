import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

const MAX_SUPPLY_CONST = 10000;
const AvaPunkModule = buildModule('AvaPunkModule', (m) => {
  const maxSupply = m.getParameter('maxSupply', MAX_SUPPLY_CONST);
  const avaPunk = m.contract('AvaPunk', [maxSupply]);

  return { avaPunk };
});

export default AvaPunkModule;
