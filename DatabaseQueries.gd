extends Node

var player_table = "Player"
var player_character_table = "PlayerCharacter"
var race_table = "Race"
var class_table = "CharacterClass"
var map_table = "Map"

################
# Player table #
################

func create_player_table():
	var query
	
	query = "CREATE TABLE IF NOT EXISTS " + player_table + " (";
	query += "login text PRIMARY KEY,";
	query += "password_hash integer NOT NULL,";
	query += "email text UNIQUE NOT NULL";
	query += ");";
	
	return query
	
func insert_player(): 
	return "INSERT INTO " + player_table + "(login, password_hash, email) VALUES(?,?,?);"
	
func select_player(function = ""):
	if function == "":
		return "SELECT * FROM " + player_table + " WHERE login = ?;"
		
	if (function == "has_email" ||
	    function == "email"):
		return "SELECT * FROM " + player_table + " WHERE email = ?;"
		
##########################
# Player character table #
##########################
	
func create_player_character_table():
	var query
	
	query = "CREATE TABLE IF NOT EXISTS " + player_character_table + " (";
	query += "name text PRIMARY KEY,";
	query += "player_fk text NOT NULL,";
	query += "race_fk text NOT NULL,";
	query += "class_fk text NOT NULL,";
	query += "respawn_map_fk text NOT NULL DEFAULT 'TestMap',";
	query += "logout_map_fk text NOT NULL DEFAULT 'TestMap',";
	query += "logout_x integer DEFAULT 0,";
	query += "logout_y integer DEFAULT 0,";
	query += "FOREIGN KEY(player_fk) REFERENCES " + player_table + "(login),";
	query += "FOREIGN KEY(race_fk) REFERENCES " + player_table + "(name),";
	query += "FOREIGN KEY(class_fk) REFERENCES " + class_table + "(name),";
	query += "FOREIGN KEY(respawn_map_fk) REFERENCES " + map_table + "(name),";
	query += "FOREIGN KEY(logout_map_fk) REFERENCES " + map_table + "(name)";
	query += ");";
	
	return query
	
func insert_player_character():
	return "INSERT INTO " + player_character_table + "(name, player_fk, race_fk, class_fk) VALUES(?,?,?,?);"
	
func select_player_character():
	return "SELECT * FROM " + player_character_table + " WHERE name = ?;"
	
func select_player_characters():
	return "SELECT * FROM " + player_character_table + " WHERE player_fk = ?;"
	
func delete_player_character():
	return "DELETE FROM " + player_character_table + " WHERE name = ?;"
	
##############
# Race table #
##############

func create_race_table():
	var query
	
	query = "CREATE TABLE IF NOT EXISTS " + race_table + " (";
	query += "name text PRIMARY KEY";
	query += ");";
	
	return query
	
func insert_race():
	return "INSERT INTO " + race_table + "(name) VALUES(?);"
	
func select_race():
	return "SELECT * FROM " + race_table + " WHERE name = ?;"
	
###############
# Class table #
###############

func create_class_table():
	var query
	
	query = "CREATE TABLE IF NOT EXISTS " + class_table + " (";
	query += "name text PRIMARY KEY,";
	query += "race_fk text NOT NULL,";
	query += "FOREIGN KEY(race_fk) REFERENCES " + race_table + "(name)";
	query += ");";
	
	return query
	
func insert_class():
	return "INSERT INTO " + class_table + "(name, race_fk) VALUES(?,?);"
	
func select_class():
	return "SELECT * FROM " + class_table + " WHERE name = ?;"
	
#############
# Map table #
#############

func create_map_table():
	var query
	
	query = "CREATE TABLE IF NOT EXISTS " + map_table + " (";
	query += "name text PRIMARY KEY";
	query += ");";
	
	return query
	
func insert_map():
	return "INSERT INTO " + map_table + "(name) VALUES(?);"
	
func select_map():
	return "SELECT * FROM " + map_table + " WHERE name = ?;"