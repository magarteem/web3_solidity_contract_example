import { loadFixture, ethers, expect } from "./setup";

describe("Payments", function () {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("Payments");
    const payments = await Factory.deploy();
    await payments.waitForDeployment();

    return { user1, user2, payments };
  }

  it("should be Deployed", async function () {
    const { user1, user2, payments } = await loadFixture(deploy);

    console.log(await payments.getAddress());
    console.log(user1.address);
    console.log(user2.address);

    expect(payments.target).to.be.properAddress;
  });

  it("should have 0 ethers by default", async function () {
    const { user1, user2, payments } = await loadFixture(deploy);
    const balance = await payments.currentBalance(); // 'это функция из контракта
    // или если там нет такой функции то
    //const balance2 = await ethers.provider.getBalance(payments.target)

    expect(balance).to.eq(0);
  });

  it("should be possible to send fund", async function () {
    const { user1, user2, payments } = await loadFixture(deploy);
    const sum = 99;
    const msg = "hello";

    console.log(await ethers.provider.getBalance(user1.address));
    await payments.pay(msg, { value: sum }); // value так как фу-я отмечена как payable,     деньги спишутся от перволго юзера
    //если хотим что бы платил второй юзер то connect(user2)
    const tx = await payments.connect(user2).pay(msg, { value: sum }); // value так как фу-я отмечена как payable,     деньги спишутся от перволго юзера
    //console.log(await ethers.provider.getBalance(user1.address));

    const receipt = await tx.wait(1);
    console.log(receipt);
    const currentBlock = await ethers.provider.getBlock(
      await ethers.provider.getBlockNumber()
    );

    //в tx история транзацкии хранится. проверяем точно ли оплатил юзер2
    await expect(tx).to.be.changeEtherBalance(user2, -sum);

    expect(payments.target).to.be.properAddress;

    //проверяеем что после платежа создался payment и сохранился в блокчейн
    const newPayment = await payments.getPayments(user2.address, 0);

    expect(newPayment.message).to.eq(msg);
    expect(newPayment.amount).to.eq(sum);
    expect(newPayment.from).to.eq(user2.address);
    expect(newPayment.timestamp).to.eq(currentBlock?.timestamp);
  });
});
