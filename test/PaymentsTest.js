const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Payments", function () {
  let acc1;
  let acc2;
  let payments;

  beforeEach(async function () {
    [acc1, acc2] = await ethers.getSigners();
    const Payments = await ethers.getContractFactory("Payments", acc1);
    payments = await Payments.deploy();
    //await payments.deployed();
  });

  it("should be deployed", async function () {
    console.log("Success !");
    console.log(payments.runner.address);
    expect(payments.runner.address).to.be.properAddress;
  });

  it("should have 0 ether by default", async function () {
    const balance = await payments.currentBalance();
    console.log("balance", balance);
    expect(balance).to.eq(0);
  });

  it("should be possible to sent funds", async function () {
    const sum = 99;
    const msg = "hello";
    //const tx = await payments.pay("hello", { value: sum });
    //await tx.wait();

    //const balance = await payments.currentBalance();
    //console.log("4444", balance);

    const tx = await payments.connect(acc2).pay(msg, { value: sum });
    //проверка  на уменьшение баланса на акк2
    //await expect(() => tx).to.changeEtherBalance(acc2, -sum);
    //await tx.wait();

    //проверка сразу на  отправляемом и принимаемом аккаунтах стало меньше и больше
    await expect(() => tx).to.changeEtherBalances(
      [acc2, payments],
      [-sum, sum]
    );
    await tx.wait();

    //const balance = await payments.currentBalance();
    //console.log(balance);

    //инфо о последнем платеже
    const newPayment = await payments.getPayments(acc2.address, 0); //откуда отправляли, номер платежа - 0 (первый)
    console.log(newPayment);

    expect(newPayment.message).to.eq(msg); // проверка на корректное сообщение
    expect(newPayment.amount).to.eq(sum); // проверка на корректную смумму
    expect(newPayment.from).to.eq(acc2.address); // проверка от кого
  });
});
