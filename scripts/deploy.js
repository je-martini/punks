const deploy = async () => {
  
  const [deployer] = await ethers.getSigners();

  console.log("this is the account: ", deployer.address);
  
  const punks3 = await ethers.getContractFactory("punks3");

  const deployed = await punks3.deploy(10000);

  console.log("punks was deploy at: ", deployed.target);
};

deploy()
 .then(() => process.exit(0))
 .catch((error) => {
  console.log(error);
  process.exit(1);
 })

