#! /usr/local/bin/node
var inquirer = require('inquirer');
var exec = require('child_process').execSync;

var games = [
  'vms-empire',
  'curseofwar',
  'ninvaders',
  'bs',
  'vitetris',
  '### GUI GAMES ###',
  'dwarffortress'
];

inquirer.prompt([{
  type: 'list',
  name: 'game',
  message: 'What do you want to play?',
  choices: games,
}]).then(function(answers) {
  console.log(exec('~/.scripts/play ' + answers.game).toString());
});
