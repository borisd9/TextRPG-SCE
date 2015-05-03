function ValidateEmail(inputText)
	{
		var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		if(inputText.value.match(mailformat))
		{
		document.form1.text1.focus();
		return true;
		}
		else
		{
		alert("You have entered an invalid email address!");
		document.form1.text1.focus();
		return false;
		}
	}


function validateForm() {
    var x = document.forms["form1"]["user"].value;
    var y = document.forms["form1"]["pwd"].value;
    if (x == null || x == "" || y=="") {
        alert("Username and Password must be filled out");
        return false;
    }
}
