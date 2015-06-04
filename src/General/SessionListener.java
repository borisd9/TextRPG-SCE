package General;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;


public class SessionListener implements HttpSessionAttributeListener{
	
	private List<String> users = new ArrayList<String>();
	

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		String attr = (String) session.getAttribute("username");
		if(attr != null && !users.contains(attr)){
			users.add(attr); 
			session.setAttribute("online", this); 
		}
		
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		String attr = event.getValue().toString();
		if(attr != null && users.contains(attr)){
			users.remove(attr);
		}
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {		
	}
	
	public List getList(){
		return users;
	}

}
