// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FinalVoting {
    string[] public proposals = ["Apple", "Banana", "Cherry"];
    mapping(string => uint256) public votes;
    mapping(address => bool) public hasVoted;

    // Oy kullanma
    function vote(string calldata proposal) external {
        require(!hasVoted[msg.sender], "Already voted");
        bool valid = false;
        for (uint i = 0; i < proposals.length; i++) {
            if (keccak256(bytes(proposals[i])) == keccak256(bytes(proposal))) {
                valid = true;
                break;
            }
        }
        require(valid, "Invalid proposal");
        votes[proposal]++;
        hasVoted[msg.sender] = true;
    }

    // Oy sayısını görme
    function getVotes(string calldata proposal) external view returns (uint256) {
        return votes[proposal];
    }

    // Kazananı bulma
    function winningProposal() external view returns (string memory winner) {
        uint256 highest = 0;
        winner = proposals[0];
        for (uint i = 0; i < proposals.length; i++) {
            if (votes[proposals[i]] > highest) {
                highest = votes[proposals[i]];
                winner = proposals[i];
            }
        }
    }
}
