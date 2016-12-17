 /*
 * @author Raja Khan
 * */

	var exec = require('cordova/exec');

	var Vault=function(){
	};

	Vault.prototype.get = function( successCallback, errorCallback) 
	{
		return cordova.exec(successCallback, errorCallback, "Vault", "get", [key]);
	};

	Vault.prototype.set = function(value, successCallback, errorCallback) 
	{
		return cordova.exec(successCallback, errorCallback, "Vault", "set", [key, value]);
	};
 
	module.exports= new Vault();
