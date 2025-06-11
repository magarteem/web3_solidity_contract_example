import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LockModule = buildModule("LockModule", (m) => {
  const initialSupply = m.getParameter("initialSupply", 1000000);
  const myToken = m.contract("itContract", [initialSupply]);

  return { myToken };
});

export default LockModule;
