// restart the game, e.g. because of unexpected data or to clean up the plugins

//Append each parameter
var params;
params = "-restart";
for(a = 1; a <= parameter_count(); a += 1) params += " "+parameter_string(a);

//Restart
execute_program(parameter_string(0), params, false);
game_end();
