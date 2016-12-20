phonegap-plugin-vault
==========================

A phonegap 3.x plugin to store and retrieve sercure data such as password, credit-card data into keychain of ios plateform.


:warning: Report issues on the [Apache Cordova issue tracker](https://issues.apache.org/jira/browse/CB-9966)


Installing
======
You may use phonegap CLI as follows:

<pre>
➜ phonegap local plugin add https://github.com/javabrown/vault.git
[phonegap] adding the plugin: https://github.com/javabrown/vault.git
[phonegap] successfully added the plugin
</pre>


##iOS keychain internal design 
![](https://raw.githubusercontent.com/javabrown/iOS-Keychain-Plugin/master/example/icons/keychain-design.png "iOS keychain internal design ")


Using
====
The code below can be placed into script tag.

```javascript
		document.addEventListener('deviceready', onDeviceReady);
		function onDeviceReady() {
			window.vault = cordova.require("cordova.plugin.vault.vault");
		}
		function store(key, value) {
			vault.set(key, value, win, fail);
		}
		function retrieve(key) {
			keychain.get(win, fail);
		}
		function win(status) {
			alert('Message: ' + status);
		}
		function fail(status) {
			alert('Error: ' + status);
		}
```