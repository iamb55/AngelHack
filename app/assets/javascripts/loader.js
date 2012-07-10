var Loader = function() {

	var loaded = false;

	var loadStack = [];
	
	var execLoadStack = function() {
	  for(var i = 0; i < loadStack.length; i++) {
	    var loadable = loadStack[i];
      // try {
      loadable();
      // } catch(e) {
      //   console.log(e);
      // }
	  }

		loaded = true;

	};

	return {
		waitForDOM: function() {
			
			$(document).ready(execLoadStack);

		},
		register: function(fn)
		{
			if (loaded) fn();
			else {
  			loadStack.push( fn );
  			return 1;
			}
		}
	};
}();

Loader.waitForDOM();
