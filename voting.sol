// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Proposal
contract Voting {
    struct Proposal {
        address target; 
        bytes data;    
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address target, bytes calldata data) external {
        Proposal memory newProposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });

        proposals.push(newProposal);
    }
}

//Cast a Vote
contract Voting {
    struct Proposal {
        address target; 
        bytes data;    
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address target, bytes calldata data) external {
        Proposal memory newProposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });

        proposals.push(newProposal);
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }
    }

    function getVoteCounts(uint proposalId) external view returns (uint yesCount, uint noCount) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.yesCount, proposal.noCount);
    }
}

//Multiple Votes
contract Voting {
    struct Proposal {
        address target; 
        bytes data;    
        uint256 yesCount;
        uint256 noCount;
        mapping(address => bool) voters; // Track if the voter has voted
        mapping(address => bool) votes; // Track the actual vote (true for yes, false for no)
    }

    Proposal[] public proposals;

    function newProposal(address target, bytes calldata data) external {
        Proposal storage newProposal = proposals.push(); // Create a new proposal
        newProposal.target = target;
        newProposal.data = data;
        newProposal.yesCount = 0;
        newProposal.noCount = 0;
    }

    function castVote(uint256 proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        // Check if the voter has already voted
        if (proposal.voters[msg.sender]) {
            // If they have voted, update the counts based on the previous vote
            if (proposal.votes[msg.sender]) {
                // Voter previously voted 'yes'
                proposal.yesCount -= 1;
            } else {
                // Voter previously voted 'no'
                proposal.noCount -= 1;
            }
        }

        // Update the vote
        if (support) {
            proposal.yesCount += 1;
            proposal.votes[msg.sender] = true; // Mark the vote as 'yes'
        } else {
            proposal.noCount += 1;
            proposal.votes[msg.sender] = false; // Mark the vote as 'no'
        }

        // Mark the voter as having voted
        proposal.voters[msg.sender] = true; 
    }

    function getVoteCounts(uint256 proposalId) external view returns (uint256 yesCount, uint256 noCount) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.yesCount, proposal.noCount);
    }
}

//Voting Events
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        mapping(address => bool) voters;
        mapping(address => bool) votes;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint256 proposalId);
    event VoteCast(uint256 proposalId, address voter);

    function newProposal(address target, bytes calldata data) external {
        Proposal storage newProposal = proposals.push();
        newProposal.target = target;
        newProposal.data = data;
        newProposal.yesCount = 0;
        newProposal.noCount = 0;

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint256 proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        if (proposal.voters[msg.sender]) {
            if (proposal.votes[msg.sender]) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        if (support) {
            proposal.yesCount += 1;
            proposal.votes[msg.sender] = true;
        } else {
            proposal.noCount += 1;
            proposal.votes[msg.sender] = false;
        }

        proposal.voters[msg.sender] = true;

        emit VoteCast(proposalId, msg.sender);
    }

    function getVoteCounts(uint256 proposalId) external view returns (uint256 yesCount, uint256 noCount) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.yesCount, proposal.noCount);
    }
}

//Members
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        mapping(address => bool) voters;
        mapping(address => bool) votes;
    }

    Proposal[] public proposals;
    mapping(address => bool) public isAllowed;

    event ProposalCreated(uint256 proposalId);
    event VoteCast(uint256 proposalId, address voter);

    // Constructor to initialize allowed addresses
    constructor(address[] memory allowedAddresses) {
        isAllowed[msg.sender] = true; // Allow the deployer
        for (uint256 i = 0; i < allowedAddresses.length; i++) {
            isAllowed[allowedAddresses[i]] = true; // Allow specified addresses
        }
    }

    // Modifier to restrict access to allowed addresses
    modifier onlyAllowed() {
        require(isAllowed[msg.sender], "Not allowed to create proposals or vote");
        _;
    }

    function newProposal(address target, bytes calldata data) external onlyAllowed {
        Proposal storage newProposal = proposals.push();
        newProposal.target = target;
        newProposal.data = data;
        newProposal.yesCount = 0;
        newProposal.noCount = 0;

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint256 proposalId, bool support) external onlyAllowed {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        if (proposal.voters[msg.sender]) {
            if (proposal.votes[msg.sender]) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        if (support) {
            proposal.yesCount += 1;
            proposal.votes[msg.sender] = true;
        } else {
            proposal.noCount += 1;
            proposal.votes[msg.sender] = false;
        }

        proposal.voters[msg.sender] = true;

        emit VoteCast(proposalId, msg.sender);
    }

    function getVoteCounts(uint256 proposalId) external view returns (uint256 yesCount, uint256 noCount) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.yesCount, proposal.noCount);
    }
}

//Execute
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        mapping(address => bool) voters;
        mapping(address => bool) votes;
        bool executed; // New variable to track if the proposal has been executed
    }

    Proposal[] public proposals;
    mapping(address => bool) public isAllowed;

    event ProposalCreated(uint256 proposalId);
    event VoteCast(uint256 proposalId, address voter);
    event ProposalExecuted(uint256 proposalId); // New event for proposal execution

    // Constructor to initialize allowed addresses
    constructor(address[] memory allowedAddresses) {
        isAllowed[msg.sender] = true; // Allow the deployer
        for (uint256 i = 0; i < allowedAddresses.length; i++) {
            isAllowed[allowedAddresses[i]] = true; // Allow specified addresses
        }
    }

    // Modifier to restrict access to allowed addresses
    modifier onlyAllowed() {
        require(isAllowed[msg.sender], "Not allowed to create proposals or vote");
        _;
    }

    function newProposal(address target, bytes calldata data) external onlyAllowed {
        Proposal storage newProposal = proposals.push();
        newProposal.target = target;
        newProposal.data = data;
        newProposal.yesCount = 0;
        newProposal.noCount = 0;
        newProposal.executed = false; // Initialize executed status

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint256 proposalId, bool support) external onlyAllowed {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        // Check if the voter has already voted
        if (proposal.voters[msg.sender]) {
            if (proposal.votes[msg.sender]) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        // Update the vote counts
        if (support) {
            proposal.yesCount += 1;
            proposal.votes[msg.sender] = true;
        } else {
            proposal.noCount += 1;
            proposal.votes[msg.sender] = false;
        }

        proposal.voters[msg.sender] = true;

        emit VoteCast(proposalId, msg.sender);

        // Check if the proposal can be executed
        if (proposal.yesCount == 10 && !proposal.executed) {
            executeProposal(proposalId);
        }
    }

    function executeProposal(uint256 proposalId) internal {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        // Execute the proposal
        (bool success, ) = proposal.target.call(proposal.data);
        require(success, "Proposal execution failed");

        proposal.executed = true; // Mark the proposal as executed
        emit ProposalExecuted(proposalId); // Emit execution event
    }

    function getVoteCounts(uint256 proposalId) external view returns (uint256 yesCount, uint256 noCount) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.yesCount, proposal.noCount);
    }
}
