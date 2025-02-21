// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SentimentVoting {

    // Enum to represent the voting options
    enum VoteOption { Neutral, Positive, Negative }
    
    // Structure to keep track of the votes for each sentiment option
    struct Votes {
        uint positiveVotes;
        uint negativeVotes;
        uint neutralVotes;
    }

    // Mapping to store the current votes count
    Votes public currentVotes;

    // Public function to increment the vote for a specific sentiment
    function vote(uint8 sentiment) public {
        require(sentiment >= 0 && sentiment <= 2, "Invalid vote choice");

        if (sentiment == uint8(VoteOption.Positive)) {
            currentVotes.positiveVotes++;
        } else if (sentiment == uint8(VoteOption.Negative)) {
            currentVotes.negativeVotes++;
        } else {
            currentVotes.neutralVotes++;
        }
    }

    // Function to return the current voting results
    function getCurrentVotes() public view returns (uint positive, uint negative, uint neutral) {
        return (currentVotes.positiveVotes, currentVotes.negativeVotes, currentVotes.neutralVotes);
    }
}

