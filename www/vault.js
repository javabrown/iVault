 /*
 * @author Raja Khan
 * */

	var exec = require('cordova/exec');

	var Vault=function(){
	};

	Vault.prototype.get = function( successCallback, errorCallback) 
	{
		return cordova.exec(successCallback, errorCallback, "Vault", "get", [{"KEY":key}]);
	};

	Vault.prototype.set = function(value, successCallback, errorCallback) 
	{
		return cordova.exec(successCallback, errorCallback, "Vault", "set", [{"KEY":key, "VALUE":value}]);
	};
 
	module.exports= new Vault();
