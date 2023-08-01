const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("contract", () => {

    const setup =  async ({max_supply = 10000}) => {
        const [owner] = await ethers.getSigners();  
        const punks = await ethers.getContractFactory("punks3");
        const deployed = await punks.deploy(max_supply);
        
        return {
            owner,
            deployed,
        }
    }


    describe("deployment hola", () => {
        it('set nax supply to passed param', async () => {
            const max_supply = 4000;

            const {deployed} = await setup({max_supply});

            const returned_max_supply = await deployed.max_supply();

            expect(max_supply).to.equal(returned_max_supply)
        })
    });

    describe("minting", () => {
        it("minting", async () =>{
            const {owner, deployed} = await setup({});

            await deployed.mint();

            const owner_of_minted = await deployed.ownerOf(0);

            expect(owner_of_minted).to.equal(owner.address);
        })

        it("has a minting limit", async () => {
            const max_supply = 2;

            const { deployed } = await setup({max_supply});

            // minting

            await Promise.all([deployed.mint(), deployed.mint()])
            // assert the last minting

            await expect(deployed.mint()).to.be.revertedWith("no more punks :( ")
        })
    });

    describe('token URI', () => {
        it('returns valid metadata', async () => {
            const {deployed} = await setup({});

            await deployed.mint();

            const token_URI = await deployed.tokenURI(0);
            const stringified_token_uri = await token_URI.toString();

            const [ prefix, base64_JSON] = stringified_token_uri.split(
                "data:application/json;base64,");
            const stringified_metadata = await Buffer.from(base64_JSON, "base64").toString("ascii"); 
            
            const metadata = JSON.parse(stringified_metadata);

            expect(metadata).to.have.all.keys("name", "description", "image");
        })
    })
})