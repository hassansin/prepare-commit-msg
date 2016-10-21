#! /bin/sh

setUp() {
    originalPath=$PATH
    PATH=$PWD:$PATH
	touch GIT_BRANCH
    touch COMMIT_MSG
}

tearDown() {
    PATH=$originalPath
    rm -f GIT_BRANCH COMMIT_MSG
}


testNoIssueInBranch()
{
    echo 'commit message' > COMMIT_MSG
    echo 'master' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "Commit message"
}

testCapitalCaseBranch()
{
    echo 'commit message' > COMMIT_MSG
    echo 'CW-255' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CW-255: Commit message"
}

testLowerCaseBranch()
{
    echo 'commit message' > COMMIT_MSG
    echo 'cw-255' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CW-255: Commit message"
}


testExtraTextAfterBranch()
{
    echo 'commit message' > COMMIT_MSG
    echo 'CW-255-some-text' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CW-255: Commit message"
}

testExtraTextBeforeBranch()
{
    echo 'commit message' > COMMIT_MSG
    echo 'some-branch-cww-100' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CWW-100: Commit message"
}


testDifferentIssueInCommitAndBranch_1()
{
    echo 'some commit message BW-100' > COMMIT_MSG
    echo 'CW-100' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CW-100: Some commit message BW-100"
}

testDifferentIssueInCommitAndBranch_2()
{
    echo 'some commit message CWW-100 and more' > COMMIT_MSG
    echo 'CW-100' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "CW-100: Some commit message CWW-100 and more"
}

testSameIssueInCommitAndBranch_1()
{
    echo 'some commit message CW-100' > COMMIT_MSG
    echo 'CW-100' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "Some commit message CW-100"
}

testMultipleIssuesInCommit()
{
    echo 'some commit message pw-1111,cw-100 and bw-200' > COMMIT_MSG
    echo 'CW-100-some-text' > GIT_BRANCH
    ./prepare-commit-msg ./COMMIT_MSG "message"
    assertEquals "$(cat ./COMMIT_MSG)" "Some commit message pw-1111,cw-100 and bw-200"
}

# load shunit2
. ./shunit2
