//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract EventOrg{
    struct Event{
     address organizer;
     string name;
     uint date;
     uint price;
     uint no_of_tickets;
     uint tickets_rem;
    }

    mapping (uint =>Event) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nextId;
 
 
    function createEvent(string memory name,uint date,uint price,uint ticketCount) external{
     require(date>block.timestamp,"you can organize event for upcoming dates");
     require(ticketCount>0,"Number of tickets must be greater than zero");
 
     events[nextId] = Event(msg.sender,name,date,price,ticketCount,ticketCount);
     nextId++;
    }
 
    function buyTicket(uint id,uint quantity) external payable{
       require(events[id].date!=0,"Event does not exist");
       require(events[id].date>block.timestamp,"Event has already occured");
       Event storage _event = events[id];
       require(msg.value==(_event.price*quantity),"Ethere is not enough");
       require(_event.tickets_rem>=quantity,"Not enough tickets");
       _event.tickets_rem-=quantity;
       tickets[msg.sender][id]+=quantity;
 
    }

    function transferTicket(uint id,uint quantity,address to) external{
       require(events[id].date!=0,"Event does not exist");
       require(events[id].date>block.timestamp,"Event has already occured");
       require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
       tickets[msg.sender][id]-=quantity;
       tickets[to][id]+=quantity;
    }


    

    

}
