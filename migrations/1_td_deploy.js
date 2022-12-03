const ExerciceSolution = artifacts.require("ExerciceSolution");

const EvaluatorAddressGoerli1 = "0x40aDC5976f6ae451Dbf9a390d31c7ffB5366b229";

module.exports = function (deployer, network, accounts) {
	deployer.deploy(ExerciceSolution)
};