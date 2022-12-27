// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract toDOList
{
    uint public taskCount=0;
    struct task{
        uint id;
        string task;
        bool status;
    }

    mapping(uint=>task) public tasks;

    //creating task
    function createTask(string memory _task) public 
    {
        taskCount++;
        tasks[taskCount]= task(taskCount,_task,false);
    }
 
    //function for completing task
    function completeTask(uint _id) public{
       tasks[_id].status = true;
       taskCount--;
    }

    // function getList(uint _id) public{
    //     for(uint i=0; i<taskCount;i++){
            
    //     }
    // }
}
