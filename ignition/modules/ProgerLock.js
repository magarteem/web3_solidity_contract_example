import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LockModule = buildModule("ItModule", (m) => {
  const initialSupply = m.getParameter("initialSupply", 1000000);
  const myToken = m.contract("Proger", [initialSupply]);

  return { myToken };
});

export default LockModule;
