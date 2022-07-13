// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

contract MultiSigWallet {

    event Deposit(address indexed sender,uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner,uint indexed txId);
    event Revoke(address indexed owner,uint indexed txId);
    event Execute(uint indexed txId);

    struct Transaction {
        //目标地址
        address to;
        //发送value
        uint value;
        bytes data;
        //是否已执行
        bool executed;
    }

    //钱包的拥有者
    address[] public owners;
    //判断地址是否是拥有者的map
    mapping(address =>bool) public isOwner;
    //需要多少人数同意多签才能通过
    uint public required;

    Transaction[] public transactions;
    //某个交易id下某个地址是否批准了交易
    mapping(uint=>mapping(address=>bool)) public approved;

    //传入多签地址以及交易批准所需的人数
    constructor(address[] memory _owners,uint _required) {
        require(_owners.length > 0,"owners require >=2");
        require(
            _required > 0 && _required <= _owners.length,
            "invalid required number of owners"
        );

        for(uint i;i<_owners.length;i++) {
            address owner = _owners[i];

            require(owner != address(0),"invalid owner");
            require(!isOwner[owner],"owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    //往合约中存款时触发
    receive() external payable {
        emit Deposit(msg.sender,msg.value);
    }

    modifier onlyOwner{
        require(isOwner[msg.sender],"not owner");
        _;
    }

    modifier txExists(uint _txId) {
        require(transactions.length > _txId,"tx not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender],"tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed,"tx already executed");
        _;
    }

    //提交交易
    function submit(address _to,uint _value,bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({
            to : _to,
            value : _value,
            data : _data,
            executed : false
        }));
        emit Submit(transactions.length - 1);
    }

    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender]  = true;
        emit Approve(msg.sender,_txId);
    }

    function _getApprovedCount(uint _txId) private view returns (uint count) {
        for(uint i;i<owners.length;i++) {
            if(approved[_txId][owners[i]]) {
                count++;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovedCount(_txId) >= required,"approvals < required");
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;

        (bool success,) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success,"tx failed");
        emit Execute(_txId);
    }

    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender],"tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);
    }

}