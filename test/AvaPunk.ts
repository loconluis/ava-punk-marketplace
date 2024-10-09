// import { expect } from "chai";
import { ethers } from 'hardhat';
import { expect } from 'chai';

describe('AvaPunk Contract', function () {
  const setup = async ({ maxSupply = 10000 }) => {
    const [owner] = await ethers.getSigners();
    const AvaPunk = await ethers.getContractFactory('AvaPunk');
    const deployed = await AvaPunk.deploy(maxSupply);

    return {
      owner,
      deployed,
    };
  };

  describe('Deployment', () => {
    it('Deploying....', async () => {
      const maxSupply = 10000;
      const { deployed } = await setup({ maxSupply });
      console.log('AvaPunk is deployed at: ', await deployed.getAddress());
    });

    it('Sets max supply to passed params', async () => {
      const maxSupply = 4000;
      const { deployed } = await setup({ maxSupply });
      const returnedMaxSupply = await deployed.maxSupply();

      expect(maxSupply).to.equal(returnedMaxSupply);
    });
  });

  describe('Minting ------>', () => {
    it('Mint a new token and assigns it to owner', async () => {
      const { owner, deployed } = await setup({});
      await deployed.mint();
      const ownerOfMinted = await deployed.ownerOf(0);
      expect(ownerOfMinted).to.equal(owner.address);
    });

    it('Has a minting limit', async () => {
      const maxSupply = 2;
      const { deployed } = await setup({ maxSupply });

      // Mint all
      await deployed.mint();
      await deployed.mint();

      // Assertion the last minting
      await expect(deployed.mint()).to.be.revertedWith('Not AvaPunk Left :(');
    });
  });

  describe('TokenURI', () => {
    it('Returns a valid metadata', async () => {
      const { deployed } = await setup({});

      await deployed.mint();

      const tokenURI = await deployed.tokenURI(0);

      const stringifyTokenURI = await tokenURI.toString();
      const [, base64JSON] = stringifyTokenURI.split('data:application/json;base64');

      const stringifyMetadata = await Buffer.from(base64JSON, 'base64').toString('ascii');

      const metadata = JSON.parse(stringifyMetadata);
      expect(metadata).to.have.all.keys('name', 'description', 'image');
    });
  });
});
