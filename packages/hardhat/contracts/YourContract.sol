pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  // Make owner a state variable with value type address and make it public
  address public owner = 0x623bb5f303cb3285F24c2f16d5E456699DA28489;

  // Have a mapping of address to students, you can give the mapping any name of your choice
  mapping(address=>student)students;

  // Custom Error
  error AlreadyRegistered();

  // Have a constructor that ensures that owner is equal to the msg.sender
  constructor() {
    // owner = msg.sender;
  }

  // Have a modifier called onlyOwner and require that msg.sender = owner
  modifier onlyOwner() {
    require(msg.sender == owner, "NOT AUTHORIZED TO REGISTER A STUDENT");
    _;
  }

  // Have a struct to contain details of students
  struct student {
    address studentID;
    string name;
    uint8 totalMarks;
    uint8 percentage;
    bool hasRegistered;
  }

  // Have a function to register students and it should be onlyOwner (function register(address studentID) then add all the rest details of the student from your struct to the argument of this function)
  function registerStudent(address studentID, string memory name, uint8 percentage, uint8 totalMarks) public onlyOwner {
    // Make sure that student cannot register twice plus custom error message
    if(students[studentID].hasRegistered){
      revert AlreadyRegistered();
    }
    students[studentID] = student(studentID, name, totalMarks, percentage, true);
  }

  // Have a function to get student details and it accepts one argument. function getStudentDetails(address studentID)
  function getStudentDetails(address studentID) public view returns(address, string memory, uint8, uint8) {
    return(students[studentID].studentID, students[studentID].name, students[studentID].totalMarks, students[studentID].percentage);
  }

}
