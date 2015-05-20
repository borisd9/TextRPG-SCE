package General;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener; 
import javax.servlet.http.HttpSession; 

import java.util.List; 
import java.util.ArrayList; 

public class SessionHandler implements HttpSessionAttributeListener  { 
	
	private List<String> users = new ArrayList<String>(); 
	
	public SessionHandler() { 
	} 
	
	public List<String> getList(){
		return users;
	}

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
	public void attributeRemoved(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}
} 