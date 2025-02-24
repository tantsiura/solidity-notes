// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//Vote Storage

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
        Choices choice;
        address voter;
    }

	Vote public vote;

	function createVote(Choices choice) external {
        vote = Vote(choice, msg.sender);
    }
}

//Vote Memory
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external returns (Vote memory) {
        Vote memory newVote = Vote(choice, msg.sender);
        votes.push(newVote);
        return newVote;
    }
}

//Vote Array
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external returns (Vote memory) {
        Vote memory newVote = Vote(choice, msg.sender);
        votes.push(newVote);
        return newVote;
    }
}

//Choice Lookup
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external returns (Vote memory) {
        Vote memory newVote = Vote(choice, msg.sender);
        votes.push(newVote);
        return newVote;
    }

    function hasVoted(address _voter) external view returns (bool) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address _voter) external view returns(Choices) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return votes[i].choice;
            }
        }
        return Choices.Yes;
    }
}

//Single Vote
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    mapping(address => bool) public voters;

    function createVote(Choices choice) external returns (Vote memory) {
        require(!voters[msg.sender], "You have already voted.");
        Vote memory newVote = Vote(choice, msg.sender);
        votes.push(newVote);
        voters[msg.sender] = true;
        return newVote;
    }

    function hasVoted(address _voter) external view returns (bool) {
        return voters[_voter];
    }

    function findChoice(address _voter) external view returns(Choices) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return votes[i].choice;
            }
        }
        return Choices.Yes;
    }
}

//Change Vote
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    mapping(address => bool) public voters;

    function createVote(Choices choice) external returns (Vote memory) {
        require(!voters[msg.sender], "You have already voted.");
        Vote memory newVote = Vote(choice, msg.sender);
        votes.push(newVote);
        voters[msg.sender] = true;
        return newVote;
    }

    function changeVote(Choices newChoice) external {
        bool hasVoted = false;
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender) {
                votes[i].choice = newChoice;
                hasVoted = true;
                break;
            }
        }
        require(hasVoted, "You have not voted yet.");
    }

    function hasVoted(address _voter) external view returns (bool) {
        return voters[_voter];
    }

    function findChoice(address _voter) external view returns(Choices) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return votes[i].choice;
            }
        }
        return Choices.Yes;
    }
}
