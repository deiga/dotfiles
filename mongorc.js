host = db.serverStatus().host;
prompt = function() {
	return db+"@"+host+"$ ";
}